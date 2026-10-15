import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PromoBanner extends StatelessWidget {
  final VoidCallback onTap;

  const PromoBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          top: 45, bottom: 12, left: 12, right: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.homeBannerBg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            const _PageIndicator(),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.homeGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/banner_calendar.png',
                  width: 20, height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.calendar_month, color: Colors.white, size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Waktunya persiapan setor sampah!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.homeGreen,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Segera input data setoran Anda.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.homeTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: const [
                Text('Klik disini',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.homeGreen,
                    )),
                Icon(Icons.chevron_right,
                    color: AppColors.homeGreen, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4, height: 16,
          decoration: BoxDecoration(
            color: AppColors.homeGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 6, height: 6,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}