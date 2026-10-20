# Match Make — Oyunun Metin Hâli

CiTu Studios · 30 bölüm (mekân) · 150 seviye · Türkçe ve İngilizce

Bu dosya oyunun verisinden otomatik üretilir: `flutter test tool/content/export_text_test.dart`.

## 1. Oyun nedir?

Match Make, harap mekânları eşleştirme (match-3) oynayarak yeniden canlandırdığın bir bulmaca oyunudur. Her seviyenin üstünde bakımsız bir sahne (oda, bahçe, dükkân…) durur. Tahtada aynı türden 3 veya daha fazla parçayı yan yana getirdikçe görevler dolar ve sahnedeki eşyalar tek tek yenilenip yerine gelir. Seviye bitince sahne tamamen yenilenmiş olur ve galeriye eklenir. Her bölüm 5 seviyelik bir mekândır; bölümler resimli bir haritada açılır.

## 2. Nasıl oynanır?

- Yan yana iki parçayı kaydırarak yer değiştir; 3 veya daha fazla aynı parça yan yana gelirse patlar.
- Patlayan parçaların yerine üstten yenileri düşer; zincirleme patlamalar (kombo) ekstra puan verir.
- Her seviyenin sınırlı **hamle** sayısı ve 5–7 **görevi** vardır (ör. "15 kruvasan topla", "6 kasa kır", "2 anahtar indir").
- Hamleler bitmeden bütün görevleri tamamlarsan kazanırsın. Kalan hamleler bonus puana dönüşür.
- Puana göre 1–3 **yıldız** alınır: bitirmek 1 yıldız, 2 ve 3 yıldız için seviyeye özel puan sınırları vardır.
- Tahtalar her zaman kare değildir: L, U, T, artı, kalp, kum saati, halka, merdiven gibi şekiller vardır; boşluklardan taşlar aşağı düşmeye devam eder.

## 3. Özel parçalar

| Parça | Nasıl yapılır | Ne yapar |
|---|---|---|
| Roket | 4 parçayı yan yana eşleştir | Bütün bir sırayı veya sütunu temizler |
| Bomba | L veya T şeklinde eşleştir | Çevresindeki alanı patlatır |
| Renk Bombası | 5 parçayı yan yana eşleştir | Bir parçayla değiştirilince o türün hepsini temizler |

İki özel parçayı birbiriyle değiştirmek mega kombo yapar (ör. renk bombası + roket: o türün hepsi rokete dönüşür).

## 4. Engeller

| Engel | Açıklama |
|---|---|
| Kasa (1–3 kat) | Üzerinde taş olmaz; yanında eşleştirme yapınca bir kat kırılır |
| Buz (1–2 kat) | Altındaki hücrede eşleştirme yapınca çatlar |
| Zincir (1–2 kat) | Zincirli taş yer değiştiremez; eşleşmeye katılınca zincir kırılır |
| Anahtar | Tahtanın altına kadar indirilmesi gereken özel parça; en alttaki çıkışlardan çıkar (görev listesinde "Kapılar") |

## 5. Güçlendiriciler

| Güçlendirici | Ne yapar | Fiyat | Açıldığı seviye |
|---|---|---|---|
| Çekiç | İstediğin bir parçayı kır. Kasalara ve zincirlere de vurur. Hamle harcamaz. | 250 altın | 6 |
| Süpürge | Bütün bir sırayı süpür. Hamle harcamaz. | 300 altın | 9 |
| Karıştır | Serbest parçaların hepsini karıştır. Hamle harcamaz. | 150 altın | 4 |
| Roketle Başla | Seviyeye tahtada bir roketle başla. | 200 altın | 11 |
| Bombayla Başla | Seviyeye tahtada bir bombayla başla. | 250 altın | 13 |
| Renk Bombasıyla Başla | Seviyeye tahtada bir renk bombasıyla başla. | 400 altın | 16 |

Bir güçlendirici açıldığında 3 tane hediye edilir. Oyun içi güçlendiriciler hamle harcamaz; "…ile Başla" güçlendiricileri seviye başlamadan önce seçilir.

## 6. Ekonomi ve ödüller

- Yeni oyuncu 200 altınla başlar.
- Bir seviyeyi ilk kez bitirmek: 40 altın + yıldız başına 10 altın.
- Tekrar oynayıp bitirmek: 10 altın; yeni kazanılan her yıldız için +15 altın.
- Bir bölümü ilk kez tamamlamak: 250 altın bonus.
- Kaybedince devam etmek: +5 hamle; fiyat sırayla 300 / 600 / 900 altın.
- Günlük ödül takvimi (7 gün, art arda girişte artar): 1. gün 50 altın, 2. gün 75 altın, 3. gün 1 Çekiç, 4. gün 100 altın, 5. gün 2 Karıştır, 6. gün 150 altın, 7. gün 250 altın + 1 Renk Bombasıyla Başla.
- Altınlar dükkânda güçlendirici almak için kullanılır. Gerçek parayla satın alma ve reklam yoktur.

## 7. Ekranlar

- **Yükleme ekranı:** maskot, logo, ilerleme çubuğu ve ipuçları.
- **Ana menü:** Oyna, bölüm seçimi, galeri, profil, dükkân, günlük ödül, ayarlar.
- **Bölüm haritası:** her mekânın resimli haritası; 5 seviye düğmesi, yıldızlar, kilitli seviyeler. Seviyeler bittikçe harita da yenilenir.
- **Oyun ekranı:** üstte yenilenen sahne, görev listesi ve hamle sayacı; altta tahta ve güçlendiriciler.
- **Galeri:** tamamlanan sahnelerin yenilenmiş hâlleri.
- **Profil:** isim (Kaydet butonu), avatar, toplam yıldız/puan, tamamlanan seviye sayısı.
- **Ayarlar:** müzik, ses efektleri, titreşim, dil (Türkçe/İngilizce), hakkında.

## 8. İpuçları (yükleme ekranında gösterilenler)

- Roket yapmak için 4 parçayı yan yana eşleştir.
- Bomba yapmak için L veya T şekli oluştur.
- Renk Bombası için 5 parçayı yan yana eşleştir!
- Mekanları tamamlayarak Galeri'nde aç.
- Mega kombo için iki özel parçayı birbiriyle değiştir.
- Kalan hamleler bonus puana dönüşür.
- 3 yıldızın hepsini almak için seviyeleri tekrar oyna.

## 9. Bölümler ve seviyeler

Tahta gösteriminde: `.` normal hücre, `#` hücre yok (tahtanın şekli), `c C B` kasa (1/2/3 kat), `i I` buz (1/2 kat), `l L` zincir (1/2 kat), `j J` buz + zincir.

### Bölüm 1 — EV

#### Seviye 1: BAHÇE

_Bakımsız bahçeyi yeniden canlandır._

- Hamle: 30 · Zorluk: Kolay · Tahta: 8×8
- Yıldız puanları: 2★ 24000, 3★ 33000
- Görevler: Çimen ×18, Çit ×20, Çiçekler ×15, Ağaçlar ×12, Bank ×10

#### Seviye 2: MUTFAK

_Eski mutfağı sıcacık bir yere dönüştür._

- Hamle: 28 · Zorluk: Kolay-Orta · Tahta: 8×8
- Yıldız puanları: 2★ 19000, 3★ 26000
- Tanıtılan özel parça: Roket
- Görevler: Dolaplar ×16, Tezgah ×16, Buzdolabı ×14, Masa ×14, Dekorasyon ×12

#### Seviye 3: BANYO

_Banyoyu yeniden pırıl pırıl yap._

- Hamle: 27 · Zorluk: Orta · Tahta: 8×8
- Yıldız puanları: 2★ 20000, 3★ 29000
- Tanıtılan özel parça: Bomba
- Görevler: Küvet ×18, Lavabo ×16, Ayna ×16, Dolap ×14, Bitkiler ×14

#### Seviye 4: OYUN ODASI

_En iyi oyun köşesini kur._

- Hamle: 26 · Zorluk: Orta · Tahta: 8×8
- Yıldız puanları: 2★ 20000, 3★ 28000
- Tanıtılan özel parça: Renk Bombası
- Görevler: Masa ×16, Oyun PC ×16, Sandalye ×15, Monitör ×15, RGB Işıklar ×14, Dekorasyon ×14

#### Seviye 5: ÇATI KATI

_Tozlu çatı katını gizli bir köşeye çevir._

- Hamle: 22 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 26000
- Görevler: Zemin ×15, Raflar ×14, Kutular ×14, Pencere ×13, Mobilya ×13, Dekorasyon ×13

