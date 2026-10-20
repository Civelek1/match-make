# Para kazanma — kurulum ve canlıya geçiş

## Oyunda ne var
| Özellik | Nerede | Ödül |
|---|---|---|
| Ödüllü reklam: devam | Hamle bitince | +5 hamle (deneme başına 1 kez) |
| Ödüllü reklam: altın | Mağaza → Ücretsiz Altın | +50 altın, günde 3 kez |
| Ödüllü reklam: 2 kat | Günlük ödül alındıktan sonra | Günün ödülü bir kez daha |
| Altın paketleri | Mağaza | `coins_500`, `coins_1200`, `coins_3000` (tüketilebilir) |
| Başlangıç Paketi | Mağaza (alınınca kaybolur) | `starter_pack`: 1000 altın + her güçlendiriciden 3 (tek seferlik) |
| Reklamsız | Mağaza | `no_ads`: tüm reklam ödülleri reklamsız ve anında (tek seferlik) |

Zorunlu (geçiş) reklam yok. Reklamlar PG içerik sınırıyla istenir.

## Şu an: TEST kimlikleri
- Reklamlar Google'ın herkese açık test kimlikleriyle çalışır: gerçek test reklamı görünür, para kazandırmaz.
- TEST APK'da (MM_DEBUG) ürünler Play Console'da yoksa sahte mağaza devreye girer: fiyatlar "(test)" yazar, satın alma ücretsiz ve anında olur.
- Normal APK'da ürünler Play Console'da tanımlı değilse mağaza paketleri görünmez.

## Gerçeğe geçiş
1. **AdMob:** uygulamayı ekle (Android ve iOS ayrı), birer **Ödüllü** reklam birimi oluştur.
2. **Android uygulama kimliği:** derlerken `-PADMOB_APP_ID=ca-app-pub-XXXX~YYYY` (veya `android/gradle.properties` içine `ADMOB_APP_ID=...`).
3. **iOS uygulama kimliği:** `ios/Runner/Info.plist` → `GADApplicationIdentifier`.
4. **Reklam birimleri:** `--dart-define=ADMOB_REWARDED_ANDROID=ca-app-pub-.../...` ve `--dart-define=ADMOB_REWARDED_IOS=...`
   Örnek: `flutter build appbundle --release -PADMOB_APP_ID=... --dart-define=ADMOB_REWARDED_ANDROID=...`
5. **AdMob → Gizlilik ve mesajlaşma:** AB/GDPR izin mesajını (ve iOS için IDFA açıklamasını) yayınla. Oyun bu formu kendisi gösterir.
6. **app-ads.txt:** AdMob'un verdiği satırı geliştirici web sitenin kökünde yayınla.
7. **Play Console → Para kazanma → Ürünler:** yukarıdaki 5 kimliği oluştur. `coins_*` tüketilebilir; `starter_pack`, `no_ads` tek seferlik. Fiyatları sen belirlersin.
8. **App Store Connect:** aynı kimliklerle (tüketilebilir / tüketilemez) ürünler ve "Paid Apps" sözleşmesi.

## Play Console formları
- **Reklam içeriyor mu:** Evet. **Reklam kimliği kullanılıyor mu:** Evet (Reklam/pazarlama).
- **Veri güvenliği (AdMob SDK için):** Cihaz veya diğer kimlikler (reklam kimliği), yaklaşık konum (IP), uygulama etkileşimleri, teşhis verileri; amaç: reklam, analiz, dolandırıcılık önleme; Google ile paylaşılır; aktarımda şifreli. Google'ın güncel "AdMob veri güvenliği" rehberiyle karşılaştır.
- **Hedef kitle:** 13+ öner (çocuklara yönelik seçilirse reklam kuralları çok sıkılaşır).
- **İçerik derecelendirmesi:** reklam ve uygulama içi satın alma: evet.

## Bilinen sınırlar
- Satın almalar cihazda doğrulanır (sunucu yok); küçük bir oyun için yaygın, ama hileye karşı tam koruma sağlamaz.
- Gerçek reklam/satın alma akışı ancak gerçek bir Android/iOS cihazda denenebilir.
