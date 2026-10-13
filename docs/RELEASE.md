# Match Make — Yayın kılavuzu (CiTu Studios)

Bu belge oyunu Google Play'e yüklemek için gereken adımları sırasıyla anlatır.

| Bilgi | Değer |
|---|---|
| Uygulama adı | Match Make |
| Geliştirici | CiTu Studios |
| Paket adı (applicationId) | `com.citustudios.matchmake` — ilk yüklemeden sonra **değiştirilemez** |
| iOS bundle id | `com.citustudios.matchmake` |
| Sürüm | `pubspec.yaml` → `version: 1.0.0+1` (ad + derleme numarası) |
| Hedef / en düşük Android | API 36 / API 24 (Android 7.0) |

## 1. Yükleme anahtarı (bir kez)

Play'e gönderilen her paket aynı "yükleme anahtarı" ile imzalanmalıdır.

```bash
keytool -genkey -v -keystore android/upload-keystore.jks -keyalg RSA -keysize 2048 \
  -validity 10000 -alias upload
cp android/key.properties.example android/key.properties   # şifreleri doldurun
```

- `upload-keystore.jks` ve `key.properties` git'e **eklenmez** (`android/.gitignore`).
- Bu iki dosyanın ve şifrelerin yedeğini güvenli bir yerde (şifre yöneticisi + bulut) saklayın.
- Play Console'da **Play App Signing** açık olduğu sürece (yeni uygulamalarda varsayılan) asıl imza anahtarını Google saklar; yükleme anahtarı kaybolursa Play Console'dan sıfırlatılabilir.
- `key.properties` yoksa release derlemesi debug anahtarıyla imzalanır; bu paket Play'e yüklenemez.

## 2. Paket derleme

```bash
flutter test                       # 131+ test geçmeli
flutter build appbundle --release  # build/app/outputs/bundle/release/app-release.aab
```

Her güncellemede `pubspec.yaml` içindeki derleme numarasını artırın (`1.0.1+2`, `1.1.0+3` …). Play aynı numarayı ikinci kez kabul etmez.

Telefonda doğrudan denemek için: `flutter build apk --release --split-per-abi` (arm64 APK çoğu telefon için yeterli).

## 3. Play Console

1. **Uygulama oluştur:** Ad "Match Make", varsayılan dil Türkçe (veya İngilizce), Oyun, Ücretsiz.
2. **Mağaza girişi:** `store/listing/tr.md` ve `en.md` metinleri; ikon `store/play_icon_512.png`; öne çıkan görsel `store/feature_graphic_tr.png` / `_en.png`; ekran görüntüleri `store/screenshots/`.
3. **Gizlilik politikası URL'si:** `docs/privacy-policy.html` herkese açık bir adreste yayınlanmalı (ör. GitHub Pages: depo ayarları → Pages → `docs/` klasörü). Önce sayfadaki iletişim e-postasını doldurun.
4. **Veri güvenliği formu:** "Uygulama kullanıcı verisi toplamıyor veya paylaşmıyor." Oyun internet izni bile istemez; ilerleme yalnızca cihazda saklanır.
5. **İçerik derecelendirmesi (IARC anketi):** Şiddet, kumar, kullanıcı etkileşimi, konum paylaşımı yok → genelde "3+ / PEGI 3" çıkar.
6. **Hedef kitle:** 13 yaş altını seçerseniz Aile Politikası geçerli olur. Oyunda reklam ve veri toplama olmadığı için uyumludur; ileride reklam eklenirse yalnızca Aile sertifikalı reklam ağları kullanılabilir.
7. **Reklam içeriyor mu:** Hayır. **Uygulama içi satın alma:** Hayır.
8. **Test:** Yeni kişisel geliştirici hesaplarında üretime çıkmadan önce kapalı testte en az 12 test kullanıcısıyla 14 gün test zorunludur. Kurumsal hesaplarda bu şart yoktur. Önce "Dahili test"e yükleyip kendi telefonunuzda deneyin.
9. **Üretim:** Kademeli yayın (%10 → %50 → %100) önerilir.

## 4. Mağaza görsellerini yeniden üretmek

- İkonlar: `flutter test tool/icons/render_icons_test.dart && python3 tool/icons/finish_icons.py`
- Ekran görüntüleri ve öne çıkan görsel: `store/README.md`

## 5. iOS (ileride)

Bundle id hazır. Mac + Xcode + Apple Developer hesabı ile `flutter build ipa` yapılır; ilk kez gerçek bir iPhone'da test edilmelidir.
