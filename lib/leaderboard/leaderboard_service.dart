import 'dart:math';

enum LeaderboardCategory { global, friends, weekly }

class LeaderboardEntry {
  final int rank;
  final String name;
  final String avatarId;
  final int score;
  final int stars;
  final bool isPlayer;
  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.avatarId,
    required this.score,
    required this.stars,
    this.isPlayer = false,
  });
}

class PlayerSnapshot {
  final String name;
  final String avatarId;
  final int score;
  final int stars;
  const PlayerSnapshot({required this.name, required this.avatarId, required this.score, required this.stars});
}

class LeaderboardPage {
  final List<LeaderboardEntry> entries;
  final LeaderboardEntry player;
  const LeaderboardPage(this.entries, this.player);
}

class LeaderboardOfflineException implements Exception {
  const LeaderboardOfflineException();
}

class LeaderboardUnavailableException implements Exception {
  final String message;
  const LeaderboardUnavailableException(this.message);
}

/// Backend-agnostic contract. Future implementations: Firebase, Supabase,
/// PlayFab. Only this service needs the network; the game never waits on it.
abstract class LeaderboardService {
  Future<LeaderboardPage> fetch(LeaderboardCategory category, PlayerSnapshot me);
  Future<void> submit(PlayerSnapshot me);
}

/// Offline mock with deterministic, realistic data. The player is ranked
/// among the mock entries by their real total score.
class MockLeaderboardService implements LeaderboardService {
  /// Toggled from the debug panel to exercise the offline UI.
  bool simulateOffline = false;
  final Duration latency;

  MockLeaderboardService({this.latency = const Duration(milliseconds: 450)});

  static const _names = [
    'Luna',
    'Alex',
    'Mia',
    'Kaan',
    'Noah',
    'Elif',
    'Zoe',
    'Leo',
    'Deniz',
    'Ivy',
    'Omar',
    'Sofia',
    'Emir',
    'Nora',
    'Theo',
    'Ada',
    'Mert',
    'Lily',
    'Arda',
    'Ruby',
    'Finn',
    'Ela',
    'Max',
    'Yusuf',
    'Chloe',
    'Can',
    'Hana',
    'Oscar',
    'Defne',
    'Milo',
  ];
  static const _avatars = ['fox', 'cat', 'bunny', 'bird', 'bee', 'star', 'rocket', 'leaf'];

  @override
  Future<LeaderboardPage> fetch(LeaderboardCategory category, PlayerSnapshot me) async {
    await Future<void>.delayed(latency);
    if (simulateOffline) throw const LeaderboardOfflineException();

    final (count, top, seed) = switch (category) {
      LeaderboardCategory.global => (30, 48250, 11),
      LeaderboardCategory.friends => (8, 31200, 23),
      LeaderboardCategory.weekly => (20, 22400, 37),
    };
    final rng = Random(seed);
    final others = <(String, String, int, int)>[];
    var score = top;
    for (var i = 0; i < count; i++) {
      final name = _names[(i * 7 + seed) % _names.length];
      others.add((name, _avatars[rng.nextInt(_avatars.length)], score, (score / 3400).clamp(1, 15).round()));
      score -= 700 + rng.nextInt(2600);
      if (score < 1500) score = 1500 + rng.nextInt(500);
    }
    final all = [...others.map((o) => (o.$1, o.$2, o.$3, o.$4, false)), (me.name, me.avatarId, me.score, me.stars, true)]
      ..sort((a, b) => b.$3.compareTo(a.$3));

    final entries = <LeaderboardEntry>[];
    LeaderboardEntry? player;
    for (var i = 0; i < all.length; i++) {
      final e = all[i];
      final entry = LeaderboardEntry(rank: i + 1, name: e.$1, avatarId: e.$2, score: e.$3, stars: e.$4, isPlayer: e.$5);
      entries.add(entry);
      if (e.$5) player = entry;
    }
    return LeaderboardPage(entries, player!);
  }

  @override
  Future<void> submit(PlayerSnapshot me) async {
    // Mock: scores are read from local progress on every fetch.
  }
}
