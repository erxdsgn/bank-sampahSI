import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/leaderboard_entry.dart';

/// Toggle pill "Mingguan | Bulanan".
class PeriodToggle extends StatelessWidget {
  final LeaderboardPeriod selected;
  final ValueChanged<LeaderboardPeriod> onChanged;

  const PeriodToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _Segment(
            label: 'Mingguan',
            isSelected: selected == LeaderboardPeriod.weekly,
            onTap: () => onChanged(LeaderboardPeriod.weekly),
          ),
          _Segment(
            label: 'Bulanan',
            isSelected: selected == LeaderboardPeriod.monthly,
            onTap: () => onChanged(LeaderboardPeriod.monthly),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Segment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.homeGreenDark : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
