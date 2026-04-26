import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.actionLabel,
    this.onActionTap,
  });

  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF0B7A33),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.medication_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Yak-sok',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF161616),
          ),
        ),
        const Spacer(),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFEB3A2D),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33EB3A2D),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