```
##....##
#......#
........
........
........
........
........
........
```

### Bölüm 2 — ÇİFTLİK

#### Seviye 6: ÇİFTLİK AVLUSU

_Kasaları temizle ve eski çiftliği uyandır._

- Hamle: 30 · Zorluk: Kolay-Orta · Tahta: 8×8
- Yıldız puanları: 2★ 37500, 3★ 50000
- Görevler: Araba ×24, Çit ×24, Ekinler ×24, Gölet ×24, Ağaçlar ×24, Kasalar ×7

```
........
........
.c....c.
...cc...
........
.c....c.
...cc...
........
```

#### Seviye 7: AHIR

_Hayvanlara sıcak ve düzenli bir ahır ver._

- Hamle: 29 · Zorluk: Kolay-Orta · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23500, 3★ 30500
- Görevler: Hayvanlar ×14, Ahır Kapıları ×14, Saman ×14, Aletler ×14, Yalak ×14, Işıklar ×14, Kasalar ×8

```
###..###
##c..c##
#......#
..cCCc..
........
c......c
........
........
```

#### Seviye 8: KÜMES

_Tavuklar dönebilsin diye kümesi onar._

- Hamle: 29 · Zorluk: Orta · Tahta: 8×8
- Yıldız puanları: 2★ 27500, 3★ 37000
- Görevler: Tavuklar ×18, Kümes ×18, Yumurtalar ×18, Yem ×18, Yalak ×18, Çiçekler ×18, Kasalar ×10

```
........
........
cC....Cc
........
...CC...
........
c......c
........
```

#### Seviye 9: ATÖLYE

_Aletleri ve makineleri yeniden çalıştır._

- Hamle: 27 · Zorluk: Orta · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Tezgah ×15, Alet Duvarı ×15, Tamirler ×15, Makineler ×15, Raflar ×15, Işıklar ×15, Kasalar ×10

```
.....###
...BB###
.....###
C...C###
........
..c..c..
........
........
```

#### Seviye 10: ÇİFTLİK EVİ

_Çiftlik evini yeniden sıcacık yap._

- Hamle: 30 · Zorluk: Orta · Tahta: 8×8
- Yıldız puanları: 2★ 28000, 3★ 36000
- Görevler: Veranda ×20, Şömine ×20, Yatak Odası ×20, Fırın İşleri ×20, Pencereler ×20, Bitkiler ×20, Kasalar ×13

```
........
cc....cc
........
..CBBC..
........
........
c......c
........
```

### Bölüm 3 — RESTORAN

#### Seviye 11: GİRİŞ

_Donmuş girişi çöz ve misafirleri karşıla._

- Hamle: 30 · Zorluk: Orta · Tahta: 8×8
- Yıldız puanları: 2★ 30000, 3★ 38000
- Görevler: Menü Tahtası ×19, Kapılar ×19, Tabela ×19, Saksılar ×19, Tente ×19, Işıklar ×19, Buz ×10

```
........
........
..iiii..
..i..i..
..i..i..
..iiii..
........
........
```

#### Seviye 12: MUTFAK

_Restoran mutfağında ocakları yak._

- Hamle: 30 · Zorluk: Orta · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23500, 3★ 34000
- Görevler: Tencereler ×12, Ocaklar ×12, Çatal Bıçak ×12, Otlar ×12, Buzdolabı ×12, Tabaklar ×12, Buz ×11

```
iI####Ii
..####..
..####..
...II...
........
........
i......i
ii....ii
```

#### Seviye 13: YEMEK SALONU

_Büyük yemek salonunda masaları kur._

- Hamle: 29 · Zorluk: Orta · Tahta: 8×8
- Yıldız puanları: 2★ 28000, 3★ 40000
- Görevler: Masalar ×18, Sandalyeler ×18, Şarap Rafı ×18, Bitkiler ×18, Bardaklar ×18, Avizeler ×18, Buz ×8

```
........
.I....I.
........
..c..c..
...II...
..c..c..
.i....i.
........
```

#### Seviye 14: TERAS

_Deniz kenarındaki güneşli terası aç._

- Hamle: 28 · Zorluk: Orta · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24500, 3★ 31000
- Görevler: Çiçekler ×14, Zemin ×14, Bar ×14, Saksılar ×14, Şemsiyeler ×14, Işıklar ×14, Buz ×11

```
##c..c##
##....##
.iiiiii.
........
...CC...
........
##iIIi##
##....##
```

#### Seviye 15: VIP ODA

_VIP odayı özel bir gece için hazırla._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 28000, 3★ 38000
- Görevler: Dekor ×17, Kanepeler ×17, Şampanya ×17, Piyano ×17, Sahne ×17, Perdeler ×17, Buz ×13

```
........
C.IIII.C
........
...cc...
i......i
........
I.iiii.I
........
```

### Bölüm 4 — SAHİL OTELİ

#### Seviye 16: PLAJ

_Plajı kurtar ve eğlenceyi geri getir._

- Hamle: 29 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 26000, 3★ 33000
- Görevler: Şemsiyeler ×17, Sörf Tahtaları ×17, Güneş Yatakları ×17, Palmiyeler ×17, Kıyı ×17, Kanolar ×17, Zincirler ×7

```
........
........
..l..l..
........
.l.ll.l.
........
..l..l..
........
```

#### Seviye 17: HAVUZ

_Havuzu doldur ve şezlongları diz._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 29500
- Görevler: Şezlonglar ×15, Havlular ×15, Meyve Suyu Barı ×15, Bitkiler ×15, Havuz ×15, Gölgelikler ×15, Zincirler ×5

```
........
.l....l.
..iiii..
..l##l..
..i##i..
.l....l.
........
........
```

#### Seviye 18: SAHİL BARI

_Gün batımında sahil barını yeniden aç._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 26500, 3★ 36000
- Görevler: Musluklar ×17, Tabureler ×17, Kokteyller ×17, Palmiyeler ×17, Dondurma ×17, Hoparlörler ×17, Zincirler ×6

```
c......c
........
..L..L..
........
...cc...
........
.l.ll.l.
........
```

#### Seviye 19: OTEL ODASI

_Otel odasını rüya gibi bir süite çevir._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 27000
- Görevler: Yatak ×14, Bavullar ×14, Oda Servisi ×14, Bitkiler ×14, Banyo ×14, Lambalar ×14, Zincirler ×6

```
...##...
.Li##iL.
...##...
c..jj..c
........
.l.##.l.
..I##I..
...##...
```

#### Seviye 20: ÇATI TERASI

_En iyi çatı partisini düzenle._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 28500, 3★ 36000
- Görevler: Parti Işıkları ×18, Kanepeler ×18, Kokteyller ×18, Saksılar ×18, Jakuzi ×18, Lambalar ×18, Zincirler ×6

```
C......C
.JI..IJ.
........
..LiiL..
........
.c....c.
..l..l..
........
```

### Bölüm 5 — MALİKANE

#### Seviye 21: ÖN BAHÇE

_Malikanenin görkemli ön bahçesini yenile._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 29000, 3★ 36000
- Görevler: Çiçekler ×19, Kapılar ×19, Heykeller ×19, Çitler ×19, Çeşme ×19, Lambalar ×19, Kasalar ×9

```
........
C.l..l.C
........
..iiii..
cc....cc
........
.C.ll.C.
........
```

#### Seviye 22: BÜYÜK SALON

_Büyük salonu yeniden parlat._

- Hamle: 30 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 26500, 3★ 32000
- Görevler: Dekor ×12, Merdiven ×12, Kupalar ×12, Zemin ×12, Pencereler ×12, Avizeler ×12, Buz ×9

```
##....##
#Ic..cI#
........
...LL...
........
iijjjjii
#......#
##....##
```

#### Seviye 23: LÜKS YATAK ODASI

_Gerçekten lüks bir yatak odası yarat._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 25000, 3★ 34000
- Görevler: Yatak ×17, Gardırop ×17, Lambalar ×17, Bitkiler ×17, Küvet ×17, Perdeler ×17, Zincirler ×8

```
........
.L.cc.L.
........
J..ii..J
........
.l.CC.l.
..l..l..
........
```

#### Seviye 24: SİNEMA ODASI

_Film gecesi için özel bir sinema kur._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 29000, 3★ 34500
- Görevler: Perde ×17, Koltuklar ×17, Film Makaraları ×17, Konsollar ×17, Projektör ×17, Hoparlörler ×17, Buz ×16

```
B......B
........
.IIIIII.
#......#
#.l..l.#
#......#
#iIIIIi#
#......#
```

