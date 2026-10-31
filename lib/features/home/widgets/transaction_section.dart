import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../models/transaction.dart';
import 'section_header.dart';

/// Kartu "Riwayat Transaksi" bergaya tiket (ada lekukan & garis putus-putus).
class TransactionSection extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greenSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greenSurfaceBorder),
      ),
      child: Column(
        children: [
          SectionHeader(
            title: 'Riwayat Transaksi',
            bold: false,
            padding: const EdgeInsets.fromLTRB(15, 14, 15, 6),
            onTap: () {}, 
          ),
          const _TicketDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                for (int i = 0; i < transactions.length; i++) ...[
                  _TransactionTile(transaction: transactions[i]),
                  if (i != transactions.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.divider,
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;
  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // TODO: detail transaksi
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.avatarBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.avatarBorder),
              ),
              child: const Icon(
                Icons.recycling,
                color: AppColors.greenDeep,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.amountLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: AppColors.textDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketDivider extends StatelessWidget {
  const _TicketDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 16,
      child: CustomPaint(
        painter: _TicketDividerPainter(
          lineColor: AppColors.divider,
          borderColor: AppColors.greenSurfaceBorder,
          notchColor: AppColors.white, // sama dengan warna latar halaman
        ),
      ),
    );
  }
}

class _TicketDividerPainter extends CustomPainter {
  final Color lineColor;
  final Color borderColor;
  final Color notchColor;

  _TicketDividerPainter({
    required this.lineColor,
    required this.borderColor,
    required this.notchColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const r = 8.0;
    final cy = size.height / 2;

    // garis putus-putus
    final line = Paint()
      ..color = lineColor
      ..strokeWidth = 1.2;
    double x = 20;
    while (x < size.width - 20) {
      canvas.drawLine(
        Offset(x, cy),
        Offset(math.min(x + 8, size.width - 20), cy),
        line,
      );
      x += 14;
    }

    // lekukan kiri & kanan
    final fill = Paint()..color = notchColor;
    final stroke = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final left = Offset(0, cy);
    canvas.drawCircle(left, r, fill);
    canvas.drawArc(
      Rect.fromCircle(center: left, radius: r),
      -math.pi / 2,
      math.pi,
      false,
      stroke,
    );

    final right = Offset(size.width, cy);
    canvas.drawCircle(right, r, fill);
    canvas.drawArc(
      Rect.fromCircle(center: right, radius: r),
      math.pi / 2,
      math.pi,
      false,
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}