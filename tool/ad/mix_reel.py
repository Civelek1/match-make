"""Mixes the reel soundtrack and muxes it with the recorded video.

    python3 tool/ad/mix_reel.py [music.mp3 start_seconds tag]

With no arguments the default music bed below is used; otherwise the given
track is played from start_seconds and the output gets a _<tag> suffix.

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
MUSIC, START, TAG = (sys.argv[1], float(sys.argv[2]), '_' + sys.argv[3]) if len(sys.argv) > 3 else ('tool/ad/reel_music.mp3', 0.0, '')
# The default dance bed is ducked under the opening; cinematic tracks keep
# their own dynamics.
VOLUME = "if(lt(t,3),0.4,0.55)" if not TAG else "0.6"

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
        graph.append(f'[{i + 2}:a]adelay={ms}|{ms},volume={vol}[s{i}]')
        labels.append(f'[s{i}]')
    graph.append(f"{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=first,"
                 f"atrim=0:{LEN},loudnorm=I=-14:TP=-1.5[a]")
    out = f'build/ad/MatchMake_reel_{lang}{TAG}.mp4'
    subprocess.run(['ffmpeg', '-y', '-v', 'error', *inputs, '-filter_complex', ';'.join(graph),
                    '-map', '0:v', '-map', '[a]', '-c:v', 'copy', '-c:a', 'aac', '-b:a', '192k',
                    '-ar', '48000', '-shortest', '-movflags', '+faststart', out], check=True)
    print(out, f'{len(cues)} sound cues')
