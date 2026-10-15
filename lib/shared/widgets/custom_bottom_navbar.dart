import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../models/nav_item_model.dart';
import 'center_fab_button.dart';
import 'navbar_item.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onFabPressed;
  final List<NavItem> items;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
    required this.onFabPressed,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    const double shadowSpace = 30;
    // Berapa px FAB "tenggelam" ke dalam navbar dari tepi atas
    const double fabSink = 0;

    return SizedBox(
      height: AppSizes.navHeight + shadowSpace,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Layer 1: background + shadow
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: AppSizes.navHeight,
            child: CustomPaint(painter: _NavBarPainter()),
          ),

          // Layer 2: ikon navbar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: AppSizes.navHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.navHorizontalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildItem(0),
                  _buildItem(1),
                  const SizedBox(width: AppSizes.fabSize),
                  _buildItem(2),
                  _buildItem(3),
                ],
              ),
            ),
          ),

          // Layer 3: FAB — center 12px DI BAWAH tepi atas navbar
          Positioned(
            left: 0,
            right: 0,
            bottom:
                AppSizes.navHeight - (AppSizes.fabSize / 2) - fabSink,
            child: Center(
              child: CenterFabButton(onPressed: onFabPressed),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return NavbarItem(
      item: items[index],
      isActive: currentIndex == index,
      onTap: () => onTabChanged(index),
    );
  }
}

// ───────────────────────────────────────────
// Painter — shadow 1 lapis, cukup pekat
// ───────────────────────────────────────────
class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    // Shadow: 1 lapis, opacity 30%, blur 14
    // Tanpa translate — biar shadow hanya menyebar dari tepi path.
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0x4D000000) // 30% hitam
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
    );

    // Isi putih navbar
    canvas.drawPath(path, Paint()..color = AppColors.background);
  }

  Path _buildPath(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cornerRadius = AppSizes.navBorderRadius;
    final double centerX = w / 2;

    // Notch: lebih dalam & lebar
    final double notchHalfWidth = 64;
    final double notchDepth = 38;

    final path = Path();

    // Sudut kiri-atas melengkung
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // Garis atas sampai kiri notch
    path.lineTo(centerX - notchHalfWidth, 0);

    // Kurva S turun ke tengah
    path.cubicTo(
      centerX - notchHalfWidth * 0.5, 0,
      centerX - notchHalfWidth * 0.5, notchDepth,
      centerX, notchDepth,
    );

    // Kurva S naik dari tengah
    path.cubicTo(
      centerX + notchHalfWidth * 0.5, notchDepth,
      centerX + notchHalfWidth * 0.5, 0,
      centerX + notchHalfWidth, 0,
    );

    // Garis atas sampai kanan-atas
    path.lineTo(w - cornerRadius, 0);
    path.quadraticBezierTo(w, 0, w, cornerRadius);

    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}