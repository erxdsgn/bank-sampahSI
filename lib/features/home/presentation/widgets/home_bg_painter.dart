import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HomeBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final curveDepth = 40.0;

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.homeGreen, AppColors.homeGreenDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h + curveDepth));

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h - curveDepth)
      ..quadraticBezierTo(w / 2, h + curveDepth, 0, h - curveDepth)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}