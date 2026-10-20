# Promo reel (15 s, 9:16) — how to rebuild it

Everything is recorded from the real game; build/ is not in git, so a fresh
checkout regenerates the pieces first.

1. Record the picture (about 1.5 min each, run separately):

       flutter test --dart-define=MM_HIDE_DEBUG=true tool/ad/reel_test.dart --name "reel tr"
       flutter test --dart-define=MM_HIDE_DEBUG=true tool/ad/reel_test.dart --name "reel en"

2. Music (all CC0, see MUSIC.md): `python3 tool/ad/fetch_music.py`
   → build/ad/music/v1..v4 (cinematic). The default dance bed is in git.

3. Voice-over (optional, ElevenLabs): with `ELEVENLABS_API_KEY` set in the
   environment settings, `python3 tool/ad/voiceover.py 4` finds four energetic
   Turkish voices and reads the script with each → build/ad/vo/<n>_<voice>.mp3.
   The script (one take, blank lines = pauses between the four scenes):

       Bu eve yıllardır kimse dokunmadı...
       Taşları eşleştir, kombolar patlat...
       ...ve her hamlede evin yeniden hayat bulsun.
       Meç Meyk. Eşleştir, yenile, tekrarla.

4. Mix:

       python3 tool/ad/mix_reel.py                                   # dance bed
       python3 tool/ad/mix_reel.py build/ad/music/v2_uplifting_dramatic.mp3 66.5 v2
       python3 tool/ad/mix_reel.py build/ad/music/v2_uplifting_dramatic.mp3 66.5 v2 --vo build/ad/vo/1_Name.mp3

   → build/ad/MatchMake_reel_<lang>[_tag][_vo].mp4. Run with `< /dev/null`
   inside shell loops (ffmpeg reads stdin).

Status (Oct 2026): the owner picked cinematic music; the preferred version
is not chosen yet (v2 suggested). Next step: voice-over samples once the
ElevenLabs key is set, the owner picks a voice, then mix it with the music.
