"""Mixes the reel soundtrack and muxes it with the recorded video.

    python3 tool/ad/mix_reel.py [music.mp3 start_seconds tag] [--vo voice.mp3]

With no arguments the default music bed below is used; otherwise the given
track is played from start_seconds and the output gets a _<tag> suffix.
--vo takes one voice-over take of the four script lines (tool/ad/voiceover.py):
it is split at its three longest pauses, each line starts on its scene (sped
up slightly if it would overrun), the music ducks under the voice, and the
output gets a _vo suffix.

Music bed (tool/ad/reel_music.mp3: "Beach Dance" by szegvari, Freesound
#607304, CC0 — no credit needed) + every sound the game played while recording,
at the exact time it played (build/ad/reel_<lang>_events.json), plus a whoosh
on the cut into gameplay. Output: build/ad/MatchMake_reel_<lang>.mp4
"""
import json
import os
import subprocess
import sys

AUDIO = 'assets/audio'
LEN = 15.0
args = sys.argv[1:]
VO = None
if '--vo' in args:
    VO = args[args.index('--vo') + 1]
    del args[args.index('--vo'):args.index('--vo') + 2]
MUSIC, START, TAG = (args[0], float(args[1]), '_' + args[2]) if len(args) > 2 else ('tool/ad/reel_music.mp3', 0.0, '')
# The default dance bed is ducked under the opening; cinematic tracks keep
# their own dynamics.
VOLUME = "if(lt(t,3),0.4,0.55)" if not TAG else "0.6"

# Voice-over lines start on their scenes: neglected room, gameplay,
# restoration, logo. Second value: the longest the line may run.
VO_SLOTS = [(0.25, 2.8), (3.15, 3.9), (7.15, 4.8), (12.3, 2.6)]


def split_voice(path):
    """Cuts one take into four lines at its three longest pauses."""
    import numpy as np
    sr = 44100
    raw = subprocess.run(['ffmpeg', '-v', 'quiet', '-i', path, '-ac', '1', '-ar', str(sr), '-f', 's16le', '-'],
                         capture_output=True, check=True).stdout
    x = np.frombuffer(raw, np.int16).astype(np.float64) / 32768
    hop = sr // 50
    db = np.array([20 * np.log10(np.sqrt(np.mean(x[i:i + hop] ** 2)) + 1e-9) for i in range(0, len(x) - hop, hop)])
    loud = db > db.max() - 38
    idx = np.where(loud)[0]
    first, last = idx[0], idx[-1]
    gaps, run = [], None
    for i in range(first, last + 1):
        if not loud[i]:
            run = i if run is None else run
        elif run is not None:
            gaps.append((i - run, run, i))
            run = None
    cuts = sorted(sorted(gaps, reverse=True)[:3], key=lambda g: g[1])
    if len(cuts) < 3:
        sys.exit(f'Voice-over: expected 4 lines separated by pauses, found {len(cuts) + 1}.')
    bounds = [first] + [c for g in cuts for c in (g[1], g[2])] + [last + 1]
    os.makedirs('build/ad/vo/lines', exist_ok=True)
    lines = []
    for k in range(4):
        a, b = bounds[2 * k], bounds[2 * k + 1]
        seg = x[max(0, a * hop - 1500): min(len(x), b * hop + 3000)]
        dur = len(seg) / sr
        tempo = min(1.2, max(1.0, dur / VO_SLOTS[k][1]))
        out = f'build/ad/vo/lines/line_{k + 1}.wav'
        subprocess.run(['ffmpeg', '-y', '-v', 'error', '-f', 's16le', '-ar', str(sr), '-ac', '1', '-i', '-',
                        '-af', f'atempo={tempo:.3f}', out], input=(seg * 32767).astype(np.int16).tobytes(), check=True)
        lines.append((out, VO_SLOTS[k][0]))
        print(f'  line {k + 1}: {dur:.2f}s at {VO_SLOTS[k][0]}s' + (f' (sped up x{tempo:.2f})' if tempo > 1 else ''))
    return lines


VO_LINES = split_voice(VO) if VO else []

for lang in ('tr', 'en'):
    video = f'build/ad/reel_{lang}_video.mp4'
    if not os.path.exists(video):
        continue
    events = json.load(open(f'build/ad/reel_{lang}_events.json'))
    events.append({'t': 2.9, 's': 'swap'})          # cut into gameplay
    events.append({'t': 12.0, 's': 'restore'})      # room reveal
    # Drop repeats of one sound within 80 ms (several stages can land at once).
    cues, last = [], {}
    for e in sorted(events, key=lambda e: e['t']):
        if e['t'] - last.get(e['s'], -1) < 0.08:
            continue
        last[e['s']] = e['t']
        cues.append(e)

    inputs = ['-i', video, '-ss', str(START), '-i', MUSIC]
    graph = [
        # Quieter under the opening, full from the cut, fade out at the end.
        f"[1:a]atrim=0:{LEN},asetpts=PTS-STARTPTS,volume='{VOLUME}':eval=frame,"
        f"afade=t=in:d=0.6,afade=t=out:st={LEN - 1.2}:d=1.2[m]"
    ]
    labels = ['[m]']
    for i, e in enumerate(cues):
        inputs += ['-i', f"{AUDIO}/sfx_{e['s']}.wav"]
        ms = int(e['t'] * 1000)
        vol = 0.9 if e['s'] in ('levelComplete', 'rocket', 'objectiveComplete') else 0.75
        if VO_LINES:
            vol *= 0.7
        graph.append(f'[{i + 2}:a]adelay={ms}|{ms},volume={vol}[s{i}]')
        labels.append(f'[s{i}]')
    if VO_LINES:
        # Voice lines, merged; the music ducks whenever someone speaks.
        n0 = len(cues) + 2
        vo_labels = []
        for k, (path, at) in enumerate(VO_LINES):
            inputs += ['-i', path]
            ms = int(at * 1000)
            graph.append(f'[{n0 + k}:a]adelay={ms}|{ms},apad=whole_dur={LEN}[v{k}]')
            vo_labels.append(f'[v{k}]')
        graph.append(f"{''.join(vo_labels)}amix=inputs={len(vo_labels)}:normalize=0,volume=1.6,asplit=2[vo][vokey]")
        graph.append('[m][vokey]sidechaincompress=threshold=0.02:ratio=8:attack=15:release=350[md]')
        labels[0] = '[md]'
        labels.append('[vo]')
    graph.append(f"{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=first,"
                 f"atrim=0:{LEN},loudnorm=I=-14:TP=-1.5[a]")
    out = f"build/ad/MatchMake_reel_{lang}{TAG}{'_vo' if VO_LINES else ''}.mp4"
    subprocess.run(['ffmpeg', '-y', '-v', 'error', *inputs, '-filter_complex', ';'.join(graph),
                    '-map', '0:v', '-map', '[a]', '-c:v', 'copy', '-c:a', 'aac', '-b:a', '192k',
                    '-ar', '48000', '-shortest', '-movflags', '+faststart', out], check=True)
    print(out, f'{len(cues)} sound cues')
