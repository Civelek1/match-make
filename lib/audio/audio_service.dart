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
  static String music(MusicTrack t) => 'audio/music_${t.name}.mp3';
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
///
/// Each sound effect owns a few players with its file loaded once up front, so
/// playing a sound only restarts it (no file loading on the hot path, which
/// made short sounds drop out). On Android they use the low-latency SoundPool.
/// Music commands run one after another so quick screen changes can't leave
/// the music player stopped or on the wrong track.
class GameAudioService implements AudioService {
  final SettingsService settings;

  /// Simultaneous copies for sounds that can overlap in a cascade.
  static const _voices = {
    Sfx.match: 3,
    Sfx.combo: 3,
    Sfx.star: 3,
    Sfx.swap: 2,
    Sfx.click: 2,
    Sfx.rocket: 2,
    Sfx.bomb: 2,
    Sfx.colorBomb: 2,
    Sfx.objectiveComplete: 2,
  };

  final Map<Sfx, List<AudioPlayer>> _sfx = {};
  final Map<Sfx, Future<void>> _ready = {};
  final Map<Sfx, int> _nextVoice = {};
  final Map<Sfx, DateTime> _lastPlayed = {};
  AudioPlayer? _music;
  Future<void> _musicQueue = Future.value();
  MusicTrack? _wantedTrack;
  MusicTrack? _playingTrack;
  bool _suspended = false;

  GameAudioService(this.settings) {
    settings.addListener(_onSettings);
    try {
      // Don't request audio focus: otherwise every sound effect takes focus
      // from the music player (which then pauses) and from other apps.
      final focus = _safe(
        () => AudioPlayer.global.setAudioContext(AudioContextConfig(focus: AudioContextConfigFocus.mixWithOthers).build()),
      );
      final lowLatency = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
      for (final sfx in Sfx.values) {
        final players = [for (var i = 0; i < (_voices[sfx] ?? 1); i++) AudioPlayer()];
        _sfx[sfx] = players;
        _ready[sfx] = focus.then(
          (_) => _safe(() async {
            for (final p in players) {
              await p.setReleaseMode(ReleaseMode.stop);
              if (lowLatency) await p.setPlayerMode(PlayerMode.lowLatency);
              await p.setVolume(_volume(sfx));
              await p.setSource(AssetSource(AudioAssets.sfx(sfx)));
            }
          }),
        );
      }
      _music = AudioPlayer();
      _musicQueue = focus.then((_) => _safe(() => _music!.setReleaseMode(ReleaseMode.loop)));
    } catch (e) {
      debugPrint('Audio unavailable: $e');
    }
  }

  static double _volume(Sfx sfx) => sfx == Sfx.click ? 0.6 : 0.85;

  void _onSettings() {
    if (!settings.music) {
      _stopMusic();
    } else if (_wantedTrack != null && _playingTrack != _wantedTrack) {
      playMusic(_wantedTrack!);
    }
  }

  @override
  void play(Sfx sfx) {
    final players = _sfx[sfx];
    if (!settings.sfx || players == null || _suspended) return;
    // Throttle identical sounds fired in the same frame burst.
    final now = DateTime.now();
    final last = _lastPlayed[sfx];
    if (last != null && now.difference(last).inMilliseconds < 45) return;
    _lastPlayed[sfx] = now;
    final i = _nextVoice[sfx] ?? 0;
    _nextVoice[sfx] = (i + 1) % players.length;
    final p = players[i];
    unawaited(
      _safe(() async {
        await _ready[sfx];
        // stop() rewinds (and clears a finished SoundPool stream) so resume()
        // always starts the sound from the beginning.
        await p.stop();
        await p.resume();
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
    _enqueueMusic(() async {
      // A newer request may have replaced this one while it waited.
      if (_wantedTrack != track || _playingTrack != track || _suspended) return;
      await _music!.stop();
      await _music!.play(AssetSource(AudioAssets.music(track)), volume: 0.45);
    }, onError: () {
      if (_playingTrack == track) _playingTrack = null;
    });
  }

  void _enqueueMusic(Future<void> Function() f, {VoidCallback? onError}) {
    _musicQueue = _musicQueue.then((_) => _safe(f, onError: onError));
  }

  void _stopMusic() {
    _playingTrack = null;
    if (_music != null) _enqueueMusic(() => _music!.stop());
  }

  @override
  void pauseAll() {
    _suspended = true;
    if (_music != null) _enqueueMusic(() => _music!.pause());
  }

  @override
  void resumeAll() {
    _suspended = false;
    if (!settings.music || _music == null) return;
    if (_playingTrack != null && _playingTrack == _wantedTrack) {
      _enqueueMusic(() => _music!.resume());
    } else if (_wantedTrack != null) {
      _playingTrack = null;
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
    for (final players in _sfx.values) {
      for (final p in players) {
        p.dispose();
      }
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
