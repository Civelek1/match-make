// Generates the original procedural placeholder sounds (no longer shipped: the
// game now uses licensed audio, see docs/AUDIO_CREDITS.md). Writes to
// build/audio_placeholders/ so it never overwrites the real assets:
//   dart run tool/generate_audio.dart
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

const sr = 22050;
final rng = Random(42);

class Buf {
  final Float64List s;
  final bool loop;
  Buf(double seconds, {this.loop = false}) : s = Float64List((seconds * sr).round());

  void add(int i, double v) {
    if (loop) {
      s[i % s.length] += v;
    } else if (i >= 0 && i < s.length) {
      s[i] += v;
    }
  }
}

double note(num semisFromA4) => 440.0 * pow(2, semisFromA4 / 12);

/// Additive voice with an attack/decay envelope.
void voice(
  Buf b,
  double start,
  double dur,
  double freq, {
  double amp = 0.3,
  String wave = 'sine',
  double attack = 0.005,
  double release = 0.1,
  double freqEnd = -1,
  double vibrato = 0,
}) {
  final n = ((dur + release) * sr).round();
  final i0 = (start * sr).round();
  var phase = 0.0;
  for (var k = 0; k < n; k++) {
    final t = k / sr;
    final f = freqEnd > 0 ? freq + (freqEnd - freq) * min(1.0, t / dur) : freq;
    phase += 2 * pi * f * (1 + vibrato * sin(2 * pi * 5.5 * t)) / sr;
    double w;
    switch (wave) {
      case 'tri':
        w = 2 / pi * asin(sin(phase));
      case 'square':
        w = (sin(phase) >= 0 ? 1 : -1) * 0.5 + sin(phase) * 0.3;
      case 'bell':
        w = sin(phase) + 0.45 * sin(phase * 2.01) * exp(-t * 6) + 0.25 * sin(phase * 3.98) * exp(-t * 10);
      case 'pluck':
        w = sin(phase) * 0.7 + 0.3 * sin(phase * 2) * exp(-t * 12);
      default:
        w = sin(phase);
    }
    double env;
    if (t < attack) {
      env = t / attack;
    } else if (t < dur) {
      env = 1.0 - 0.3 * (t - attack) / max(0.0001, dur - attack);
    } else {
      env = 0.7 * exp(-(t - dur) / max(0.001, release) * 3);
    }
    b.add(i0 + k, w * env * amp);
  }
}

void noise(Buf b, double start, double dur, {double amp = 0.3, double decay = 8, double lowpass = 0.5}) {
  final n = (dur * sr).round();
  final i0 = (start * sr).round();
  var last = 0.0;
  for (var k = 0; k < n; k++) {
    final t = k / sr;
    final raw = rng.nextDouble() * 2 - 1;
    last = last + lowpass * (raw - last);
    b.add(i0 + k, last * amp * exp(-t * decay));
  }
}

void writeWav(String path, Buf b, {double gain = 1}) {
  var peak = 0.0;
  for (final v in b.s) {
    peak = max(peak, v.abs());
  }
  final norm = peak > 0 ? min(1.0, 0.89 / peak) * gain : 1.0;
  final data = ByteData(44 + b.s.length * 2);
  void str(int o, String s) {
    for (var i = 0; i < s.length; i++) {
      data.setUint8(o + i, s.codeUnitAt(i));
    }
  }

  str(0, 'RIFF');
  data.setUint32(4, 36 + b.s.length * 2, Endian.little);
  str(8, 'WAVE');
  str(12, 'fmt ');
  data.setUint32(16, 16, Endian.little);
  data.setUint16(20, 1, Endian.little);
  data.setUint16(22, 1, Endian.little);
  data.setUint32(24, sr, Endian.little);
  data.setUint32(28, sr * 2, Endian.little);
  data.setUint16(32, 2, Endian.little);
  data.setUint16(34, 16, Endian.little);
  str(36, 'data');
  data.setUint32(40, b.s.length * 2, Endian.little);
  for (var i = 0; i < b.s.length; i++) {
    final v = (b.s[i] * norm).clamp(-1.0, 1.0);
    data.setInt16(44 + i * 2, (v * 32767).round(), Endian.little);
  }
  File(path).writeAsBytesSync(data.buffer.asUint8List());
  stdout.writeln('wrote $path (${(data.lengthInBytes / 1024).round()} KB)');
}