#### Seviye 25: ÇATI KATI DAİRESİ

_Son meydan okuma: çatı katı dairesi!_

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23500, 3★ 32500
- Görevler: Parti Işıkları ×15, Kanepeler ×15, Şampanya ×15, Piyano ×15, Havuz ×15, Perdeler ×15, Zincirler ×9

```
#..##..#
........
.LJ..JL.
........
..iLLi..
#......#
##.jj.##
###..###
```

### Bölüm 6 — ŞATO

#### Seviye 26: ŞATO KAPISI

_Sancakları as, eski kapıyı aç._

- Hamle: 22 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Sancaklar ×14, Meşaleler ×14, Çitler ×14, Çeşme ×14, Işıklar ×14, Kapılar ×3

```
........
........
........
..c..c..
........
........
........
........
```

#### Seviye 27: ZİYAFET SALONU

_Kraliyet şöleni için uzun masayı kur._

- Hamle: 24 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 23500, 3★ 31000
- Görevler: Masalar ×15, Koltuklar ×15, Şarap Rafı ×15, Bardaklar ×15, Perdeler ×15, Sandıklar ×2, Buz ×6

```
........
.i....i.
........
..iiii..
........
.c....c.
........
........
```

#### Seviye 28: KÜTÜPHANE

_Bin yıllık hikâyelerin tozunu al._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 28500
- Görevler: Dekor ×13, Merdiven ×13, Kupalar ×13, Kitaplar ×13, Parşömenler ×13, Saatler ×13, Zincirler ×8

```
##....##
##l..l##
........
.l.LL.l.
........
........
##l..l##
##....##
```

#### Seviye 29: CEPHANELİK

_Kalkanları parlat, meşaleleri yak._

- Hamle: 24 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 24500, 3★ 30000
- Görevler: Sancaklar ×15, Kalkanlar ×15, Meşaleler ×15, Madalyalar ×15, Işıklar ×15, Sandıklar ×3, Kasalar ×8

```
........
........
c......c
...CC...
........
c......c
........
........
```

#### Seviye 30: TAHT ODASI

_Kraliyet tahtını altın günlerine kavuştur._

- Hamle: 24 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25500, 3★ 32000
- Görevler: Dekor ×15, Kalkanlar ×15, Heykeller ×15, Zemin ×15, Pencereler ×15, Perdeler ×15, Sandıklar ×3

```
.#.##.#.
.J....J.
........
..l..l..
..iiii..
..l..l..
........
........
```

### Bölüm 7 — DAĞ EVİ

#### Seviye 31: DAĞ EVİ GİRİŞİ

_Karları temizle, kayakçıları karşıla._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 26000, 3★ 31000
- Görevler: Kardan Adamlar ×15, Kayaklar ×15, Kızaklar ×15, Dağ Evi ×15, Buz Pisti ×15, Kapılar ×3, Buz ×5

```
........
........
.i....i.
........
..i..i..
........
.i....i.
........
```

#### Seviye 32: SALON

_Şömineyi yak, sıcak kakaoyu doldur._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 28000
- Görevler: Kanepeler ×13, Şömine ×13, Lambalar ×13, Zemin ×13, Pencereler ×13, Sıcak Kakao ×13, Buz ×4

```
........
..j..j..
........
i..ll..i
###.....
###..j..
###.....
###.....
```

#### Seviye 33: KAYAK ODASI

_Kayakları cilala, tahtaları diz._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 27000, 3★ 36500
- Görevler: Kayaklar ×15, Kızaklar ×15, Snowboardlar ×15, Patenler ×15, Işıklar ×15, Dolaplar ×3, Kasalar ×6

```
........
........
C......C
..l..l..
........
.c.LL.c.
........
........
```

#### Seviye 34: SPA

_Pistlerden sonra sıcak havuzu ısıt._

- Hamle: 38 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 31000, 3★ 38500
- Görevler: Çiçekler ×8, Havlular ×8, Meyve Suyu Barı ×8, Otlar ×8, Jakuzi ×8, Banyo Seti ×8, Buz ×8

```
........
#I....I#
##....##
##i..i##
##.ii.##
##....##
#I....I#
........
```

#### Seviye 35: DAĞ SÜİTİ

_Zirvelere bakan sıcacık bir süit._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 25500, 3★ 33500
- Görevler: Yatak ×16, Gardırop ×16, Lambalar ×16, Balkon ×16, Pencereler ×16, Perdeler ×16, Sandıklar ×3

```
........
..l..l..
........
J..cc..J
........
..l..l..
........
........
```

### Bölüm 8 — LİMAN

#### Seviye 36: İSKELE

_Tekneleri bağla, kargoyu indir._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Çapalar ×16, Tekneler ×16, Balık Tezgâhı ×16, Olta Takımı ×16, Kıyı ×16, Kargo ×16, Kasalar ×8

```
........
........
c......c
........
..cCCc..
........
c......c
........
```

#### Seviye 37: BALIK PAZARI

_Pazarda her sabah taze balık._

- Hamle: 22 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 28500
- Görevler: Menü Tahtası ×8, Tabureler ×8, Balık Tezgâhı ×8, Olta Takımı ×8, Tente ×8, Dolaplar ×3, Buz ×6

```
........
.i....i.
..j..j..
##....##
##.ii.##
##....##
##j..j##
##....##
```

#### Seviye 38: TEKNE HANGARI

_Gövdeleri onar, tekneleri denize indir._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 27500, 3★ 37500
- Görevler: Çapalar ×16, Tekneler ×16, Tamirler ×16, Aletler ×16, Kızak Yolu ×16, Kanolar ×16, Dolaplar ×3

```
........
........
l.c..c.l
........
..LccL..
........
l......l
........
```

#### Seviye 39: DENİZ FENERİ

_Gemilere yol gösteren feneri yeniden yak._

- Hamle: 22 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 31000
- Görevler: Çapalar ×13, Merdiven ×13, Fener Işığı ×13, Olta Takımı ×13, Kıyı ×13, Işıklar ×13, Kapılar ×3

```
##....##
##....##
##I..I##
#ci..ic#
........
..I..I..
........
........
```

#### Seviye 40: BEKÇİ EVİ

_Fener bekçisini evinde hissettir._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 26000, 3★ 31000
- Görevler: Mobilya ×17, Şömine ×17, Lambalar ×17, Fırın İşleri ×17, Haritalar ×17, Bitkiler ×17, Zincirler ×10

```
........
.l....l.
..J..J..
........
l..LL..l
........
..J..J..
........
```

### Bölüm 9 — MÜZE

#### Seviye 41: MÜZE GİRİŞİ

_Sütunları parlat, büyük kapıları aç._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 28000, 3★ 33000
- Görevler: Çiçekler ×16, Sütunlar ×16, Heykeller ×16, Çitler ×16, Çeşme ×16, Işıklar ×16, Kapılar ×3

```
........
........
.c....c.
..i..i..
...ii...
..i..i..
.c....c.
........
```

#### Seviye 42: HEYKEL SALONU

_Mermer devler gün yüzüne çıkmayı bekliyor._

- Hamle: 31 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 24500
- Görevler: Dekor ×13, Sütunlar ×13, Heykeller ×13, Zemin ×13, Pencereler ×13, Perdeler ×13, Zincirler ×10

```
........
l......l
.L#..#L.
..#..#..
.l#ll#l.
..#..#..
l.J..J.l
........
```

#### Seviye 43: SANAT GALERİSİ

_Başyapıtları as, ışığını iyi ayarla._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 23500, 3★ 31500
- Görevler: Tablolar ×17, Koltuklar ×17, Lambalar ×17, Fırçalar ×17, Çerçeveler ×17, Perdeler ×17, Buz ×9

```
........
.I....I.
........
..i..i..
c..ii..c
..i..i..
........
........
```

#### Seviye 44: TARİH SALONU

_Uzak diyarlardan haritalar, küreler ve hazineler._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 32000
- Görevler: Dekor ×13, Kalkanlar ×13, Sergiler ×13, Küreler ×13, Haritalar ×13, Saatler ×13, Vitrinler ×3

```
....####
..cc####
.l....l.
...CC...
.l....l.
..c..c..
####....
####....
```

#### Seviye 45: MÜZE KAFESİ

_Uzun bir turdan sonra kahve ve pasta._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 23500, 3★ 37500
- Görevler: Menü Tahtası ×17, Koltuklar ×17, Çatal Bıçak ×17, Fırın İşleri ×17, Bardaklar ×17, Sıcak Kakao ×17, Kasalar ×6

```
........
C......C
..j..j..
........
.c.jj.c.
........
..j..j..
........
```

