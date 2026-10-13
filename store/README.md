# Mağaza görselleri

| Dosya | Kullanım |
|---|---|
| `play_icon_512.png` | Play Console → Uygulama simgesi (512×512) |
| `feature_graphic_tr.png`, `feature_graphic_en.png` | Öne çıkan görsel (1024×500) |
| `screenshots/tr/*.jpg`, `screenshots/en/*.jpg` | Telefon ekran görüntüleri (1080×1920, 7'şer adet) |
| `listing/tr.md`, `listing/en.md` | Uygulama adı, kısa ve tam açıklama |

## Yeniden üretmek

Görseller oyunun kendisi çalıştırılarak üretilir; oyun görünümü değişince aynı komutlarla yenilenir:

```bash
flutter test tool/icons/render_icons_test.dart && python3 tool/icons/finish_icons.py
flutter test --dart-define=MM_HIDE_DEBUG=true tool/store/screenshots_test.dart
python3 tool/store/compose_store_art.py
```

Başlıklar `tool/store/compose_store_art.py` içindeki `CAPTIONS` tablosundadır.