void main() {
  final dir = Directory('build/audio_placeholders')..createSync(recursive: true);
  String p(String name) => '${dir.path}/$name.wav';

  // --- SFX -------------------------------------------------------------------
  writeWav(p('sfx_click'), Buf(0.08)..let((b) => voice(b, 0, 0.02, 1500, amp: 0.4, release: 0.04, freqEnd: 1100)), gain: 0.7);
  writeWav(
    p('sfx_swap'),
    Buf(0.18)..let((b) {
      voice(b, 0, 0.09, 380, wave: 'tri', freqEnd: 760, release: 0.06, amp: 0.3);
      noise(b, 0, 0.12, amp: 0.08, decay: 20, lowpass: 0.2);
    }),
    gain: 0.7,
  );
  writeWav(
    p('sfx_invalid'),
    Buf(0.3)..let((b) {
      voice(b, 0, 0.07, 240, wave: 'square', release: 0.04, amp: 0.2);
      voice(b, 0.1, 0.1, 190, wave: 'square', release: 0.06, amp: 0.2);
    }),
    gain: 0.6,
  );
  writeWav(
    p('sfx_match'),
    Buf(0.35)..let((b) {
      voice(b, 0, 0.05, note(15), wave: 'pluck', release: 0.18, amp: 0.35);
      voice(b, 0.045, 0.05, note(22), wave: 'pluck', release: 0.2, amp: 0.3);
      noise(b, 0, 0.05, amp: 0.1, decay: 60, lowpass: 0.8);
    }),
  );
  writeWav(
    p('sfx_combo'),
    Buf(0.5)..let((b) {
      for (var i = 0; i < 4; i++) {
        voice(b, i * 0.05, 0.05, note(15 + [0, 4, 7, 12][i]), wave: 'bell', release: 0.2, amp: 0.28);
      }
    }),
  );
  writeWav(
    p('sfx_rocket'),
    Buf(0.55)..let((b) {
      noise(b, 0, 0.5, amp: 0.45, decay: 5, lowpass: 0.35);
      voice(b, 0, 0.35, 300, wave: 'tri', freqEnd: 1400, release: 0.1, amp: 0.25);
    }),
  );
  writeWav(
    p('sfx_bomb'),
    Buf(0.8)..let((b) {
      voice(b, 0, 0.35, 110, freqEnd: 38, release: 0.35, amp: 0.8);
      noise(b, 0, 0.7, amp: 0.55, decay: 6, lowpass: 0.12);
      noise(b, 0, 0.08, amp: 0.3, decay: 30, lowpass: 0.9);
    }),
  );
  writeWav(
    p('sfx_colorBomb'),
    Buf(1.0)..let((b) {
      voice(b, 0, 0.6, 400, wave: 'tri', freqEnd: 1600, release: 0.2, amp: 0.2, vibrato: 0.02);
      for (var i = 0; i < 14; i++) {
        voice(b, i * 0.045, 0.04, note(24 + rng.nextInt(14)), wave: 'bell', release: 0.25, amp: 0.14);
      }
      noise(b, 0, 0.6, amp: 0.15, decay: 5, lowpass: 0.6);
    }),
  );
  writeWav(
    p('sfx_objectiveComplete'),
    Buf(0.9)..let((b) {
      for (final (i, s) in [(0, 3), (1, 7), (2, 10)]) {
        voice(b, i * 0.08, 0.12, note(s), wave: 'pluck', release: 0.3, amp: 0.3);
      }
      voice(b, 0.26, 0.3, note(15), wave: 'bell', release: 0.4, amp: 0.3);
      voice(b, 0.26, 0.3, note(10), wave: 'tri', release: 0.4, amp: 0.15);
    }),
  );
  writeWav(
    p('sfx_restore'),
    Buf(0.7)..let((b) {
      for (var i = 0; i < 6; i++) {
        voice(b, i * 0.05, 0.05, note(22 + [0, 3, 7, 10, 14, 19][i]), wave: 'bell', release: 0.3, amp: 0.2);
      }
    }),
    gain: 0.8,
  );
  writeWav(
    p('sfx_levelComplete'),
    Buf(2.0)..let((b) {
      const mel = [3, 7, 10, 15, 14, 15, 19];
      const dur = [0.12, 0.12, 0.12, 0.28, 0.12, 0.12, 0.6];
      var t = 0.0;
      for (var i = 0; i < mel.length; i++) {
        voice(b, t, dur[i], note(mel[i]), wave: 'pluck', release: 0.25, amp: 0.32);
        voice(b, t, dur[i], note(mel[i] - 12), wave: 'tri', release: 0.25, amp: 0.14);
        t += dur[i];
      }
      for (final s in [-9, -5, -2]) {
        voice(b, 1.0, 0.6, note(s), wave: 'tri', release: 0.4, amp: 0.12);
      }
    }),
  );
  writeWav(
    p('sfx_levelFailed'),
    Buf(1.3)..let((b) {
      for (final (i, s) in [(0, 2), (1, -1), (2, -5)]) {
        voice(b, i * 0.25, 0.22, note(s), wave: 'tri', release: 0.3, amp: 0.3, vibrato: 0.01);
      }
      voice(b, 0.75, 0.4, note(-8), wave: 'tri', release: 0.3, amp: 0.3, vibrato: 0.015);
    }),
  );
  writeWav(
    p('sfx_galleryUnlock'),
    Buf(1.2)..let((b) {
      for (var i = 0; i < 8; i++) {
        voice(b, i * 0.06, 0.08, note(19 + [0, 5, 9, 12, 17, 21, 24, 29][i]), wave: 'bell', release: 0.45, amp: 0.16);
      }
      voice(b, 0, 0.8, note(7), wave: 'tri', release: 0.3, amp: 0.1);
    }),
    gain: 0.85,
  );
  writeWav(
    p('sfx_star'),
    Buf(0.5)..let((b) {
      voice(b, 0, 0.08, note(22), wave: 'bell', release: 0.35, amp: 0.35, freqEnd: note(27));
      voice(b, 0.03, 0.08, note(34), wave: 'bell', release: 0.3, amp: 0.15);
    }),
  );
  writeWav(
    p('sfx_unlock'),
    Buf(0.8)..let((b) {
      noise(b, 0, 0.04, amp: 0.3, decay: 60, lowpass: 0.9);
      voice(b, 0.03, 0.05, 900, wave: 'square', release: 0.03, amp: 0.15);
      for (var i = 0; i < 3; i++) {
        voice(b, 0.12 + i * 0.07, 0.08, note(17 + [0, 5, 12][i]), wave: 'bell', release: 0.35, amp: 0.25);
      }
    }),
  );
  writeWav(
    p('sfx_locked'),
    Buf(0.25)..let((b) {
      voice(b, 0, 0.05, 160, wave: 'tri', release: 0.08, amp: 0.4, freqEnd: 120);
      noise(b, 0, 0.05, amp: 0.2, decay: 50, lowpass: 0.3);
    }),
    gain: 0.7,
  );

  // --- Music -------------------------------------------------------------------
  writeWav(
    p('music_menu'),
    _song(
      bpm: 96,
      bars: 8,
      seed: 3,
      drums: false,
      chordsSemis: const [
        [-9, -5, -2], // C
        [-12, -9, -5], // Am
        [-16, -12, -9], // F
        [-14, -10, -7], // G
      ],
    ),
    gain: 0.9,
  );
  writeWav(
    p('music_gameplay'),
    _song(
      bpm: 118,
      bars: 8,
      seed: 9,
      drums: true,
      chordsSemis: const [
        [-9, -5, -2], // C
        [-14, -10, -7], // G
        [-12, -9, -5], // Am
        [-16, -12, -9], // F
      ],
    ),
    gain: 0.9,
  );
}