### Bölüm 10 — TİYATRO

#### Seviye 46: TİYATRO GİRİŞİ

_Gala gecesi için tabelayı ışıklandır._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 26500, 3★ 36000
- Görevler: Afişler ×16, Biletler ×16, Tabela ×16, Çitler ×16, Tente ×16, Spot Işıkları ×16, Kapılar ×3

```
........
.i....i.
..c..c..
........
i.lccl.i
........
..c..c..
........
```

#### Seviye 47: BÜYÜK FUAYE

_Kırmızı halı, altın korkuluklar, parlayan kadehler._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 31000
- Görevler: Dekor ×12, Merdiven ×12, Şampanya ×12, Zemin ×12, Pencereler ×12, Perdeler ×12, Buz ×12

```
#####...
####...I
###..i..
##.II.j.
#.i..i..
I......I
........
........
```

#### Seviye 48: KULİS

_Kostümler, aynalar ve biraz sahne heyecanı._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 27500, 3★ 37500
- Görevler: Maskeler ×17, Gardırop ×17, Lambalar ×17, Mikrofonlar ×17, Çerçeveler ×17, Spot Işıkları ×17, Dolaplar ×3

```
........
.l....l.
..C..C..
........
l..jj..l
........
..c..c..
........
```

#### Seviye 49: KONSER SALONU

_Orkestra için piyanoyu akort et._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 25500, 3★ 32000
- Görevler: Maskeler ×17, Koltuklar ×17, Kupalar ×17, Piyano ×17, Notalar ×17, Spot Işıkları ×17, Zincirler ×6

```
........
l.c..c.l
........
.L.ii.L.
........
J.c..c.J
........
........
```

#### Seviye 50: BÜYÜK SAHNE

_Perde açılıyor! Son gösteri başlıyor._

- Hamle: 24 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 26500, 3★ 33000
- Görevler: Dekor ×15, Koltuklar ×15, Şampanya ×15, Mikrofonlar ×15, Notalar ×15, Perdeler ×15, Sandıklar ×3

```
##....##
#Jl..lJ#
#.c..c.#
#i.CC.i#
........
.l.ii.l.
........
........
```

### Bölüm 11 — PASTANE

#### Seviye 51: PASTANE ÖNÜ

_Köşedeki eski pastanenin kepenklerini aç._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21500, 3★ 33500
- Görevler: Ekmekler ×15, Hamur İşleri ×15, Tabela ×15, Pencereler ×15, Tente ×15, Kasalar ×6

```
###..###
##....##
#......#
.c....c.
........
..c..c..
c......c
........
```

#### Seviye 52: PASTANE MUTFAĞI

_Sabah ekmeği için taş fırını yak._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 24500
- Görevler: Fırınlar ×15, Ekmekler ×15, Hamur ×15, Yumurtalar ×15, Tabaklar ×15, Kasalar ×8

```
....####
..C.####
....####
.c..####
........
.C....C.
...cc...
........
```

#### Seviye 53: PASTA ATÖLYESİ

_Kocaman düğün pastasını süsle._

- Hamle: 22 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 17000, 3★ 23500
- Görevler: Pastalar ×12, Kurabiyeler ×12, Mikserler ×12, Dondurma ×12, Kasalar ×4, Buz ×4

```
#..##..#
.c....c.
...CC...
..i..i..
#I....I#
##....##
###..###
########
```

#### Seviye 54: UN DEPOSU

_Teslimattan önce un çuvallarını diz._

- Hamle: 22 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 23500, 3★ 29000
- Görevler: Un Çuvalları ×15, Kutular ×15, Ekmekler ×15, Raflar ×15, Kahve Çekirdeği ×15, Kasalar ×18

```
........
.B....B.
........
..cCCc..
........
c......c
...BB...
........
```

#### Seviye 55: KAFE TERASI

_Şemsiyelerin altında kahve ve kruvasan servis et._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21000, 3★ 27500
- Görevler: Şemsiyeler ×13, Hamur İşleri ×13, Kurabiyeler ×13, Bitkiler ×13, Kahve ×13, Kasalar ×6, Zincirler ×3

```
##....##
#l....l#
...CC...
..c..c..
..c..c..
........
#l....l#
##....##
```

### Bölüm 12 — SERA

#### Seviye 56: CAM SERA

_Eski camlı seranın buzlu camlarını sil._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21500, 3★ 30000
- Görevler: Pencereler ×13, Çiçekler ×13, Fideler ×13, Kompost ×13, Bitkiler ×13, Buz ×6

```
##....##
##....##
i......i
..i..i..
..i..i..
i......i
##....##
##....##
```

#### Seviye 57: ORKİDE ODASI

_Orkidelerin açtığı buğulu odayı ısıt._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 19000, 3★ 25500
- Görevler: Orkideler ×13, Nemlendiriciler ×13, Isıtıcılar ×13, Otlar ×13, Buz ×8

```
###..###
##....##
#I....I#
...ii...
...ii...
#I....I#
##....##
###..###
```

#### Seviye 58: FİDE MASALARI

_Saksı masalarına yeni fideler ek._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 18000, 3★ 22000
- Görevler: Fideler ×13, Çiçekler ×13, Arılar ×13, Sulama Kapları ×13, Buz ×6, Kasalar ×3

```
c..##..c
.i.##.i.
...##...
..i..i..
..i..i..
...##...
.i.##.i.
c..##..c
```

#### Seviye 59: PALMİYE EVİ

_Tropik palmiye kubbesine yeniden hayat ver._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 29000
- Görevler: Palmiyeler ×13, Isıtıcılar ×13, Nemlendiriciler ×13, Ağaçlar ×13, Buz ×8, Kapılar ×2

```
........
i.i..i.i
........
##....##
##I..I##
##....##
##i..i##
##....##
```

#### Seviye 60: GÖLETLİ BAHÇE

_Nilüferli göleti çöz, balıklar yüzsün._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 18000, 3★ 22000
- Görevler: Gölet ×12, Nilüferler ×12, Çeşme ×12, Çit ×12, Buz ×10, Zincirler ×3

```
........
I......I
j.####.j
.i####i.
.i####i.
j.####.j
I......I
........
```

### Bölüm 13 — BAĞ EVİ

#### Seviye 61: ASMA SIRALARI

_Hasattan önce asmaların düğümünü çöz._

- Hamle: 29 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21500, 3★ 27000
- Görevler: Asmalar ×14, Üzümler ×14, Sepetler ×14, Traktör ×14, Zincirler ×7

```
.l..l###
.....###
l......l
###l..l.
###.....
l......l
.....###
.l..l###
```

#### Seviye 62: ÜZÜM CENDERESİ

_Eski ahşap cendereyi yeniden çevir._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 27000
- Görevler: Üzüm Cenderesi ×13, Üzümler ×13, Sepetler ×13, Şişeler ×13, Zincirler ×7, Kasalar ×3

```
........
.l.cc.l.
........
l.L..L.l
c......c
#......#
##l..l##
###..###
```

#### Seviye 63: ŞARAP MAHZENİ

_Kemerli mahzende fenerleri yak._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 30000
- Görevler: Fıçılar ×13, Şarap Rafı ×13, Şişeler ×13, Lambalar ×13, Zincirler ×8, Buz ×3

```
........
L......L
..J..J..
........
.l.ll.l.
..####..
l.####.l
..####..
```

#### Seviye 64: ÇİFTLİK MUTFAĞI

_Çiftlik evinde hasat yemeği pişir._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 26500
- Görevler: Tencereler ×15, Şömine ×15, Çatal Bıçak ×15, Fırın İşleri ×15, Zincirler ×6, Kasalar ×3

```
..####..
..####..
.c####c.
.l....l.
..l..l..
l..cc..l
........
.l....l.
```

#### Seviye 65: GURUP TERASI

_Gün batımı tadımı için masaları kur._

- Hamle: 33 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25500, 3★ 35000
- Görevler: Masalar ×12, Lambalar ×12, Asmalar ×12, Bardaklar ×12, Gün Batımı ×12, Zincirler ×6, Buz ×5

```
j......j
..l..l..
J......J
#......#
##.jj.##
###..###
###..###
##l..l##
```

### Bölüm 14 — TREN GARI

#### Seviye 66: PERON

_Eski buharlı treni yola çıkmaya hazırla._

- Hamle: 23 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 29500
- Görevler: Trenler ×15, Koltuklar ×15, Saatler ×15, Işıklar ×15, Bavullar ×3, Kasalar ×4

```
##....##
##....##
##....##
........
.c....c.
........
..c..c..
........
```

