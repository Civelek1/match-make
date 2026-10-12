import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/save/save_repository.dart';

Future<AppServices> load(MemorySaveRepository repo, List<String> device) async {
  final s = AppServices.create(repository: repo, audio: SilentAudioService(), deviceLanguages: () => device);
  await s.load();
  return s;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a new install starts in the first supported device language', () async {
    expect((await load(MemorySaveRepository(), ['tr', 'en'])).settings.language, 'tr');
    expect((await load(MemorySaveRepository(), ['de', 'tr'])).settings.language, 'tr');
    expect((await load(MemorySaveRepository(), ['de', 'fr'])).settings.language, 'en');
    final s = await load(MemorySaveRepository(), ['tr']);
    expect(s.loc.t('menu.play'), 'OYNA');
  });

  test("an existing player's chosen language is never overridden", () async {
    final repo = MemorySaveRepository();
    final first = await load(repo, ['tr']);
    first.settings.language = 'en';
    await first.store.commit();
    expect((await load(repo, ['tr'])).settings.language, 'en');
  });
}
