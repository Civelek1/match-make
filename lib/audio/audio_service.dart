import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../settings/settings_service.dart';

enum Sfx {
  click,
  swap,
  invalid,
  match,
  combo,
  rocket,
  bomb,
  colorBomb,
  objectiveComplete,
  restore,
  levelComplete,
  levelFailed,
  galleryUnlock,
  star,
  unlock,
  locked,
}

enum MusicTrack { menu, gameplay }

/// Asset mapping kept separate from playback so sounds can be replaced by
/// dropping new files in assets/audio (same names) or editing this table.
class AudioAssets {
  static String sfx(Sfx s) => 'audio/sfx_${s.name}.wav';
  static String music(MusicTrack t) => 'audio/music_${t.name}.wav';
}

abstract class AudioService {
  void play(Sfx sfx);
  void playMusic(MusicTrack track);
  void pauseAll();
  void resumeAll();
  void dispose();
}

/// audioplayers-backed implementation. Every call is fire-and-forget and
/// swallows platform errors: missing audio must never break the game.
class GameAudioService implements AudioService {
  final SettingsService settings;
  final List<AudioPlayer> _sfxPool = [];
  int _next = 0;
  AudioPlayer? _music;
  MusicTrack? _wantedTrack;
  MusicTrack? _playingTrack;
  bool _suspended = false;
  final Map<Sfx, DateTime> _lastPlayed = {};

  GameAudioService(this.settings) {
    settings.addListener(_onSettings);
    try {
      for (var i = 0; i < 6; i++) {
        _sfxPool.add(AudioPlayer()..setReleaseMode(ReleaseMode.stop));
      }
      _music = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      debugPrint('Audio unavailable: $e');
    }
  }

  void _onSettings() {
    if (!settings.music) {
      _stopMusic();
    } else if (_wantedTrack != null && _playingTrack != _wantedTrack) {
      playMusic(_wantedTrack!);
    }
  }

  @override
  void play(Sfx sfx) {
    if (!settings.sfx || _sfxPool.isEmpty || _suspended) return;
    // Throttle identical sounds fired in the same frame burst.
    final now = DateTime.now();
    final last = _lastPlayed[sfx];
    if (last != null && now.difference(last).inMilliseconds < 45) return;
    _lastPlayed[sfx] = now;
    final p = _sfxPool[_next];
    _next = (_next + 1) % _sfxPool.length;
    unawaited(
      _safe(() async {
        await p.stop();
        await p.play(AssetSource(AudioAssets.sfx(sfx)), volume: sfx == Sfx.click ? 0.5 : 0.8);
      }),
    );
    // Browsers only allow audio after a gesture; retry music on first click.
    if (sfx == Sfx.click && _wantedTrack != null && _playingTrack == null) {
      playMusic(_wantedTrack!);
    }
  }

  @override
  void playMusic(MusicTrack track) {
    _wantedTrack = track;
    if (!settings.music || _music == null || _suspended) return;
    if (_playingTrack == track) return;
    _playingTrack = track;
    unawaited(
      _safe(() async {
        await _music!.stop();
        await _music!.play(AssetSource(AudioAssets.music(track)), volume: 0.35);
      }, onError: () => _playingTrack = null),
    );
  }

  void _stopMusic() {
    _playingTrack = null;
    if (_music != null) unawaited(_safe(() => _music!.stop()));
  }

  @override
  void pauseAll() {
    _suspended = true;
    if (_music != null) unawaited(_safe(() => _music!.pause()));
  }

  @override
  void resumeAll() {
    _suspended = false;
    if (settings.music && _playingTrack != null && _music != null) {
      unawaited(_safe(() => _music!.resume()));
    } else if (_wantedTrack != null) {
      playMusic(_wantedTrack!);
    }
  }

  Future<void> _safe(Future<void> Function() f, {VoidCallback? onError}) async {
    try {
      await f();
    } catch (e) {
      onError?.call();
      debugPrint('Audio error: $e');
    }
  }

  @override
  void dispose() {
    settings.removeListener(_onSettings);
    for (final p in _sfxPool) {
      p.dispose();
    }
    _music?.dispose();
  }
}

/// Silent implementation for tests.
class SilentAudioService implements AudioService {
  @override
  void play(Sfx sfx) {}
  @override
  void playMusic(MusicTrack track) {}
  @override
  void pauseAll() {}
  @override
  void resumeAll() {}
  @override
  void dispose() {}
}