#### Seviye 67: BİLET SALONU

_Büyük salonun bilet gişelerini yeniden aç._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21500, 3★ 30000
- Görevler: Biletler ×14, Saatler ×14, Tarifeler ×14, Pencereler ×14, Buz ×8, Kapılar ×3

```
.i....i.
........
i..ii..i
........
.I....I.
..####..
i.####.i
..####..
```

#### Seviye 68: BEKLEME SALONU

_Akşam yolcuları için bankları parlat._

- Hamle: 29 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 18000, 3★ 24500
- Görevler: Koltuklar ×12, Gazeteler ×12, Saatler ×12, Bitkiler ×12, Zincirler ×6, Dolaplar ×2

```
..####..
l.####.l
..####..
.l....l.
...ll...
..####..
l.####.l
..####..
```

#### Seviye 69: GAR KAFESİ

_Sabah yolcuları için kahve demle._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 26500
- Görevler: Kahve ×13, Hamur İşleri ×13, Menü Tahtası ×13, Gazeteler ×13, Kasalar ×6, Kapılar ×3

```
c......c
#C....C#
##....##
###..###
###..###
##....##
#......#
.c....c.
```

#### Seviye 70: MAKİNE HANGARI

_Hangardaki eski lokomotifi onar._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 26500, 3★ 32500
- Görevler: Lokomotif ×14, Aletler ×14, Tamirler ×14, Işıklar ×14, Kapılar ×4, Kasalar ×4

```
#.###...
#.###...
........
.c....c.
........
..l..l..
........
#c.##.c#
```

### Bölüm 15 — OKUL

#### Seviye 71: OKUL BAHÇESİ

_Okulun ilk gününde zili çal._

- Hamle: 23 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20500, 3★ 28500
- Görevler: Toplar ×15, Sırt Çantaları ×15, Çimen ×15, Okul Servisi ×15, Kasalar ×4, Kapılar ×2

```
##....##
##....##
c......c
...cc...
........
c......c
##....##
##....##
```

#### Seviye 72: SINIF

_Sınıfı ilk derse hazırla._

- Hamle: 29 · Zorluk: Zor · Tahta: 8×8
- Yıldız puanları: 2★ 30000, 3★ 37500
- Görevler: Sıralar ×14, Kalemler ×14, Kitaplar ×14, Yazı Tahtası ×14, Buz ×8, Zincirler ×8

```
........
.j.jj.j.
........
.l.ll.l.
........
.j.jj.j.
........
.i.ii.i.
```

#### Seviye 73: FEN LABORATUVARI

_Deneyleri yeniden canlandır._

- Hamle: 24 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 25000
- Görevler: Deney Kapları ×13, Mikroskoplar ×13, Küreler ×13, Devreler ×13, Buz ×6, Kasalar ×3

```
###..###
###ii###
##....##
I......I
..c..c..
........
.c.ii.c.
........
```

#### Seviye 74: SPOR SALONU

_Büyük maç için topları şişir._

- Hamle: 24 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 32000
- Görevler: Potalar ×15, Toplar ×15, Ağırlıklar ×15, Madalyalar ×15, Zincirler ×5, Kasalar ×6

```
c...c###
......##
..l...l#
.C....C.
...ll...
#l...l..
##......
###c.c..
```

#### Seviye 75: MÜZİK SINIFI

_Okul konseri için enstrümanları akort et._

- Hamle: 31 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 28500
- Görevler: Piyano ×12, Notalar ×12, Plaklar ×12, Hoparlörler ×12, Buz ×8, Dolaplar ×3

```
........
.i#..#i.
..#..#..
i.#ii#.i
..#..#..
.j#jj#j.
..#..#..
........
```

### Bölüm 16 — HAYVANAT BAHÇESİ

#### Seviye 76: HAYVANAT KAPISI

_Hayvanat bahçesinin kapılarını ziyaretçilere aç._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21500, 3★ 33000
- Görevler: Kapılar ×15, Biletler ×15, Tabela ×15, Çitler ×15, Çeşme ×14, Ağaçlar ×14, Kasalar ×6

```
##....##
#..cc..#
........
.c....c.
.c....c.
........
#......#
##....##
```

#### Seviye 77: ZÜRAFA BAHÇESİ

_Zürafalara güneşli bir bahçe hazırla._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 16500, 3★ 24000
- Görevler: Zürafalar ×13, Ağaçlar ×13, Saman ×13, Çit ×13, Yalak ×12, Kasalar ×6

```
..####..
..####..
..####..
..c..c..
.C....C.
..####..
..####..
..####..
```

#### Seviye 78: PENGUEN GÖLÜ

_Penguenler için havuzu serinlet._

- Hamle: 29 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 33500
- Görevler: Penguenler ×15, Buz Kayaları ×15, Buz Kütleleri ×14, Yumurtalar ×14, Buz Kaydırağı ×14, Buz ×6

```
........
.i....i.
...cc...
#i....i#
#......#
##.ii.##
##....##
###..###
```

#### Seviye 79: SÜRÜNGEN EVİ

_Sürüngen evini ısıt._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 27500
- Görevler: Sürüngenler ×13, Teraryumlar ×13, Lambalar ×12, Böcekler ×12, Yumurtalar ×11, Zincirler ×5, Kasalar ×4

```
..l##l..
...##...
.c.##.c.
...ll...
..c..c..
...##...
.l.##.l.
...##...
```

#### Seviye 80: MİNİ ÇİFTLİK

_Sevimli hayvanlar için şirin bir çiftlik kur._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 27500
- Görevler: Hayvanlar ×15, Tavuklar ×15, Saman ×15, Çimen ×14, Yalak ×14, Yumurtalar ×14, Kapılar ×3

```
#..##..#
.c....c.
........
..c..c..
#......#
##....##
###..###
########
```

### Bölüm 17 — AKVARYUM

#### Seviye 81: GİRİŞ SALONU

_Akvaryuma gelen misafirleri karşıla._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 28500
- Görevler: Biletler ×15, Akvaryumlar ×15, Heykeller ×14, Afişler ×15, Kabarcıklar ×14, Buz ×6

```
##....##
##.ii.##
##....##
.i....i.
........
..i..i..
........
........
```

#### Seviye 82: MERCAN TANKI

_Mercan resifini yeniden canlandır._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 28000
- Görevler: Mercanlar ×15, Balıklar ×15, Kabarcıklar ×14, Dalgıçlar ×14, Koltuklar ×14, Buz ×12

```
i..ii..i
.##..##.
.##II##.
........
i.i..i.i
.##..##.
.##..##.
...ii...
```

#### Seviye 83: CAM TÜNEL

_Köpekbalıklarının altından yeniden yürü._

- Hamle: 32 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 28500
- Görevler: Köpekbalıkları ×12, Işıklar ×12, Vatozlar ×12, Çapalar ×11, Kabarcıklar ×11, Buz ×6, Zincirler ×4

```
i......i
#.l..l.#
##.ii.##
###..###
###..###
##.ii.##
#.l..l.#
........
```

#### Seviye 84: DENİZANALARI

_Parlayan denizanalarını aydınlat._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 26000
- Görevler: Denizanaları ×14, Akvaryumlar ×13, Işıklar ×13, Balıklar ×13, Koltuklar ×12, Buz ×12

```
###..###
##.ii.##
#I....I#
..i..i..
..i..i..
#I....I#
##.ii.##
###..###
```

#### Seviye 85: KEŞİF HAVUZU

_Minik eller deniz yıldızlarıyla tanışsın._

- Hamle: 22 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32500
- Görevler: Deniz Yıldızları ×16, Havuz ×16, Balıklar ×15, Vatozlar ×15, Kabarcıklar ×14, Buz ×10, Kapılar ×3

```
##.ii.##
##....##
i......i
..I..I..
..I..I..
i......i
##....##
##....##
```

### Bölüm 18 — LUNAPARK

#### Seviye 86: GİRİŞ KEMERİ

_Lunaparkın girişini ışıklandır._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20500, 3★ 26500
- Görevler: Giriş Kemeri ×14, Biletler ×14, Balonlar ×13, İkramlar ×13, Dondurma ×13, Işıklar ×13, Kapılar ×2

```
..l..l..
........
.c....c.
..####..
..####..
c.####.c
..####..
..####..
```

#### Seviye 87: ATLIKARINCA

_Atlıkarıncanın atlarını yeniden döndür._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 31500
- Görevler: Atlıkarınca ×15, Atlar ×15, Müzik Kutusu ×14, Işıklar ×14, İkramlar ×14, Zincirler ×7

