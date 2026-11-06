import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

/// Banner pengingat yang sebagian tertutup kartu putih di atasnya.
/// Konten diberi padding atas supaya tidak tertutup kartu.
class ReminderBanner extends StatelessWidget {
  const ReminderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greenBanner,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 14, 14, 0),
      child: const Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Konten banner pengingat
            ],
          ),
        ],
      ),
    );
  }
}
