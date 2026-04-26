import 'package:flutter/material.dart';

class HomeGreetingSection extends StatelessWidget {
  const HomeGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '좋은 아침이에요,',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1D1D1D),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '참 잘하고 계세요!',
          style: TextStyle(
            fontSize: 31,
            height: 1.15,
            fontWeight: FontWeight.w900,
            color: Color(0xFF111111),
          ),
        ),
      ],
    );
  }
}
