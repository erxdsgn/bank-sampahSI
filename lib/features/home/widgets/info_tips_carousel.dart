import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class InfoTipsSection extends StatelessWidget {
  const InfoTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> images = [
      'assets/images/tips_1.png',
      'assets/images/tips_2.png',
      'assets/images/tips_3.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Informasi & Tips:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark, 
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lihat semua tips')),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Text(
                    'semua',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green, 
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _TipsCard(
                imagePath: images[index],
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tips ${index + 1} ditekan')),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TipsCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _TipsCard({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: AppColors.greenSurface, 
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: AppColors.green.withValues(alpha: 0.5), 
                ),
                const SizedBox(height: 8),
                Text(
                  'Belum ada gambar',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.green.withValues(alpha: 0.7), 
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}