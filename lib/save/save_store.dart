import 'save_data.dart';
import 'save_repository.dart';

/// Owns the in-memory [SaveData] and writes it through the repository.
/// Services mutate [data] then call [commit].
class SaveStore {
  final SaveRepository repository;
  SaveData data;
  bool recoveredOnLoad = false;
  Future<void> _pending = Future.value();

  SaveStore(this.repository) : data = SaveData();

  Future<void> load() async {
    final r = await repository.load();
    data = r.data;
    recoveredOnLoad = r.recovered;
  }

  /// Serialises writes so rapid commits can't interleave.
  Future<void> commit() => _pending = _pending.then((_) => repository.save(data));
}
