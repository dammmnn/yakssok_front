import 'package:flutter/material.dart';

enum MedicineCardTone { blue, green, red }

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.tone,
    required this.chipText,
    required this.timeText,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
  });

  final MedicineCardTone tone;
  final String chipText;
  final String timeText;
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final palette = switch (tone) {
      MedicineCardTone.blue => _MedicinePalette(
        background: const Color(0xFFEFF6FF),
        border: const Color(0xFFB8D5FF),
        chipBackground: const Color(0xFF2E66E8),
        chipForeground: Colors.white,
        titleColor: const Color(0xFF0D2D8B),
        bodyColor: const Color(0xFF244CB3),
        buttonBackground: const Color(0xFF2F66E8),
        buttonForeground: Colors.white,
        iconBackground: Colors.white,
        iconColor: const Color(0xFF2F66E8),
        outlinedButton: false,
      ),
      MedicineCardTone.green => _MedicinePalette(
        background: const Color(0xFFEFFFF0),
        border: const Color(0xFFA7F0BF),
        chipBackground: const Color(0xFF11A845),
        chipForeground: Colors.white,
        titleColor: const Color(0xFF14321A),
        bodyColor: const Color(0xFF1C6E31),
        buttonBackground: Colors.white,
        buttonForeground: const Color(0xFF08A138),
        iconBackground: Colors.white,
        iconColor: const Color(0xFF18A74A),
        outlinedButton: true,
      ),
      MedicineCardTone.red => _MedicinePalette(
        background: const Color(0xFFFFEEF0),
        border: const Color(0xFFFFBEC5),
        chipBackground: const Color(0xFFEE2C2C),
        chipForeground: Colors.white,
        titleColor: const Color(0xFF661A1D),
        bodyColor: const Color(0xFFC8272A),
        buttonBackground: const Color(0xFFF12D29),
        buttonForeground: Colors.white,
        iconBackground: Colors.white,
        iconColor: const Color(0xFFF12D29),
        outlinedButton: false,
      ),
    };

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: palette.border, width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: palette.chipBackground,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  chipText,
                  style: TextStyle(
                    color: palette.chipForeground,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                timeText,
                style: TextStyle(
                  color: palette.titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: palette.iconBackground,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: palette.iconColor, size: 34),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: palette.titleColor,
                        fontSize: 24,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: palette.bodyColor,
                        fontSize: 15,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: palette.buttonBackground,
                foregroundColor: palette.buttonForeground,
                elevation: 0,
                side: palette.outlinedButton
                    ? const BorderSide(color: Color(0xFF08A138), width: 3)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              icon: Icon(
                tone == MedicineCardTone.blue
                    ? Icons.done_all_rounded
                    : Icons.check_rounded,
                size: 22,
              ),
              label: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicinePalette {
  const _MedicinePalette({
    required this.background,
    required this.border,
    required this.chipBackground,
    required this.chipForeground,
    required this.titleColor,
    required this.bodyColor,
    required this.buttonBackground,
    required this.buttonForeground,
    required this.iconBackground,
    required this.iconColor,
    required this.outlinedButton,
  });

  final Color background;
  final Color border;
  final Color chipBackground;
  final Color chipForeground;
  final Color titleColor;
  final Color bodyColor;
  final Color buttonBackground;
  final Color buttonForeground;
  final Color iconBackground;
  final Color iconColor;
  final bool outlinedButton;
}