```
##....##
#.l..l.#
........
.l.LL.l.
........
........
#......#
##....##
```

#### Seviye 88: DÖNME DOLAP

_Dev çarkı yeniden döndür._

- Hamle: 32 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21000, 3★ 28500
- Görevler: Dönme Dolap ×12, Biletler ×12, Meyve Suyu Barı ×11, İkramlar ×11, Ödüller ×11, Zincirler ×4, Sandıklar ×2

```
........
.l....l.
..#..#..
l.####.l
..####..
..#..#..
........
........
```

#### Seviye 89: OYUN STANTLARI

_Oyun stantlarında ödüller kazan._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 28000
- Görevler: Oyun Stantları ×16, Ödüller ×15, Oyunlar ×15, Oyuncaklar ×15, Balonlar ×14, Kasalar ×5, Sandıklar ×2

```
..c...##
......##
##...C..
##......
.c....##
....c.##
##......
##......
```

#### Seviye 90: HIZ TRENİ

_Hız trenini yeniden uçur._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Hız Treni ×15, Biletler ×14, İkramlar ×14, Işıklar ×14, Meyve Suyu Barı ×13, Zincirler ×4, Kapılar ×3

```
....####
.....###
..l...##
.....l.#
.c..c...
#....l..
##..l...
###.....
```

### Bölüm 19 — KİTAPÇI

#### Seviye 91: DÜKKAN ÖNÜ

_Kitapçının vitrinlerini parlat._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20500, 3★ 26500
- Görevler: Vitrinler ×14, Tente ×14, Tabela ×14, Kitaplar ×13, Kitap Arabaları ×13, Bank ×13, Zincirler ×4

```
.l....l.
........
...ll...
##....##
##....##
##....##
##....##
##....##
```

#### Seviye 92: OKUMA KÖŞESİ

_Okurlar için sıcak bir köşe hazırla._

- Hamle: 29 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21000, 3★ 27000
- Görevler: Kanepeler ×14, Raflar ×14, Kitaplar ×14, Lambalar ×13, Dekor ×13, Pencereler ×13, Zincirler ×7

```
.l..####
....####
..L.####
l...####
....l...
..l...L.
........
........
```

#### Seviye 93: ÇOCUK KÖŞESİ

_Çocuk köşesini renklerle doldur._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21500, 3★ 29000
- Görevler: Resimli Kitaplar ×13, Oyuncaklar ×13, Boya Kalemleri ×13, Yapbozlar ×12, Raflar ×12, Zincirler ×3, Kasalar ×3

```
..l...c.
....####
.c..####
...l..l.
.c......
....####
..l.####
.....c..
```

#### Seviye 94: KAFE TEZGÂHI

_Kitapların arasında kahve demle._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21000, 3★ 28500
- Görevler: Menü Tahtası ×15, Kahve Barı ×15, Fırın İşleri ×14, Fincanlar ×14, Kitaplar ×14, Zincirler ×7

```
####.l..
###....l
##.l....
#.....l.
.l..L...
......l.
..l.....
........
```

#### Seviye 95: NADİR KİTAPLAR

_Şehrin en eski kitaplarının kilidini aç._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 28000
- Görevler: Nadir Kitaplar ×15, Parşömenler ×14, Küreler ×14, Saatler ×14, Vitrinler ×14, Zincirler ×7, Sandıklar ×2

```
.l....l.
..L..L..
........
###..###
###..###
........
.l....l.
........
```

### Bölüm 20 — GÖZLEMEVİ

#### Seviye 96: TEPE YOLU

_Yıldızlara çıkan yolu aydınlat._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 27500
- Görevler: Tepe Yolu ×14, Ağaçlar ×14, Çit ×14, Bank ×13, Çimen ×13, Işıklar ×13, Zincirler ×4

```
###..###
##....##
##.jj.##
#......#
#.l..l.#
........
.c....c.
........
```

#### Seviye 97: KUBBE ODASI

_Büyük teleskobu gökyüzüne çevir._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23500, 3★ 31000
- Görevler: Teleskop ×16, Gece Gökyüzü ×15, Haritalar ×15, Küreler ×15, Mercekler ×14, Buz ×8, Zincirler ×4

```
##....##
#.j..j.#
........
.i.II.i.
........
..j..j..
........
........
```

#### Seviye 98: PLANETARYUM

_Kubbeyi yıldızlı bir gökle doldur._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20500, 3★ 26000
- Görevler: Yıldız Projektörü ×14, Gezegenler ×14, Yıldızlar ×14, Roketler ×13, Koltuklar ×13, Buz ×6, Kapılar ×2

```
..i..i..
i......i
..#..#..
..####..
..####..
..#..#..
.i....i.
........
```

#### Seviye 99: GÖK HARİTALARI

_Eski gök haritalarını düzenle._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 29500
- Görevler: Haritalar ×13, Kitaplar ×13, Takımyıldızlar ×13, Saatler ×13, Küreler ×12, Zincirler ×6, Kasalar ×4

```
###..###
##l..l##
#..cc..#
.l....l.
.l....l.
#..cc..#
##....##
###..###
```

#### Seviye 100: ÇATI TERASI

_Çatıdan gece gökyüzünü izle._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23500, 3★ 29000
- Görevler: Teleskop ×15, Yıldızlar ×15, Roketler ×14, Işıklar ×14, Haritalar ×14, Buz ×6, Kapılar ×3

```
###..###
##.jj.##
#.i..i.#
.c....c.
..J..J..
##....##
##....##
##....##
```

### Bölüm 21 — JAPON BAHÇESİ

#### Seviye 101: TORII KAPISI

_Bahçe yolunun üstündeki kırmızı kapıyı dik._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 30000
- Görevler: Torii Kapısı ×15, Taş Fenerler ×14, Bambular ×14, Kiraz Ağaçları ×14, Su Taşı ×6

```
##....##
##.ii.##
........
.i....i.
.i....i.
........
##....##
##....##
```

#### Seviye 102: KOİ GÖLETİ

_Göleti çöz, koi balıklarını geri getir._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Koi Balıkları ×16, Nilüferler ×15, Gölet ×15, Fenerler ×15, Çiçekler ×14, Buz ×14

```
##....##
#..ii..#
..i..i..
.I....I.
.I....I.
..i..i..
#..ii..#
##....##
```

#### Seviye 103: ÇAY EVİ

_Sakin bir çay için alçak masayı hazırla._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Çay Takımı ×16, Masa ×15, Minderler ×15, Bonsailer ×15, Şoji Paravanlar ×15, Demlik ×6, Parşömenler ×2

```
........
.i.ll.i.
........
##.ii.##
##....##
##.ii.##
##....##
##....##
```

#### Seviye 104: BAMBU KORUSU

_Bambuların arasından dolambaçlı bir yol aç._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Bambular ×16, Fenerler ×15, Çit ×15, Dere ×15, Mabet ×14, Rüzgâr Çanları ×4

```
......##
..l...##
##..l...
##......
...l..##
......##
##..l...
##......
```

#### Seviye 105: ÇİÇEKLİ KÖPRÜ

_Dökülen yaprakların altında dereyi geç._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Kiraz Ağaçları ×16, Köprü ×16, Koi Balıkları ×15, Dere ×15, Fenerler ×15, Buz ×8, Zincirler ×4

```
........
.j.ii.j.
........
.i.jj.i.
........
...##...
.i.##.i.
...##...
```

### Bölüm 22 — ORMAN KAMPI

#### Seviye 106: KAMP GİRİŞİ

_Kampçıları karşılayan kütük kemeri yeniden kur._

- Hamle: 24 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 30000
- Görevler: Tabela ×15, Çit ×15, Ağaçlar ×15, Lambalar ×14, Kasalar ×6

```
##....##
##.cc.##
##....##
........
.c....c.
........
..c..c..
........
```

#### Seviye 107: ÇADIR ALANI

_Çadırları çıtırdayan ateşin etrafına kur._

- Hamle: 24 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Kamp Ateşi ×16, Çadırlar ×15, Erzak ×15, Lambalar ×15, Ağaçlar ×14, Kasalar ×8

```
###..###
##....##
#..cc..#
........
.C....C.
........
..c..c..
........
```

#### Seviye 108: AĞAÇ EV

_Yukarı tırman, meşedeki gizli evi onar._

- Hamle: 24 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Ağaç Ev ×15, İp Merdiven ×14, Ağaçlar ×14, Lambalar ×14, Kasalar ×6, İp Köprü ×2

```
##....##
#..cc..#
........
.c.ll.c.
##....##
##.cc.##
##....##
##....##
```

#### Seviye 109: GÖL İSKELESİ

