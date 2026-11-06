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
            color: Colors.black.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 14, 14, 0),
      child: Row(
        children: [
          // indikator halaman (vertikal)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.greenDeep,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.hint,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.greenDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.edit_calendar,
                color: AppColors.white, size: 18),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Waktunya persiapan setor sampah!',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Segera input data setoran Anda.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: AppColors.textDark),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {}, // TODO
            child: const Row(
              children: [
                Text(
                  'Klik disini',
                  style: TextStyle(fontSize: 10, color: AppColors.green),
                ),
                Icon(Icons.chevron_right, size: 14, color: AppColors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}