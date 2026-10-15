import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isIncome;
  final VoidCallback onTap;

  const TransactionItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.homeGreen.withValues(alpha: 0.18),
                      AppColors.homeGreen.withValues(alpha: 0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.recycling,
                    color: AppColors.homeGreen, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.homeTextPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 3),
                    Text(date,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.homeTextSecondary,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(amount,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isIncome
                        ? AppColors.homeGreen
                        : const Color(0xFFE53935),
                  )),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right,
                  color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}