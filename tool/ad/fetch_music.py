"""Downloads the cinematic reel music options (tool/ad/MUSIC.md) from Freesound
into build/ad/music/<tag>.mp3. All CC0.

    python3 tool/ad/fetch_music.py
"""
import os
import re
import subprocess
import time

TRACKS = {  # tag: (Freesound user, sound id, start second used in the reel)
    'v1_epic_intro': ('MichaelMalong', '360740', 0),
    'v2_uplifting_dramatic': ('MusicByMisterbates', '608811', 66.5),
    'v3_epic_orchestra': ('edtijo', '218744', 147.5),
    'v4_slow_cinematic': ('DeVern', '384202', 1),
}

os.makedirs('build/ad/music', exist_ok=True)
for tag, (user, sid, start) in TRACKS.items():
    for attempt in range(4):  # Freesound sometimes answers rapid requests with a bare page
        page = subprocess.run(['curl', '-sSL', '--max-time', '30', f'https://freesound.org/s/{sid}/'],
                              capture_output=True, text=True).stdout
        m = re.search(rf'previews/[0-9]+/{sid}_[0-9]+-[hl]q\.mp3', page)
        if m:
            break
        time.sleep(3 * (attempt + 1))
    url = 'https://cdn.freesound.org/' + m[0].replace('-lq.mp3', '-hq.mp3')
    subprocess.run(['curl', '-sS', '--retry', '3', '--max-time', '300', '-o', f'build/ad/music/{tag}.mp3', url], check=True)
    print(f'build/ad/music/{tag}.mp3  start={start}')
