"""Frames the raw screenshots with a caption and builds the feature graphic.

Run after tool/store/screenshots_test.dart:
    python3 tool/store/compose_store_art.py
Output: store/screenshots/<lang>/*.jpg (1080×1920) and store/feature_graphic_<lang>.png (1024×500).
"""
import os
import shutil
from PIL import Image, ImageDraw, ImageFilter, ImageFont

RAW = 'build/store_raw'
FLUTTER_ROOT = os.environ.get('FLUTTER_ROOT') or os.path.dirname(os.path.dirname(os.path.realpath(shutil.which('flutter') or 'flutter')))
FONT = os.path.join(FLUTTER_ROOT, 'bin/cache/artifacts/material_fonts/Roboto-Black.ttf')
INK = (59, 42, 90)
TOP, BOTTOM = (111, 203, 255), (42, 111, 214)

CAPTIONS = {
    'tr': {
        '01_menu': 'Mekânları yeniden canlandır!',
        '02_play': 'Eşleştir, patlat, yenile!',
        '03_map': '10 mekân, 50 seviye',
        '04_keys': 'Anahtarları aşağı indir!',
        '05_gallery': 'Önce ve sonrası galerinde',
        '06_win': 'Yıldızları topla',
        '07_daily': 'Her gün yeni ödüller',
    },
    'en': {
        '01_menu': 'Bring places back to life!',
        '02_play': 'Match, blast and restore!',
        '03_map': '10 locations, 50 levels',
        '04_keys': 'Guide the keys down!',
        '05_gallery': 'Every before & after',
        '06_win': 'Collect the stars',
        '07_daily': 'New rewards every day',
    },
}


def gradient(w, h, top, bottom):
    g = Image.new('RGB', (1, h))
    for y in range(h):
        t = y / max(1, h - 1)
        g.putpixel((0, y), tuple(round(a + (b - a) * t) for a, b in zip(top, bottom)))
    return g.resize((w, h))


def outlined_text(img, xy, text, font, fill=(255, 255, 255), stroke=INK, width=10, anchor='mm'):
    d = ImageDraw.Draw(img)
    x, y = xy
    d.text((x, y + width * 0.6), text, font=font, fill=stroke, stroke_width=width, stroke_fill=stroke, anchor=anchor)
    d.text((x, y), text, font=font, fill=fill, stroke_width=width, stroke_fill=stroke, anchor=anchor)


def fit_font(text, max_w, size):
    while size > 40:
        f = ImageFont.truetype(FONT, size)
        if ImageDraw.Draw(Image.new('RGB', (1, 1))).textlength(text, font=f) <= max_w:
            return f
        size -= 4
    return ImageFont.truetype(FONT, size)


def rounded(img, r):
    m = Image.new('L', img.size, 0)
    ImageDraw.Draw(m).rounded_rectangle((0, 0, img.width - 1, img.height - 1), r, fill=255)
    img.putalpha(m)
    return img


def frame(raw_path, caption, out_path):
    W, H = 1080, 1920
    canvas = gradient(W, H, TOP, BOTTOM).convert('RGBA')
    glow = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(glow).ellipse((-300, -500, 900, 700), fill=(255, 230, 168, 90))
    canvas = Image.alpha_composite(canvas, glow.filter(ImageFilter.GaussianBlur(120)))
    outlined_text(canvas, (W // 2, 150), caption, fit_font(caption, W - 120, 92))

    shot = Image.open(raw_path).convert('RGBA')
    sh = 1600
    sw = round(shot.width * sh / shot.height)
    shot = rounded(shot.resize((sw, sh), Image.LANCZOS), 56)
    x, y = (W - sw) // 2, 270
    shadow = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle((x, y + 24, x + sw, y + sh + 24), 56, fill=(20, 10, 40, 120))
    canvas = Image.alpha_composite(canvas, shadow.filter(ImageFilter.GaussianBlur(28)))
    border = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(border).rounded_rectangle((x - 10, y - 10, x + sw + 10, y + sh + 10), 64, fill=(255, 255, 255, 255))
    canvas = Image.alpha_composite(canvas, border)
    canvas.alpha_composite(shot, (x, y))
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    canvas.convert('RGB').save(out_path, quality=92, optimize=True)


def feature_graphic(tagline, out_path):
    W, H = 1024, 500
    bg = Image.open(f'{RAW}/en/05_gallery.png').convert('RGB')
    # The restored room from the gallery, blurred, as the backdrop.
    room = bg.crop((40, 260, 1040, 880)).resize((W, round(W * 620 / 1000)))
    room = room.crop((0, (room.height - H) // 2, W, (room.height - H) // 2 + H)).filter(ImageFilter.GaussianBlur(6))
    canvas = room.convert('RGBA')
    shade = gradient(W, H, (42, 111, 214), (31, 60, 140)).convert('RGBA')
    shade.putalpha(150)
    canvas = Image.alpha_composite(canvas, shade)
    logo = Image.open(f'{RAW}/logo.png').convert('RGBA')
    bbox = logo.getbbox()
    logo = logo.crop(bbox)
    lw = 600
    logo = logo.resize((lw, round(logo.height * lw / logo.width)), Image.LANCZOS)
    canvas.alpha_composite(logo, ((W - lw) // 2, 40))
    font = ImageFont.truetype(FONT, 40)
    outlined_text(canvas, (W // 2, H - 60), tagline, font, width=6)
    canvas.convert('RGB').save(out_path, optimize=True)


if __name__ == '__main__':
    for lang, caps in CAPTIONS.items():
        for name, cap in caps.items():
            frame(f'{RAW}/{lang}/{name}.png', cap, f'store/screenshots/{lang}/{name}.jpg')
    feature_graphic('Eşleştir · Yenile · Rahatla', 'store/feature_graphic_tr.png')
    feature_graphic('Match · Restore · Relax', 'store/feature_graphic_en.png')
    print('ok')
