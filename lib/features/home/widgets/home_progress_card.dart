import 'package:flutter/material.dart';

class HomeProgressCard extends StatelessWidget {
  const HomeProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A7A33),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오늘의 진행 상황',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2 / 5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const LinearProgressIndicator(
              value: 0.4,
              minHeight: 14,
              backgroundColor: Color(0xFF2E9250),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF85F0A5)),
            ),
          ),
        ],
      ),
    );
  }
}
