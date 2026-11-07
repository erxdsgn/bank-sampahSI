import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/leaderboard_entry.dart';
import 'podium.dart' show formatKg;
import 'rank_avatar.dart';

/// Kartu "Posisi kamu" yang menempel di bagian bawah halaman.
class MyRankBar extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const MyRankBar({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final index = entries.indexWhere((e) => e.isCurrentUser);
    if (index == -1) return const SizedBox.shrink();

    final me = entries[index];
    final rank = index + 1;

    String hint;
    if (rank == 1) {
      hint = 'Kamu di puncak! Pertahankan ya.';
    } else {
      final gap = entries[index - 1].totalKg - me.totalKg;
      // Bulatkan ke atas 0,1 kg supaya benar-benar melewati peringkat di atas.
      final needed = ((gap * 10).floor() + 1) / 10;
      hint = 'Setor ${formatKg(needed)} lagi untuk naik ke peringkat ${rank - 1}';
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          RankAvatar(initials: me.initials, size: 44),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Peringkat kamu #$rank  •  ${formatKg(me.totalKg)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.homeTextPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  hint,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.homeTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
