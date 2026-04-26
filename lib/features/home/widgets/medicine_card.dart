import 'package:flutter/material.dart';
import 'package:yakssok_front/core/constants/app_colors.dart';
import 'package:yakssok_front/core/constants/app_dimensions.dart';

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
      MedicineCardTone.blue => const _MedicinePalette(
        background: AppColors.medicineBlueBg,
        border: AppColors.medicineBlueBorder,
        chipBackground: AppColors.medicineBlueChip,
        chipForeground: Colors.white,
        titleColor: AppColors.medicineBlueTitle,
        bodyColor: AppColors.medicineBlueBody,
        buttonBackground: AppColors.medicineBlueButton,
        buttonForeground: Colors.white,
        iconBackground: Colors.white,
        iconColor: AppColors.medicineBlueIcon,
        outlinedButton: false,
      ),
      MedicineCardTone.green => const _MedicinePalette(
        background: AppColors.medicineGreenBg,
        border: AppColors.medicineGreenBorder,
        chipBackground: AppColors.medicineGreenChip,
        chipForeground: Colors.white,
        titleColor: AppColors.medicineGreenTitle,
        bodyColor: AppColors.medicineGreenBody,
        buttonBackground: Colors.white,
        buttonForeground: AppColors.medicineGreenButton,
        iconBackground: Colors.white,
        iconColor: AppColors.medicineGreenIcon,
        outlinedButton: true,
      ),
      MedicineCardTone.red => const _MedicinePalette(
        background: AppColors.medicineRedBg,
        border: AppColors.medicineRedBorder,
        chipBackground: AppColors.medicineRedChip,
        chipForeground: Colors.white,
        titleColor: AppColors.medicineRedTitle,
        bodyColor: AppColors.medicineRedBody,
        buttonBackground: AppColors.medicineRedButton,
        buttonForeground: Colors.white,
        iconBackground: Colors.white,
        iconColor: AppColors.medicineRedIcon,
        outlinedButton: false,
      ),
    };

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.medicineCardPaddingL,
        AppDimensions.medicineCardPaddingT,
        AppDimensions.medicineCardPaddingR,
        AppDimensions.medicineCardPaddingB,
      ),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        border: Border.all(
          color: palette.border,
          width: AppDimensions.medicineCardBorderWidth,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.medicineChipPaddingH,
                  vertical: AppDimensions.medicineChipPaddingV,
                ),
                decoration: BoxDecoration(
                  color: palette.chipBackground,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusChip),
                ),
                child: Text(
                  chipText,
                  style: TextStyle(
                    color: palette.chipForeground,
                    fontSize: AppDimensions.fontSizeChip,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                timeText,
                style: TextStyle(
                  color: palette.titleColor,
                  fontSize: AppDimensions.fontSizeTime,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppDimensions.medicineIconContainerSize,
                height: AppDimensions.medicineIconContainerSize,
                decoration: BoxDecoration(
                  color: palette.iconBackground,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusIconContainer),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: AppDimensions.shadowBlurRadius,
                      offset: Offset(0, AppDimensions.shadowOffsetY),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: palette.iconColor,
                  size: AppDimensions.medicineIconSize,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: palette.titleColor,
                        fontSize: AppDimensions.fontSizeTitle,
                        height: AppDimensions.lineHeightTitle,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceXs),
                    Text(
                      description,
                      style: TextStyle(
                        color: palette.bodyColor,
                        fontSize: AppDimensions.fontSizeBody,
                        height: AppDimensions.lineHeightBody,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          SizedBox(
            width: double.infinity,
            height: AppDimensions.medicineButtonHeight,
            child: FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: palette.buttonBackground,
                foregroundColor: palette.buttonForeground,
                elevation: 0,
                side: palette.outlinedButton
                    ? const BorderSide(
                        color: AppColors.medicineGreenButton,
                        width: AppDimensions.medicineButtonBorderWidth,
                      )
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusButton),
                ),
              ),
              icon: Icon(
                tone == MedicineCardTone.blue
                    ? Icons.done_all_rounded
                    : Icons.check_rounded,
                size: AppDimensions.buttonIconSize,
              ),
              label: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeButton,
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
