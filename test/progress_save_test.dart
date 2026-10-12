import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/localization/localization.dart';
import 'package:match_make/localization/strings_en.dart';
import 'package:match_make/localization/strings_tr.dart';
import 'package:match_make/progression/progress_service.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/save/save_store.dart';
import 'package:match_make/settings/settings_service.dart';

Future<(ProgressService, SaveStore, MemorySaveRepository)> fresh([String? raw]) async {
  final repo = MemorySaveRepository(raw);
  final store = SaveStore(repo);
  await store.load();
  return (ProgressService(GameContent.standard(), store), store, repo);
}

void main() {
  final content = GameContent.standard();

  test('only the garden is unlocked at start', () async {
    final (p, _, _) = await fresh();
    expect(p.isUnlocked('garden'), isTrue);
    for (final id in ['kitchen', 'bathroom', 'gaming_room', 'attic']) {
      expect(p.isUnlocked(id), isFalse, reason: id);
    }
    expect(p.currentLevelOf(content.chapters.first)!.id, 'garden');
  });

  test('completing levels unlocks the chain and completes the chapter', () async {
    final (p, _, _) = await fresh();
    final ids = ['garden', 'kitchen', 'bathroom', 'gaming_room', 'attic'];
    for (var i = 0; i < ids.length; i++) {
      final o = p.recordWin(content.level(ids[i])!, 20000, 2);
      expect(o.firstCompletion, isTrue);
      if (i + 1 < ids.length) {
        expect(o.newlyUnlocked?.id, ids[i + 1]);
        expect(p.isUnlocked(ids[i + 1]), isTrue);
        expect(o.chapterCompletedNow, isFalse);
      } else {
        expect(o.chapterCompletedNow, isTrue);
      }
      expect(p.isGalleryUnlocked(ids[i]), isTrue);
    }
    expect(p.isChapterCompleted(content.chapters.first), isTrue);
    expect(p.chapterStars(content.chapters.first), 10);
  });

  test('all 50 levels unlock in order; a new chapter opens every 5 levels', () async {
    final (p, _, _) = await fresh();
    final all = [for (final c in content.chapters) ...content.levelsOf(c.id)];
    expect(all.length, 50);
    expect([for (final l in all) l.number], [for (var i = 1; i <= 50; i++) i]);
    for (var i = 0; i < all.length; i++) {
      expect(p.isUnlocked(all[i].id), isTrue, reason: '${all[i].id} should be open');
      for (final later in all.skip(i + 1)) {
        expect(p.isUnlocked(later.id), isFalse, reason: '${later.id} must stay locked');
      }
      p.recordWin(all[i], 30000, 3);
      if (all[i].number % 5 == 0 && i + 1 < all.length) {
        final next = content.chapter(all[i + 1].chapterId)!;
        expect(p.isChapterUnlocked(next), isTrue, reason: 'chapter ${next.id} after level ${all[i].number}');
      }
    }
    expect(p.totalStars, 150);
    expect(p.levelsCompleted, 50);
  });

  test('a version-1 Chapter 1 save keeps everything and opens the Farm', () async {
    const v1 = '{"v":1,"levels":{"garden":{"c":true,"s":3,"b":35000},"kitchen":{"c":true,"s":2,"b":24000},'
        '"bathroom":{"c":true,"s":2,"b":25000},"gaming_room":{"c":true,"s":1,"b":20000},"attic":{"c":true,"s":3,"b":33000}},'
        '"gallery":["garden","kitchen","bathroom","gaming_room","attic"],"galleryViewed":["garden"],'
        '"celebrated":["house"],"settings":{"music":false,"sfx":true,"vib":false,"lang":"tr"},'
        '"profile":{"name":"Kel","avatar":"bee"},"tutorial":true}';
    final (p, store, repo) = await fresh(v1);
    expect(store.recoveredOnLoad, isFalse);
    expect(p.chapterStars(content.chapter('house')!), 11);
    expect(p.bestScoreOf('garden'), 35000);
    expect(p.galleryCount(content.chapter('house')!), 5);
    expect(p.isChapterUnlocked(content.chapter('farm')!), isTrue);
    expect(p.isUnlocked('farmyard'), isTrue);
    expect(p.isUnlocked('barn'), isFalse);
    expect(p.isChapterUnlocked(content.chapter('restaurant')!), isFalse);
    expect(p.currentChapter.id, 'farm');
    final settings = SettingsService(store);
    expect(settings.music, isFalse);
    expect(settings.language, 'tr');
    expect(store.data.profile.name, 'Kel');
    // Saving upgrades the format without losing anything.
    p.markTipSeen('obstacle_crate');
    await store.commit();
    expect(repo.raw, contains('"v":3'));
    final (p2, _, _) = await fresh(repo.raw);
    expect(p2.chapterStars(content.chapter('house')!), 11);
    expect(p2.hasSeenTip('obstacle_crate'), isTrue);
  });

  test('debug chapter unlock opens the first level of that chapter only', () async {
    final (p, _, _) = await fresh();
    p.debugUnlockChapter('beach');
    expect(p.isUnlocked('beach'), isTrue);
    expect(p.isUnlocked('pool'), isFalse);
    expect(p.isUnlocked('farmyard'), isFalse);
  });

  test('stars never decrease and best score is kept', () async {
    final (p, _, _) = await fresh();
    final garden = content.level('garden')!;
    p.recordWin(garden, 30000, 3);
    final o = p.recordWin(garden, 12000, 1);
    expect(o.newBest, isFalse);
    expect(p.starsOf('garden'), 3);
    expect(p.bestScoreOf('garden'), 30000);
    p.recordWin(garden, 40000, 2);
    expect(p.starsOf('garden'), 3);
    expect(p.bestScoreOf('garden'), 40000);
  });

  test('progress and settings survive a save/load round trip', () async {
    final (p, store, repo) = await fresh();
    p.recordWin(content.level('garden')!, 25000, 2);
    p.completeTutorial();
    final settings = SettingsService(store)
      ..music = false
      ..language = 'tr';
    expect(settings.music, isFalse);
    await store.commit();

    final (p2, store2, _) = await fresh(repo.raw);
    expect(p2.isCompleted('garden'), isTrue);
    expect(p2.starsOf('garden'), 2);
    expect(p2.isUnlocked('kitchen'), isTrue);
    expect(p2.tutorialDone, isTrue);
    final s2 = SettingsService(store2);
    expect(s2.music, isFalse);
    expect(s2.language, 'tr');
  });

  test('corrupted save falls back to safe defaults', () async {
    final (p, store, _) = await fresh('{not valid json');
    expect(store.recoveredOnLoad, isTrue);
    expect(p.isUnlocked('garden'), isTrue);
    expect(p.totalStars, 0);
  });

  test('partially invalid fields are tolerated', () async {
    final (p, _, _) = await fresh('{"levels": {"garden": {"c": true, "s": 99, "b": "x"}}, "gallery": [1, "garden"]}');
    expect(p.isCompleted('garden'), isTrue);
    expect(p.starsOf('garden'), 3);
    expect(p.bestScoreOf('garden'), 0);
    expect(p.isGalleryUnlocked('garden'), isTrue);
  });

  test('reset clears progress but keeps settings', () async {
    final (p, store, _) = await fresh();
    SettingsService(store).sfx = false;
    p.recordWin(content.level('garden')!, 25000, 2);
    await p.resetProgress();
    expect(p.isCompleted('garden'), isFalse);
    expect(p.isUnlocked('kitchen'), isFalse);
    expect(p.isGalleryUnlocked('garden'), isFalse);
    expect(SettingsService(store).sfx, isFalse);
  });

  test('debug lock / unlock overrides', () async {
    final (p, _, _) = await fresh();
    p.debugUnlock('attic');
    expect(p.isUnlocked('attic'), isTrue);
    p.debugLock('garden');
    expect(p.isUnlocked('garden'), isFalse);
  });

  test('every visible string key exists in both languages', () {
    expect(stringsTr.keys.toSet().difference(stringsEn.keys.toSet()), isEmpty);
    expect(stringsEn.keys.toSet().difference(stringsTr.keys.toSet()), isEmpty);
    final loc = Localization();
    for (final l in content.allLevels) {
      expect(stringsEn.containsKey(l.nameKey), isTrue);
      expect(stringsEn.containsKey(l.descKey), isTrue);
      for (final o in l.objectives) {
        expect(stringsEn.containsKey(o.nameKey), isTrue, reason: o.nameKey);
      }
    }
    loc.language = 'tr';
    expect(loc.t('menu.play'), 'OYNA');
    expect(loc.t('win.unlocked', {'name': 'MUTFAK'}), 'MUTFAK açıldı!');
    loc.language = 'xx';
    expect(loc.t('menu.play'), 'PLAY');
  });
}
