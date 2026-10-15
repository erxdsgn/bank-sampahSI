import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CenterFabButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CenterFabButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.fabSize,
      height: AppSizes.fabSize,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          // Glow neon — lapis dekat
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.7),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
          // Glow neon — lapis jauh
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 32,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
          // Glow neon — lapis paling jauh
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 48,
            spreadRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: const Icon(
            Icons.qr_code_scanner,
            color: Colors.black,   // ← hitam biar kontras dengan neon hijau
            size: 26,
          ),
        ),
      ),
    );
  }
}