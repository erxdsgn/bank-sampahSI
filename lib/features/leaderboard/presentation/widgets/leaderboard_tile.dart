import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/leaderboard_entry.dart';
import 'podium.dart' show formatKg;
import 'rank_avatar.dart';

/// Satu baris peringkat (untuk peringkat 4 ke bawah).
class LeaderboardTile extends StatelessWidget {
  final int rank;
  final LeaderboardEntry entry;

  const LeaderboardTile({super.key, required this.rank, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: entry.isCurrentUser ? AppColors.homeGreenLight : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$rank',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.homeTextSecondary,
              ),
            ),
          ),
          RankAvatar(initials: entry.initials, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.homeTextPrimary,
                        ),
                      ),
                    ),
                    if (entry.isCurrentUser) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.homeGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Kamu',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '${entry.depositCount}x setor',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.homeTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            formatKg(entry.totalKg),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.homeGreen,
            ),
          ),
        ],
      ),
    );
  }
}