_İskeleyi onar, kanoları suya indir._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Kanolar ×15, Olta Takımı ×15, Av ×14, Tekneler ×15, İskele Tahtaları ×4, Buz ×4

```
....####
.i..####
..c.####
....####
........
.i.cc.i.
........
..i..c..
```

#### Seviye 110: KÜTÜK KULÜBE

_Çamların yanındaki kulübede ocağı yak._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Şömine ×16, Ranzalar ×15, Kitaplar ×15, Pencereler ×15, Mobilya ×15, Kasalar ×16

```
........
.C....C.
...cc...
##....##
##.BB.##
...cc...
.C....C.
........
```

### Bölüm 23 — SİRK

#### Seviye 111: SİRK KAPISI

_Işıklı tabelayı yak, kapıları aç._

- Hamle: 29 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Büyük Çadır ×15, Biletler ×15, Işıklı Tabela ×14, Dondurma ×14, Spot Işıkları ×14, Zincirler ×6

```
.##..##.
.##..##.
..l..l..
........
.l....l.
........
...ll...
........
```

#### Seviye 112: SİRK ARENASI

_Büyük gösteri için talaş arenayı hazırla._

- Hamle: 31 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Akrobatlar ×14, Kürsüler ×13, Hayvanlar ×13, Spot Işıkları ×13, Zincirler ×6

```
........
.L....L.
..#..#..
..####..
..####..
..#..#..
.l....l.
...ll...
```

#### Seviye 113: TRAPEZ

_Salıncakları çadırın tepesine as._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 21000, 3★ 28000
- Görevler: Trapez ×14, Güvenlik Ağı ×13, Spot Işıkları ×13, Davullar ×13, Sirk Halatları ×4

```
........
#.l..l.#
##....##
###..###
###..###
##....##
#.l..l.#
........
```

#### Seviye 114: PALYAÇO ODASI

_Kırmızı burunları bul, aynaları parlat._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 29000
- Görevler: Maskeler ×14, Ayna ×14, Makyaj ×14, Oyuncaklar ×14, Zincirler ×5

```
#..##..#
..l..l..
........
.j....j.
#......#
##.ll.##
###..###
########
```

#### Seviye 115: KARAVANLAR

_Sirk yola çıkmadan vagonları boya._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Karavanlar ×15, Hayvanlar ×15, Saman ×14, Akrobatlar ×14, Zincirler ×6

```
...##...
.l.##.l.
...##...
..L..L..
........
...##...
.j.##.j.
...##...
```

### Bölüm 24 — ÇÖL VAHASI

#### Seviye 116: KERVAN KAMPI

_Kervanların dinlendiği kampa gölge yap._

- Hamle: 23 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Tenteler ×15, Palmiyeler ×15, Bavullar ×15, Kamp Ateşi ×14, Sandıklar ×2, Kasalar ×5

```
....####
.....###
..c...##
.......#
..c..c..
........
.c....c.
........
```

#### Seviye 117: PALMİYE PINARI

_Serin pınar palmiyelerin altından aksın._

- Hamle: 24 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Pınar ×16, Palmiyeler ×16, Çiçekler ×15, Gölgelikler ×15, Buz ×8, Su Testileri ×3

```
#......#
........
..i..i..
...ii...
...ii...
..i..i..
........
#......#
```

#### Seviye 118: ÇARŞI

_Pazar tezgâhlarını baharat ve ipekle doldur._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Baharatlar ×16, Lambalar ×15, Mücevherler ×15, Halılar ×15, Kasalar ×8, Sandıklar ×3

```
...##...
.c.##.c.
...##...
..c..c..
........
.C.ll.C.
........
........
```

#### Seviye 119: SARAY SALONU

_Çöl sarayının kemerlerini parlat._

- Hamle: 30 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Kemerler ×16, Lambalar ×15, Mücevherler ×15, Minderler ×15, Zincirler ×8, Sandıklar ×3

```
.#.##.#.
........
.l.cc.l.
........
..L..L..
........
.c.jj.c.
........
```

#### Seviye 120: ÇATI TERASI

_Saray çatısından parlayan kumulları izle._

- Hamle: 23 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Çeşme ×15, Fenerler ×15, Palmiyeler ×14, Kahve Takımı ×14, Sandıklar ×3, Kasalar ×2

```
....####
.l...###
..c...##
...i...#
#...i...
##...c..
###..l..
####....
```

### Bölüm 25 — KORSAN GEMİSİ

#### Seviye 121: KORSAN İSKELESİ

_Yükü eski korsan gemisine taşı._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31000
- Görevler: Çapalar ×15, Tekneler ×15, Kargo ×15, Papağanlar ×14, Kasalar ×4, Hazine ×2

```
####....
####.c..
####....
####..c.
........
.c..l...
...l..c.
........
```

#### Seviye 122: ANA GÜVERTE

_Yelkenleri fora et, dümene geç._

- Hamle: 24 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Yelkenler ×16, Dümen ×15, Fıçılar ×15, Toplar ×15, Kasalar ×4, Halatlar ×2

```
........
.l....l.
...cc...
.i....i.
........
#.c..c.#
##....##
###..###
```

#### Seviye 123: KAPTAN KAMARASI

_Kaptanın masasında rotayı çiz._

- Hamle: 28 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Haritalar ×15, Küreler ×15, Altın ×15, Papağanlar ×15, Zincirler ×7, Hazine ×2

```
##....##
#.j..j.#
...cc...
.l....l.
.l....l.
...cc...
#.j..j.#
##....##
```

#### Seviye 124: AMBAR

_Geminin ambarındaki fıçıları düzenle._

- Hamle: 25 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 33000
- Görevler: Kargo ×16, Sandıklar ×15, Altın ×15, Halatlar ×15, Kasalar ×14, Hazine ×2

```
........
.#.cc.#.
..c..c..
.C....C.
...BB...
.c....c.
.#.ll.#.
........
```

#### Seviye 125: HAZİNE PLAJI

_X işaretinin olduğu yeri kaz._

- Hamle: 22 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 32000
- Görevler: Palmiyeler ×14, Haritalar ×14, Altın ×14, Sandıklar ×14, Hazine ×3, Kasalar ×4

```
###..###
##....##
#..cc..#
..l..l..
..i..i..
#..cc..#
##....##
###..###
```

### Bölüm 26 — BUZ SARAYI

#### Seviye 126: DONMUŞ KAPI

_Buz sarayının büyük kapısını çöz._

- Hamle: 26 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 26000, 3★ 34000
- Görevler: Kapılar ×17, Buz Kuleleri ×17, Buz Sarkıtları ×17, Kardan Adamlar ×17, Işıklar ×17, Buz ×10

```
.#.#.#.#
........
.i....i.
..i..i..
...II...
..i..i..
.i....i.
........
```

#### Seviye 127: BUZ TAHT SALONU

_Kar kraliçesinin donmuş tahtını parlat._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25500, 3★ 32500
- Görevler: Taht ×17, Kalkanlar ×17, Avizeler ×17, Buz Sarkıtları ×17, Buz Sütunları ×17, Buz ×6, Zincirler ×5

```
##....##
#.j..j.#
...ii...
.l....l.
.l....l.
...ii...
#.j..j.#
##....##
```

#### Seviye 128: KRİSTAL SALON

_Kristal balo salonunu yeniden ışıldat._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 31500
- Görevler: Avizeler ×16, Şampanya ×16, Piyano ×16, Dekor ×16, Merdiven ×16, Buz ×16

```
###..###
##.II.##
#.i..i.#
.I....I.
.I....I.
#.i..i.#
##.II.##
###..###
```

#### Seviye 129: KAR BAHÇESİ

_Kış bahçesini yeniden canlandır._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 27500, 3★ 34000
- Görevler: Kardan Adamlar ×17, Çitler ×17, Buz Heykelleri ×17, Çeşme ×17, Ağaçlar ×17, Buz ×6, Kapılar ×3

```
##....##
##....##
##.ii.##
........
.i....i.
........
..i..i..
........
```

#### Seviye 130: AURORA BALKONU

_Kutup ışıklarını yüksek balkondan izle._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20500, 3★ 27000
- Görevler: Kutup Işıkları ×14, Teleskop ×14, Koltuklar ×14, Buz Sarkıtları ×14, Lambalar ×14, Buz ×5, Zincirler ×3

```
........
.j....j.
..i..i..
...##...
...##...
..l..l..
.J....J.
........
```

### Bölüm 27 — KAPLICA

#### Seviye 131: DAĞ PATİKASI

