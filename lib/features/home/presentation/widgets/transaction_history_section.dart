import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'transaction_item.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      _Tx('Setor Sampah Plastik', 'Hari ini, 09:24', '+Rp12.000', true),
      _Tx('Setor Sampah Kertas', 'Hari ini, 08:15', '+Rp6.000', true),
      _Tx('Setor Sampah Plastik', 'Kemarin, 16:40', '+Rp12.000', true),
      _Tx('Setor Sampah Kertas', 'Kemarin, 14:20', '+Rp6.000', true),
      _Tx('Penarikan Saldo', '12 Okt, 10:05', '-Rp50.000', false),
      _Tx('Setor Sampah Plastik', '11 Okt, 09:30', '+Rp12.000', true),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Riwayat Transaksi',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.homeTextPrimary,
                      )),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lihat semua riwayat')),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      child: Text('semua',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.homeGreen,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(transactions.length, (index) {
              final tx = transactions[index];
              return Column(
                children: [
                  TransactionItem(
                    title: tx.title,
                    date: tx.date,
                    amount: tx.amount,
                    isIncome: tx.isIncome,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Klik: ${tx.title}')),
                      );
                    },
                  ),
                  if (index != transactions.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 72,
                      endIndent: 16,
                      color: Colors.grey.shade100,
                    ),
                ],
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _Tx {
  final String title;
  final String date;
  final String amount;
  final bool isIncome;
  _Tx(this.title, this.date, this.amount, this.isIncome);
}