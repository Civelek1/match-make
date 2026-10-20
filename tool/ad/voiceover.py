"""Finds energetic Turkish voices in the ElevenLabs voice library and voices
the reel script with each, so one can be picked by ear.

    ELEVENLABS_API_KEY=... python3 tool/ad/voiceover.py [count]

Writes build/ad/vo/<n>_<voice>.mp3 (plus voices.json with names and links).
The key needs voice-library and text-to-speech access.
"""
import json
import os
import sys
import urllib.parse
import urllib.request

API = 'https://api.elevenlabs.io/v1'
KEY = os.environ.get('ELEVENLABS_API_KEY')
COUNT = int(sys.argv[1]) if len(sys.argv) > 1 else 4
OUT = 'build/ad/vo'

# One take; blank lines become short pauses that split the four scenes.
SCRIPT = """Bu eve yıllardır kimse dokunmadı...

Taşları eşleştir, kombolar patlat...

...ve her hamlede evin yeniden hayat bulsun.

Meç Meyk. Eşleştir, yenile, tekrarla."""

WORDS = ('energetic', 'energy', 'upbeat', 'dynamic', 'enthusiastic', 'excited', 'lively', 'enerjik', 'hype')


def call(method, path, body=None, raw=False):
    req = urllib.request.Request(API + path, method=method, headers={'xi-api-key': KEY, 'Content-Type': 'application/json'},
                                 data=json.dumps(body).encode() if body is not None else None)
    with urllib.request.urlopen(req, timeout=120) as r:
        data = r.read()
    return data if raw else json.loads(data)


def main():
    if not KEY:
        sys.exit('ELEVENLABS_API_KEY is not set (add it in the environment settings).')
    found = {}
    for q in ('', 'energetic', 'advertisement', 'enerjik'):
        params = {'language': 'tr', 'page_size': 100, 'sort': 'usage_character_count_1y'}
        if q:
            params['search'] = q
        for v in call('GET', '/shared-voices?' + urllib.parse.urlencode(params)).get('voices', []):
            text = ' '.join(str(v.get(k) or '') for k in ('name', 'description', 'descriptive', 'use_case')).lower()
            if any(w in text for w in WORDS):
                found.setdefault(v['voice_id'], v)
    voices = sorted(found.values(), key=lambda v: -(v.get('usage_character_count_1y') or v.get('cloned_by_count') or 0))[:COUNT]
    if not voices:
        sys.exit('No energetic Turkish voices found.')
    os.makedirs(OUT, exist_ok=True)
    picked = []
    for i, v in enumerate(voices, 1):
        name = v['name']
        added = call('POST', f"/voices/add/{v['public_owner_id']}/{v['voice_id']}", {'new_name': f'MatchMake {name}'[:40]})
        audio = call('POST', f"/text-to-speech/{added['voice_id']}?output_format=mp3_44100_128", {
            'text': SCRIPT,
            'model_id': 'eleven_multilingual_v2',
            'voice_settings': {'stability': 0.4, 'similarity_boost': 0.75, 'style': 0.35, 'use_speaker_boost': True},
        }, raw=True)
        safe = ''.join(ch if ch.isalnum() else '_' for ch in name)[:30]
        path = f'{OUT}/{i}_{safe}.mp3'
        open(path, 'wb').write(audio)
        picked.append({'file': path, 'name': name, 'description': v.get('description'), 'voice_id': added['voice_id']})
        print(path, '-', name, '-', (v.get('description') or '')[:80])
    json.dump(picked, open(f'{OUT}/voices.json', 'w'), ensure_ascii=False, indent=1)


if __name__ == '__main__':
    main()
