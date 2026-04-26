import 'package:flutter/material.dart';

class HealthSummarySection extends StatelessWidget {
  const HealthSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 건강 요약',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF181818),
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                backgroundColor: Color(0xFFFFF7D9),
                iconBackground: Color(0xFFFFE8A6),
                icon: Icons.water_drop_rounded,
                iconColor: Color(0xFFC88900),
                label: '수분',
                value: '1.2L',
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: SummaryCard(
                backgroundColor: Color(0xFFDFF7FF),
                iconBackground: Color(0xFFC5F0FF),
                icon: Icons.directions_walk_rounded,
                iconColor: Color(0xFF0086B4),
                label: '걸음',
                value: '3,420',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.backgroundColor,
    required this.iconBackground,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final Color backgroundColor;
  final Color iconBackground;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF181818),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF181818),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