/// Loopable song: soft pads, bass, pentatonic melody, optional light drums.
Buf _song({required int bpm, required int bars, required int seed, required bool drums, required List<List<int>> chordsSemis}) {
  final beat = 60 / bpm;
  final len = beat * 4 * bars;
  final b = Buf(len, loop: true);
  final r = Random(seed);
  const penta = [3, 5, 7, 10, 12, 15, 17, 19, 22];
  var melIdx = 4;
  for (var bar = 0; bar < bars; bar++) {
    final chord = chordsSemis[bar % chordsSemis.length];
    final t0 = bar * beat * 4;
    for (final s in chord) {
      voice(b, t0, beat * 3.6, note(s), wave: 'tri', attack: 0.3, release: 0.5, amp: 0.07, vibrato: 0.003);
    }
    // Bass on beats 1 and 3.
    voice(b, t0, beat * 0.9, note(chord[0] - 12), wave: 'tri', release: 0.15, amp: 0.2);
    voice(b, t0 + beat * 2, beat * 0.9, note(chord[0] - 12), wave: 'tri', release: 0.15, amp: 0.18);
    // Melody: eighth-note grid with rests, stepwise motion.
    for (var e = 0; e < 8; e++) {
      if (r.nextDouble() < (drums ? 0.35 : 0.5)) continue;
      melIdx = (melIdx + r.nextInt(3) - 1).clamp(0, penta.length - 1);
      voice(b, t0 + e * beat / 2, beat * 0.35, note(penta[melIdx]), wave: 'pluck', release: 0.25, amp: 0.13);
    }
    if (drums) {
      for (var q = 0; q < 4; q++) {
        final t = t0 + q * beat;
        if (q.isEven) voice(b, t, 0.06, 120, freqEnd: 50, release: 0.08, amp: 0.35);
        if (q.isOdd) noise(b, t, 0.12, amp: 0.12, decay: 25, lowpass: 0.5);
        noise(b, t + beat / 2, 0.04, amp: 0.06, decay: 80, lowpass: 0.95);
      }
    }
  }
  return b;
}

extension Let<T> on T {
  T let(void Function(T) f) {
    f(this);
    return this;
  }
}
