import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BalanceCard extends StatefulWidget {
  final String balance;
  final String accountNumber;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.accountNumber,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B6B3A),   
            Color(0xFF1BB55C),   // hijau terang
            Color(0xFF00D97E),   // hijau muda mengkilap
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Saldo Tabungan',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                _hidden ? '••••••••' : widget.balance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() => _hidden = !_hidden),
                child: Icon(
                  _hidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          const SizedBox(height: 10),
          Text('No. rek ${widget.accountNumber}',
              style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}