import 'package:flutter/material.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.actionText,
  });

  final String title;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF181818),
          ),
        ),
        const Spacer(),
        Text(
          actionText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF166734),
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