_Kaplıcaya çıkan taş patikayı temizle._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 32500
- Görevler: Taş Basamaklar ×17, Yön Tabelaları ×17, Işıklar ×17, Bambular ×17, Dere ×17, Kasalar ×5

```
....####
.....###
..c...##
.......#
.c..c...
........
...cc...
........
```

#### Seviye 132: TAŞ HAMAMLAR

_Buharı tüten taş havuzları yeniden doldur._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 29500
- Görevler: Taş Kurnalar ×17, Havlular ×17, Banyo Seti ×17, Bitkiler ×17, Kasalar ×6, Buz ×4

```
........
.C....C.
...ii...
.c....c.
#..ii..#
##....##
###..###
###..###
```

#### Seviye 133: BUHAR ODASI

_Sedir kokulu buhar odasını ısıt._

- Hamle: 25 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25000, 3★ 31000
- Görevler: Ahşap Banklar ×17, Sobalar ×17, Su Kovaları ×17, Otlar ×17, Kasalar ×7, Dolaplar ×3

```
##....##
##....##
..B..B..
........
........
..c..c..
##....##
##....##
```

#### Seviye 134: ÇAY BAHÇESİ

_Kiraz çiçeklerinin altında çay demle._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 28000
- Görevler: Çay Takımları ×15, Çiçekler ×15, Köprü ×15, Koi Göleti ×15, Ağaçlar ×15, Kasalar ×4, Zincirler ×2

```
......##
.c..l.##
##......
##.c..c.
.l....##
...cc.##
##......
##..l...
```

#### Seviye 135: FENER TERASI

_Vadinin üstünde yüz fener yak._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22500, 3★ 34000
- Görevler: Işıklar ×16, Sedir Masaları ×16, Çay Takımları ×16, Jakuzi ×16, Lambalar ×16, Kasalar ×13, Zincirler ×2

```
###..###
##.CC.##
#.c..c.#
.B....B.
...ll...
.c....c.
..C..C..
........
```

### Bölüm 28 — UZAY ÜSSÜ

#### Seviye 136: FIRLATMA ALANI

_Eski roketi fırlatmaya hazırla._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24000, 3★ 29500
- Görevler: Roket ×16, Radar Çanağı ×16, Güneş Panelleri ×16, Antenler ×16, Buz ×4, Kargo ×3

```
###..###
##....##
#......#
#.i..i.#
#......#
#.i..i.#
........
.#....#.
```

#### Seviye 137: KONTROL ODASI

_Görev kontrolündeki tüm ekranları yeniden başlat._

- Hamle: 28 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 14500, 3★ 22000
- Görevler: Konsollar ×12, Monitör ×12, Radar Çanağı ×12, Yıldız Haritası ×12, Fırlatma Düğmesi ×12, Zincirler ×4

```
..####..
..####..
..####..
.l.ll.l.
l..ll..l
..####..
..####..
..####..
```

#### Seviye 138: SERA MODÜLÜ

_Cam kubbenin altında taze yiyecek yetiştir._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 26000, 3★ 34500
- Görevler: Bitkiler ×16, Çiçekler ×16, Güneş Panelleri ×16, Su Tankları ×16, Meyve Ağaçları ×16, Buz ×10, Tohum Kapsülleri ×3

```
........
.i....i.
..I..I..
...##...
...##...
..i..i..
.I....I.
........
```

#### Seviye 139: MÜRETTEBAT ODASI

_Mürettebat kamaralarını yeniden rahat yap._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 18500, 3★ 26000
- Görevler: Ranzalar ×14, Dolaplar ×14, Konsollar ×14, Banyo ×14, Lomboz Camları ×14, Zincirler ×3, Kasalar ×2

```
...##...
.l.##.l.
...##...
.c....c.
........
...##...
.L.##.L.
...##...
```

#### Seviye 140: GÖZLEM GÜVERTESİ

_Gözlem güvertesinden Dünya'yı seyret._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 18500, 3★ 22000
- Görevler: Teleskoplar ×13, Yıldız Haritası ×13, Uydular ×13, Lomboz Camları ×13, Mekik ×13, Zincirler ×3, Kargo ×3

```
........
.l....l.
..####..
..####..
..####..
..####..
.j....j.
........
```

### Bölüm 29 — BÜYÜK OTEL

#### Seviye 141: OTEL GİRİŞİ

_Otel kapısına kırmızı halıyı ser._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20500, 3★ 26500
- Görevler: Kapılar ×13, Saçak ×13, Tabela ×13, Çitler ×13, Işıklar ×13, Zincirler ×4, Kasalar ×2

```
........
.l....l.
...ll...
##....##
##....##
##.cc.##
##....##
##....##
```

#### Seviye 142: BÜYÜK LOBİ

_Misafirleri altın lobide yeniden karşıla._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 22000, 3★ 29000
- Görevler: Resepsiyon ×14, Bavullar ×14, Avizeler ×14, Bitkiler ×14, Asansörler ×14, Zincirler ×4, Kasalar ×3

```
....####
.l..####
..c.####
.l..####
........
..l..c..
.c..l...
........
```

#### Seviye 143: BALO SALONU

_Otelin balo salonunda orkestrayı çaldır._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 24000
- Görevler: Avizeler ×13, Koltuklar ×13, Şampanya ×13, Piyano ×13, Sahne ×13, Zincirler ×4, Buz ×3

```
........
#.l..l.#
##.ii.##
###..###
###..###
##.jj.##
#......#
.l....l.
```

#### Seviye 144: BAŞKANLIK SÜİTİ

_En güzel süiti ünlü bir misafire hazırla._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24500, 3★ 29000
- Görevler: Yatak ×14, Gardırop ×14, Lambalar ×14, Kitaplar ×14, Küvet ×14, Zincirler ×4, Mücevher Kutuları ×3

```
........
.l....l.
........
###..###
###..###
........
..l..l..
........
```

#### Seviye 145: ÇATI HAVUZU

_Şehir ışıklarının üstündeki çatı havuzunu aç._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 23000, 3★ 31500
- Görevler: Havuz ×15, Şezlonglar ×15, Kokteyller ×15, Palmiyeler ×15, Havlular ×15, Zincirler ×6, Buz ×5

```
##....##
##.jj.##
##....##
.l....l.
..i..i..
.c....c.
..i..i..
.l.ll.l.
```

### Bölüm 30 — SARAY

#### Seviye 146: SARAY BAHÇELERİ

_Büyük balo için saray bahçelerini düzenle._

- Hamle: 27 · Zorluk: Orta-Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 25500
- Görevler: Çiçekler ×14, Çitler ×14, Çeşme ×14, Heykeller ×14, Ağaçlar ×14, Buz ×4, Kasalar ×4

```
#..##..#
.i....i.
...cc...
.c....c.
#.i..i.#
##....##
###..###
########
```

#### Seviye 147: ALTIN KAPI

_Sarayın altın kapısını yeniden yaldızla._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 25500, 3★ 38000
- Görevler: Kapılar ×16, Sancaklar ×16, Altın Varak ×16, Nöbetçi Kulübeleri ×16, Işıklar ×16, Zincirler ×5, Sandıklar ×3

```
###..###
##....##
#.l..l.#
........
.l....l.
........
..l..l..
........
```

#### Seviye 148: TAHT ODASI

_Taç giyme töreni için tahtı yenile._

- Hamle: 26 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 20000, 3★ 29000
- Görevler: Taht ×14, Kalkanlar ×14, Taç ×14, Perdeler ×14, Hükümdar Küresi ×14, Kasalar ×5, Zincirler ×4

```
##....##
##.ll.##
##....##
##.jj.##
##....##
.C....C.
..c..c..
........
```

#### Seviye 149: SARAY KİTAPLIĞI

_Kralların eski kitaplarının tozunu al._

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 24500, 3★ 29500
- Görevler: Kitaplar ×15, Parşömenler ×15, Saatler ×15, Merdiven ×15, Zincirler ×4, Buz ×3, Kilitli Ciltler ×3

```
####....
####.l..
####..i.
####.l..
........
.i..l...
..l...i.
........
```

#### Seviye 150: SARAY BALOSU

_Kraliyet balosunu aç, en görkemli gece!_

- Hamle: 27 · Zorluk: Zor · Tahta: 8×8 (şekilli)
- Yıldız puanları: 2★ 29500, 3★ 35000
- Görevler: Avizeler ×18, Şampanya ×18, Havai Fişekler ×18, Piyano ×18, Buz ×6, Zincirler ×4, Taç Mücevherleri ×3

```
.##..##.
..#..#..
.i....i.
..cJJc..
.l....l.
...ii...
.c....c.
........
```

