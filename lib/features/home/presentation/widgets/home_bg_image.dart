import 'package:flutter/material.dart';

class HomeBgImage extends StatelessWidget {
  final String imagePath;
  final double curveDepth;

  const HomeBgImage({
    super.key,
    required this.imagePath,
    this.curveDepth = 40,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HomeBgClipper(curveDepth: curveDepth),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: const Color(0xFF1BB55C), 
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────
// Clipper: bentuk lengkung di bawah
// ───────────────────────────────────────────
class _HomeBgClipper extends CustomClipper<Path> {
  final double curveDepth;

  _HomeBgClipper({required this.curveDepth});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h - curveDepth)
      ..quadraticBezierTo(w / 2, h + curveDepth, 0, h - curveDepth)
      ..close();
  }

  @override
  bool shouldReclip(covariant _HomeBgClipper oldClipper) =>
      oldClipper.curveDepth != curveDepth;
}