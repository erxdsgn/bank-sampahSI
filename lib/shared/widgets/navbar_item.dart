import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../models/nav_item_model.dart';

class NavbarItem extends StatelessWidget {
  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const NavbarItem({
    super.key,
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              size: AppSizes.iconSize,
              color: isActive ? AppColors.primary : AppColors.inactive,
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? AppSizes.indicatorWidth : 0,
              height: AppSizes.indicatorHeight,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSizes.indicatorRadius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}