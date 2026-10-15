import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.only(
        top: topPadding + 16,
        left: 20,
        right: 20,
        bottom: 44,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Halo,',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 2),
                Text(userName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const _CircleIcon(icon: Icons.emoji_events_outlined),
          const SizedBox(width: 10),
          const _CircleIcon(icon: Icons.headset_mic_outlined),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  const _CircleIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}