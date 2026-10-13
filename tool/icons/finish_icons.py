"""App Store icons must not carry an alpha channel: flatten them to RGB."""
import glob
from PIL import Image

for p in glob.glob('ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png') + ['store/play_icon_512.png']:
    Image.open(p).convert('RGB').save(p, optimize=True)
