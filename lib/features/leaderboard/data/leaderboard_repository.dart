import 'leaderboard_entry.dart';

/// Sumber data papan peringkat.
///
/// Saat ini memakai data dummy. Ketika backend siap, ganti isi [fetch]
/// dengan pemanggilan API (mis. lewat ApiService) dan parse dengan
/// [LeaderboardEntry.fromJson]. Halaman tidak perlu diubah.
class LeaderboardRepository {
  const LeaderboardRepository();

  Future<List<LeaderboardEntry>> fetch(LeaderboardPeriod period) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final data = period == LeaderboardPeriod.weekly ? _weekly : _monthly;
    // Urutkan dari setoran terbanyak. Peringkat = urutan index + 1.
    return [...data]..sort((a, b) => b.totalKg.compareTo(a.totalKg));
  }

  static const _weekly = [
    LeaderboardEntry(id: '1', name: 'Siti Aminah', totalKg: 18.4, depositCount: 5),
    LeaderboardEntry(id: '2', name: 'Budi Santoso', totalKg: 15.2, depositCount: 4),
    LeaderboardEntry(id: '3', name: 'Dewi Lestari', totalKg: 13.7, depositCount: 4),
    LeaderboardEntry(id: '4', name: 'Agus Salim', totalKg: 11.0, depositCount: 3),
    LeaderboardEntry(
      id: '5',
      name: 'ERIX AGUNG WIBOWO',
      totalKg: 9.6,
      depositCount: 3,
      isCurrentUser: true,
    ),
    LeaderboardEntry(id: '6', name: 'Rina Marlina', totalKg: 8.3, depositCount: 2),
    LeaderboardEntry(id: '7', name: 'Joko Widodo', totalKg: 6.9, depositCount: 2),
    LeaderboardEntry(id: '8', name: 'Ani Yulianti', totalKg: 5.1, depositCount: 2),
    LeaderboardEntry(id: '9', name: 'Hendra Gunawan', totalKg: 3.8, depositCount: 1),
    LeaderboardEntry(id: '10', name: 'Lilis Suryani', totalKg: 2.2, depositCount: 1),
  ];

  static const _monthly = [
    LeaderboardEntry(id: '2', name: 'Budi Santoso', totalKg: 71.5, depositCount: 16),
    LeaderboardEntry(id: '1', name: 'Siti Aminah', totalKg: 68.9, depositCount: 18),
    LeaderboardEntry(id: '3', name: 'Dewi Lestari', totalKg: 55.3, depositCount: 14),
    LeaderboardEntry(id: '4', name: 'Agus Salim', totalKg: 49.8, depositCount: 12),
    LeaderboardEntry(id: '6', name: 'Rina Marlina', totalKg: 42.6, depositCount: 10),
    LeaderboardEntry(id: '7', name: 'Joko Widodo', totalKg: 39.1, depositCount: 9),
    LeaderboardEntry(
      id: '5',
      name: 'ERIX AGUNG WIBOWO',
      totalKg: 36.4,
      depositCount: 9,
      isCurrentUser: true,
    ),
    LeaderboardEntry(id: '8', name: 'Ani Yulianti', totalKg: 28.0, depositCount: 7),
    LeaderboardEntry(id: '9', name: 'Hendra Gunawan', totalKg: 21.7, depositCount: 5),
    LeaderboardEntry(id: '10', name: 'Lilis Suryani', totalKg: 14.3, depositCount: 4),
  ];
}
