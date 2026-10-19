"""Builds every app icon from the mascot artwork (tool/icons/mascot_source.jpg).

    python3 tool/icons/make_icons.py

The source is drawn on pure black: the black is keyed out (its soft halo kept
as partial alpha) to get a transparent mascot, which is then placed on the
game-blue background for launcher, store, web and splash icons.
"""
from collections import deque
import numpy as np
from PIL import Image, ImageDraw

SRC = 'tool/icons/mascot_source.jpg'
TOP, BOTTOM = (0x7F, 0xD6, 0xFF), (0x2F, 0x8C, 0xF0)   # game-blue gradient


def cutout():
    im = np.asarray(Image.open(SRC).convert('RGB')).astype(np.float32)
    h, w, _ = im.shape
    lum = im.max(axis=2)
    # Flood fill the dark background from the border (stops at the outline).
    outside = np.zeros((h, w), bool)
    q = deque([(y, x) for x in range(w) for y in (0, h - 1)] + [(y, x) for y in range(h) for x in (0, w - 1)])
    while q:
        y, x = q.popleft()
        if outside[y, x] or lum[y, x] > 46:
            continue
        outside[y, x] = True
        if y > 0: q.append((y - 1, x))
        if y < h - 1: q.append((y + 1, x))
        if x > 0: q.append((y, x - 1))
        if x < w - 1: q.append((y, x + 1))
    # The soft halo becomes a clean navy edge (the JPEG noise in it looked smoky).
    alpha = np.ones((h, w), np.float32)
    a = np.clip((lum - 8) / 30, 0, 1) ** 1.4
    alpha[outside] = a[outside]
    rgb = im.copy()
    rgb[outside] = (22, 19, 58)
    out = np.dstack([rgb, alpha * 255]).astype(np.uint8)
    img = Image.fromarray(out, 'RGBA')
    return img.crop(img.getchannel('A').point(lambda v: 255 if v > 8 else 0).getbbox())


def background(size):
    t = np.linspace(0, 1, size)[:, None, None]
    g = (np.array(TOP) * (1 - t) + np.array(BOTTOM) * t).repeat(size, axis=1)
    return Image.fromarray(g.astype(np.uint8), 'RGB').convert('RGBA')


def place(canvas, mascot, frac, dy=0.0):
    s = canvas.size[0]
    m = mascot.copy()
    m.thumbnail((int(s * frac), int(s * frac)), Image.LANCZOS)
    canvas.alpha_composite(m, ((s - m.width) // 2, (s - m.height) // 2 + int(dy * s)))
    return canvas


def rounded(img, r):
    mask = Image.new('L', img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, img.size[0] - 1, img.size[1] - 1], int(img.size[0] * r), fill=255)
    img.putalpha(mask)
    return img


def full(size, frac=0.84, r=None, rgb=False):
    img = place(background(size * 2), M, frac).resize((size, size), Image.LANCZOS)
    if r:
        img = rounded(img, r)
    return img.convert('RGB') if rgb else img


M = cutout()
M.resize((round(M.width * 560 / M.height), 560), Image.LANCZOS).save('assets/images/mascot.png', optimize=True)  # in-game
res = 'android/app/src/main/res'
for name, d in {'mdpi': 1, 'hdpi': 1.5, 'xhdpi': 2, 'xxhdpi': 3, 'xxxhdpi': 4}.items():
    full(round(48 * d), r=0.2).save(f'{res}/mipmap-{name}/ic_launcher.png', optimize=True)
    fg = round(108 * d)
    place(Image.new('RGBA', (fg * 2, fg * 2), (0, 0, 0, 0)), M, 0.6).resize((fg, fg), Image.LANCZOS).save(
        f'{res}/mipmap-{name}/ic_launcher_foreground.png', optimize=True)
    background(fg).convert('RGB').save(f'{res}/mipmap-{name}/ic_launcher_background.png', optimize=True)
# Android splash: the icon sits in a circle showing 2/3 of the image.
place(Image.new('RGBA', (768, 768), (0, 0, 0, 0)), M, 0.58).save(f'{res}/drawable-nodpi/splash_icon.png', optimize=True)

ios = 'ios/Runner/Assets.xcassets/AppIcon.appiconset'
for name, px in [('20x20@1x', 20), ('20x20@2x', 40), ('20x20@3x', 60), ('29x29@1x', 29), ('29x29@2x', 58),
                 ('29x29@3x', 87), ('40x40@1x', 40), ('40x40@2x', 80), ('40x40@3x', 120), ('60x60@2x', 120),
                 ('60x60@3x', 180), ('76x76@1x', 76), ('76x76@2x', 152), ('83.5x83.5@2x', 167), ('1024x1024@1x', 1024)]:
    full(px, rgb=True).save(f'{ios}/Icon-App-{name}.png', optimize=True)   # App Store: no alpha

full(192, r=0.2).save('web/icons/Icon-192.png', optimize=True)
full(512, r=0.2).save('web/icons/Icon-512.png', optimize=True)
full(192, frac=0.66).save('web/icons/Icon-maskable-192.png', optimize=True)
full(512, frac=0.66).save('web/icons/Icon-maskable-512.png', optimize=True)
full(64, frac=0.9, r=0.2).save('web/favicon.png', optimize=True)
full(512, rgb=True).save('store/play_icon_512.png', optimize=True)
print('mascot', M.size)
