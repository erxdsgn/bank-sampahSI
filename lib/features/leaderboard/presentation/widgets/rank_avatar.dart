import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Avatar lingkaran berisi inisial warga.
class RankAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Color? borderColor;

  const RankAvatar({
    super.key,
    required this.initials,
    this.size = 44,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.menuIconBg,
        shape: BoxShape.circle,
        border: borderColor == null
            ? null
            : Border.all(color: borderColor!, width: 3),
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.34,
          fontWeight: FontWeight.w700,
          color: AppColors.homeGreenDark,
        ),
      ),
    );
  }
}
