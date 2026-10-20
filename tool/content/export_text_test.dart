// Writes the whole game as readable Turkish text (docs/OYUN_METNI.md):
// how it plays, mechanics, boosters, economy, and every chapter and level.
//   flutter test tool/content/export_text_test.dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/data/models/level_data.dart';
import 'package:match_make/economy/economy_config.dart';
import 'package:match_make/localization/localization.dart';
import 'package:match_make/save/save_repository.dart';

const _diff = {
  Difficulty.easy: 'Kolay',
  Difficulty.easyMedium: 'Kolay-Orta',
  Difficulty.medium: 'Orta',
  Difficulty.mediumHard: 'Orta-Zor',
  Difficulty.hard: 'Zor',
};

const _special = {SpecialFeature.rocket: 'Roket', SpecialFeature.bomb: 'Bomba', SpecialFeature.colorBomb: 'Renk Bombası'};

void main() {
  test('export game text', () {
    final tr = Localization.supported['tr']!;
    String t(String k) => tr[k] ?? k;
    final s = AppServices.create(repository: MemorySaveRepository(), audio: SilentAudioService());
    final content = s.content;
    const eco = EconomyConfig();
    final levels = content.allLevels.length;
    final b = StringBuffer();

    b.writeln('# Match Make — Oyunun Metin Hâli');
    b.writeln();
    b.writeln('CiTu Studios · ${content.chapters.length} bölüm (mekân) · $levels seviye · Türkçe ve İngilizce');
    b.writeln();
    b.writeln('Bu dosya oyunun verisinden otomatik üretilir: `flutter test tool/content/export_text_test.dart`.');
    b.writeln();
    b.writeln('## 1. Oyun nedir?');
    b.writeln();
    b.writeln('Match Make, harap mekânları eşleştirme (match-3) oynayarak yeniden canlandırdığın bir bulmaca oyunudur. '
        'Her seviyenin üstünde bakımsız bir sahne (oda, bahçe, dükkân…) durur. Tahtada aynı türden 3 veya daha fazla parçayı '
        'yan yana getirdikçe görevler dolar ve sahnedeki eşyalar tek tek yenilenip yerine gelir. Seviye bitince sahne tamamen '
        'yenilenmiş olur ve galeriye eklenir. Her bölüm 5 seviyelik bir mekândır; bölümler resimli bir haritada açılır.');
    b.writeln();
    b.writeln('## 2. Nasıl oynanır?');
    b.writeln();
    b.writeln('- Yan yana iki parçayı kaydırarak yer değiştir; 3 veya daha fazla aynı parça yan yana gelirse patlar.');
    b.writeln('- Patlayan parçaların yerine üstten yenileri düşer; zincirleme patlamalar (kombo) ekstra puan verir.');
    b.writeln('- Her seviyenin sınırlı **hamle** sayısı ve 5–7 **görevi** vardır (ör. "15 kruvasan topla", "6 kasa kır", "2 anahtar indir").');
    b.writeln('- Hamleler bitmeden bütün görevleri tamamlarsan kazanırsın. Kalan hamleler bonus puana dönüşür.');
    b.writeln('- Puana göre 1–3 **yıldız** alınır: bitirmek 1 yıldız, 2 ve 3 yıldız için seviyeye özel puan sınırları vardır.');
    b.writeln('- Tahtalar her zaman kare değildir: L, U, T, artı, kalp, kum saati, halka, merdiven gibi şekiller vardır; '
        'boşluklardan taşlar aşağı düşmeye devam eder.');
    b.writeln();
    b.writeln('## 3. Özel parçalar');
    b.writeln();
    b.writeln('| Parça | Nasıl yapılır | Ne yapar |');
    b.writeln('|---|---|---|');
    b.writeln('| Roket | 4 parçayı yan yana eşleştir | Bütün bir sırayı veya sütunu temizler |');
    b.writeln('| Bomba | L veya T şeklinde eşleştir | Çevresindeki alanı patlatır |');
    b.writeln('| Renk Bombası | 5 parçayı yan yana eşleştir | Bir parçayla değiştirilince o türün hepsini temizler |');
    b.writeln();
    b.writeln('İki özel parçayı birbiriyle değiştirmek mega kombo yapar (ör. renk bombası + roket: o türün hepsi rokete dönüşür).');
    b.writeln();
    b.writeln('## 4. Engeller');
    b.writeln();
    b.writeln('| Engel | Açıklama |');
    b.writeln('|---|---|');
    b.writeln('| Kasa (1–3 kat) | Üzerinde taş olmaz; yanında eşleştirme yapınca bir kat kırılır |');
    b.writeln('| Buz (1–2 kat) | Altındaki hücrede eşleştirme yapınca çatlar |');
    b.writeln('| Zincir (1–2 kat) | Zincirli taş yer değiştiremez; eşleşmeye katılınca zincir kırılır |');
    b.writeln('| Anahtar | Tahtanın altına kadar indirilmesi gereken özel parça; en alttaki çıkışlardan çıkar (görev listesinde "Kapılar") |');
    b.writeln();
    b.writeln('## 5. Güçlendiriciler');
    b.writeln();
    b.writeln('| Güçlendirici | Ne yapar | Fiyat | Açıldığı seviye |');
    b.writeln('|---|---|---|---|');
    for (final k in BoosterKind.values) {
      b.writeln('| ${t(k.nameKey)} | ${t(k.howKey)} | ${k.price} altın | ${k.unlockLevel} |');
    }
    b.writeln();
    b.writeln('Bir güçlendirici açıldığında ${eco.unlockGift} tane hediye edilir. Oyun içi güçlendiriciler hamle harcamaz; '
        '"…ile Başla" güçlendiricileri seviye başlamadan önce seçilir.');
    b.writeln();
    b.writeln('## 6. Ekonomi ve ödüller');
    b.writeln();
    b.writeln('- Yeni oyuncu ${eco.starterCoins} altınla başlar.');
    b.writeln('- Bir seviyeyi ilk kez bitirmek: ${eco.firstWinBase} altın + yıldız başına ${eco.firstWinPerStar} altın.');
    b.writeln('- Tekrar oynayıp bitirmek: ${eco.replayWin} altın; yeni kazanılan her yıldız için +${eco.replayPerNewStar} altın.');
    b.writeln('- Bir bölümü ilk kez tamamlamak: ${eco.chapterBonus} altın bonus.');
    b.writeln('- Kaybedince devam etmek: +${eco.continueMoves} hamle; fiyat sırayla ${eco.continuePrices.join(' / ')} altın.');
    final days = [
      for (final d in eco.daily)
        [if (d.coins > 0) '${d.coins} altın', if (d.booster != null) '${d.boosterCount} ${t(d.booster!.nameKey)}'].join(' + '),
    ];
    b.writeln('- Günlük ödül takvimi (7 gün, art arda girişte artar): ${[for (var i = 0; i < days.length; i++) '${i + 1}. gün ${days[i]}'].join(', ')}.');
    b.writeln('- Altınlar dükkânda güçlendirici almak için kullanılır. Gerçek parayla satın alma ve reklam yoktur.');
    b.writeln();
    b.writeln('## 7. Ekranlar');
    b.writeln();
    b.writeln('- **Yükleme ekranı:** maskot, logo, ilerleme çubuğu ve ipuçları.');
    b.writeln('- **Ana menü:** Oyna, bölüm seçimi, galeri, profil, dükkân, günlük ödül, ayarlar.');
    b.writeln('- **Bölüm haritası:** her mekânın resimli haritası; 5 seviye düğmesi, yıldızlar, kilitli seviyeler. '
        'Seviyeler bittikçe harita da yenilenir.');
    b.writeln('- **Oyun ekranı:** üstte yenilenen sahne, görev listesi ve hamle sayacı; altta tahta ve güçlendiriciler.');
    b.writeln('- **Galeri:** tamamlanan sahnelerin yenilenmiş hâlleri.');
    b.writeln('- **Profil:** isim (Kaydet butonu), avatar, toplam yıldız/puan, tamamlanan seviye sayısı.');
    b.writeln('- **Ayarlar:** müzik, ses efektleri, titreşim, dil (Türkçe/İngilizce), hakkında.');
    b.writeln();
    b.writeln('## 8. İpuçları (yükleme ekranında gösterilenler)');
    b.writeln();
    for (var i = 1; tr.containsKey('tip.$i'); i++) {
      b.writeln('- ${t('tip.$i')}');
    }
    b.writeln();
    b.writeln('## 9. Bölümler ve seviyeler');
    b.writeln();
    b.writeln('Tahta gösteriminde: `.` normal hücre, `#` hücre yok (tahtanın şekli), `c C B` kasa (1/2/3 kat), '
        '`i I` buz (1/2 kat), `l L` zincir (1/2 kat), `j J` buz + zincir.');
    b.writeln();
    for (final ch in content.chapters) {
      b.writeln('### Bölüm ${ch.number} — ${t(ch.nameKey)}');
      b.writeln();
      for (final l in content.levelsOf(ch.id)) {
        b.writeln('#### Seviye ${l.number}: ${t(l.nameKey)}');
        b.writeln();
        final desc = tr['${l.nameKey}.desc'];
        if (desc != null) b.writeln('_${desc}_');
        if (desc != null) b.writeln();
        b.writeln('- Hamle: ${l.moves} · Zorluk: ${_diff[l.difficulty]} · Tahta: ${l.gridWidth}×${l.gridHeight}'
            '${l.obstacles != null && l.obstacles!.any((r) => r.contains('#')) ? ' (şekilli)' : ''}');
        b.writeln('- Yıldız puanları: 2★ ${l.starThresholds[0]}, 3★ ${l.starThresholds[1]}');
        if (l.introduces != null) b.writeln('- Tanıtılan özel parça: ${_special[l.introduces]}');
        b.writeln('- Görevler: ${[for (final o in l.objectives) '${t(o.nameKey)} ×${o.target}'].join(', ')}');
        final rows = l.obstacles;
        if (rows != null && rows.any((r) => r.contains(RegExp('[^.]')))) {
          b.writeln();
          b.writeln('```');
          rows.forEach(b.writeln);
          b.writeln('```');
        }
        b.writeln();
      }
    }
    File('docs/OYUN_METNI.md').writeAsStringSync(b.toString());
  });
}
