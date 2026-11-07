import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/leaderboard_entry.dart';
import 'rank_avatar.dart';

String formatKg(double kg) => '${kg.toStringAsFixed(1).replaceAll('.', ',')} kg';

/// Podium juara 1-3. Urutan tampilan: 2 - 1 - 3.
class Podium extends StatelessWidget {
  final LeaderboardEntry first;
  final LeaderboardEntry second;
  final LeaderboardEntry third;

  const Podium({
    super.key,
    required this.first,
    required this.second,
    required this.third,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _Place(
            entry: second,
            rank: 2,
            barHeight: 84,
            medalColor: AppColors.medalSilver,
          ),
        ),
        Expanded(
          child: _Place(
            entry: first,
            rank: 1,
            barHeight: 112,
            medalColor: AppColors.medalGold,
          ),
        ),
        Expanded(
          child: _Place(
            entry: third,
            rank: 3,
            barHeight: 66,
            medalColor: AppColors.medalBronze,
          ),
        ),
      ],
    );
  }
}

class _Place extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;
  final double barHeight;
  final Color medalColor;

  const _Place({
    required this.entry,
    required this.rank,
    required this.barHeight,
    required this.medalColor,
  });

  @override
  Widget build(BuildContext context) {
    final isFirst = rank == 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isFirst)
          Icon(Icons.emoji_events, color: medalColor, size: 28)
        else
          const SizedBox(height: 28),
        RankAvatar(
          initials: entry.initials,
          size: isFirst ? 68 : 56,
          borderColor: medalColor,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            entry.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w600,
              color: entry.isCurrentUser
                  ? AppColors.homeGreenDark
                  : AppColors.homeTextPrimary,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          formatKg(entry.totalKg),
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: AppColors.homeGreen,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: barHeight,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                medalColor.withValues(alpha: 0.9),
                medalColor.withValues(alpha: 0.35),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Text(
            '$rank',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
