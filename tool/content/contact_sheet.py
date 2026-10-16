"""Packs a rendered batch into one sheet per chapter for quick review.

    python3 tool/content/contact_sheet.py <N>

Reads build/batch_render/b<N>/*.png (from render_batch_test.dart) and writes
build/batch_render/b<N>/sheet_<chapter>.png:
  top row    map half-restored, map fully restored, the 5 boards
  bottom row the 5 fully restored scenes (cropped from the gallery screen)
"""
import glob
import os
import sys

from PIL import Image

N = sys.argv[1]
d = f'build/batch_render/b{N}'
W, H, GAP = 270, 480, 8

levels = sorted(glob.glob(f'{d}/*_scene.png'), key=lambda f: int(os.path.basename(f).split('_')[0]))
maps = [os.path.basename(m)[:-len('_map_done.png')] for m in glob.glob(f'{d}/*_map_done.png')]
# Chapters render in order; pair them with consecutive groups of 5 levels.
order = sorted(maps, key=lambda m: os.path.getmtime(f'{d}/{m}_map_done.png'))

for ci, ch in enumerate(order):
    group = levels[ci * 5:(ci + 1) * 5]
    cols = 7
    sw = (cols * W + (cols - 1) * GAP - 4 * GAP) // 5
    scene_imgs = []
    for f in group:
        im = Image.open(f).convert('RGB')
        crop = im.crop((0, int(im.height * 0.05), im.width, int(im.height * 0.47)))
        scene_imgs.append(crop.resize((sw, int(crop.height * sw / crop.width))))
    sh = max((s.height for s in scene_imgs), default=0)
    sheet = Image.new('RGB', (cols * W + (cols - 1) * GAP, H + GAP + sh), (30, 30, 30))
    sheet.paste(Image.open(f'{d}/{ch}_map_half.png').convert('RGB').resize((W, H)), (0, 0))
    sheet.paste(Image.open(f'{d}/{ch}_map_done.png').convert('RGB').resize((W, H)), (W + GAP, 0))
    for i, f in enumerate(group):
        b = f.replace('_scene.png', '_board.png')
        if os.path.exists(b):
            sheet.paste(Image.open(b).convert('RGB').resize((W, H)), ((i + 2) * (W + GAP), 0))
    for i, s in enumerate(scene_imgs):
        sheet.paste(s, (i * (sw + GAP), H + GAP))
    out = f'{d}/sheet_{ch}.png'
    sheet.save(out)
    print(out)
