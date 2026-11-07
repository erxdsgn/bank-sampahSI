import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _QuickMenuItem(
          icon: Icons.recycling,
          color: AppColors.greenDeep,
          label: 'Setor\nSampah',
          onTap: () {}, // TODO: ke halaman setor sampah
        ),
        _QuickMenuItem(
          icon: Icons.shopping_bag,
          color: AppColors.accentYellow,
          label: 'Produk\nDaur Ulang',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.productList);
          },
        ),
        _QuickMenuItem(
          icon: Icons.sell,
          color: AppColors.green,
          label: 'Harga\nSampah',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.priceList);
          },
        ),
        _QuickMenuItem(
          icon: Icons.edit_calendar,
          color: AppColors.greenDeep,
          label: 'Jadwal &\nSetoran',
          onTap: () {}, // TODO
        ),
      ],
    );
  }
}

class _QuickMenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _QuickMenuItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.greenSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.15,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}