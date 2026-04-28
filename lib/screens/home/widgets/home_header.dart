import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../widgets/emergency_button.dart';

/// 홈 화면 상단 — 로고 + 긴급 호출 버튼.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.onEmergencyPressed});

  static const _logoPath = 'assets/yakssok_wordmark.png';

  final VoidCallback? onEmergencyPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppDimensions.paddingXs),
          child: Image.asset(
            _logoPath,
            width: 150,
            height: 36,
            fit: BoxFit.contain,
            semanticLabel: AppStrings.appName,
          ),
        ),
        const Spacer(),
        EmergencyButton(onPressed: onEmergencyPressed),
      ],
    );
  }
}
