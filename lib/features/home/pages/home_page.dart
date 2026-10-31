import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/home_header.dart';
import '../../home/widgets/info_tips_carousel.dart';
import '../../home/widgets/quick_menu.dart';
import '../../home/widgets/reminder_banner.dart';
import '../../home/widgets/balance_card.dart';
import '../../home/widgets/transaction_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    if (homeProvider.homeData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final data = homeProvider.homeData!;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ═══ BACKGROUND HIJAU ATAS ═══
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 220,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ),

            // ═══ KONTEN ═══
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  bottom: false,
                  child: HomeHeader(userName: data.userName),
                ),

                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -10,
                        left: 0,
                        right: 0,
                        child: ReminderBanner(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Banner pengingat diklik!"),
                              ),
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BalanceCard(
                              balance: data.balance,
                              accountNumber: data.accountNumber,
                            ),
                            const SizedBox(height: 18),
                            const QuickMenu(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                const InfoTipsSection(),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TransactionSection(transactions: data.transactions),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
