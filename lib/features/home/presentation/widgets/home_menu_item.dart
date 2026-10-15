import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HomeMenuItem extends StatelessWidget {
  final String assetName;
  final String label;
  final VoidCallback onTap;

  const HomeMenuItem({
    super.key,
    required this.assetName,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.menuIconBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Image.asset(
                assetName,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.image_outlined,
                  color: AppColors.homeGreen,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.homeTextPrimary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}