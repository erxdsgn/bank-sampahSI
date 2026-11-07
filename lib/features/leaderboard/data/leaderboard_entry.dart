enum LeaderboardPeriod { weekly, monthly }

class LeaderboardEntry {
  final String id;
  final String name;

  /// Total berat sampah yang disetor pada periode terpilih (kg).
  final double totalKg;

  /// Jumlah kali setor pada periode terpilih.
  final int depositCount;

  /// True jika entri ini adalah user yang sedang login.
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.id,
    required this.name,
    required this.totalKg,
    required this.depositCount,
    this.isCurrentUser = false,
  });

  /// Inisial dari maksimal 2 kata pertama nama, contoh: "Siti Aminah" -> "SA".
  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    final first = parts.first[0];
    final second = parts.length > 1 ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }

  /// Contoh JSON dari API: {id, name, total_kg, deposit_count, is_current_user}
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'].toString(),
      name: json['name'] as String,
      totalKg: (json['total_kg'] as num).toDouble(),
      depositCount: json['deposit_count'] as int,
      isCurrentUser: json['is_current_user'] as bool? ?? false,
    );
  }
}
