import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.title = 'Yak-sok',
    this.actionLabel,
    this.onActionTap,
    this.leadingIcon = Icons.medication_rounded,
    this.leadingBackgroundColor = const Color(0xFF0B7A33),
    this.action,
    this.logoAssetPath,
    this.logoWidth = 40,
    this.logoHeight = 40,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final IconData leadingIcon;
  final Color leadingBackgroundColor;
  final Widget? action;
  final String? logoAssetPath;
  final double logoWidth;
  final double logoHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (logoAssetPath != null)
          Image.asset(
            logoAssetPath!,
            width: logoWidth,
            height: logoHeight,
            fit: BoxFit.contain,
          )
        else
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: leadingBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              leadingIcon,
              color: Colors.white,
              size: 22,
            ),
          ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF161616),
          ),
        ),
        const Spacer(),
        if (action != null) action!,
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
