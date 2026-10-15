import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/balance_card.dart';
import '../widgets/home_bg_image.dart';       // ← ganti
import '../widgets/home_header.dart';
import '../widgets/info_tips_section.dart';
import '../widgets/menu_grid.dart';
import '../widgets/promo_banner.dart';
import '../widgets/transaction_history_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ═══ Background JPG dengan lengkungan ═══
            Positioned(
              top: 0, left: 0, right: 0,
              height: 280,
              child: HomeBgImage(
                imagePath: 'assets/icons/home_bg.jpg',
                curveDepth: 40,
              ),
            ),

            // ═══ Konten ═══
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(userName: 'ERIX AGUNG WIBOWO'),
                Transform.translate(
                  offset: Offset.zero,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -50, left: 12, right: 12,
                        child: PromoBanner(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Klik banner')),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 40,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BalanceCard(
                                balance: 'Rp800.000,00',
                                accountNumber: '8800 8181 8008',
                              ),
                              SizedBox(height: 18),
                              MenuGrid(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                const InfoTipsSection(),
                const SizedBox(height: 24),
                const TransactionHistorySection(),
                const SizedBox(height: 120),
              ],
            ),
          ],
        ),
      ),
    );
  }
}