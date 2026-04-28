import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/utils.dart';
import '../../../models/health_summary.dart';

/// 오늘의 건강 요약 — 수분/걸음 가로 2열.
class HealthSummaryCard extends StatelessWidget {
  const HealthSummaryCard({super.key, required this.summary});

  final HealthSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricTile(
            iconBg: AppColors.hydrationBg,
            iconColor: AppColors.hydrationIcon,
            icon: Icons.water_drop_rounded,
            label: AppStrings.hydration,
            value: '${summary.hydrationLiters.toStringAsFixed(1)}L',
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMd),
        Expanded(
          child: _MetricTile(
            iconBg: AppColors.stepsBg,
            iconColor: AppColors.stepsIcon,
            icon: Icons.directions_walk_rounded,
            label: AppStrings.steps,
            value: AppFormat.thousands(summary.steps),
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.value,
  });

  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLg),
      decoration: BoxDecoration(
        color: iconBg,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: AppDimensions.iconLg),
          const SizedBox(height: AppDimensions.paddingMd),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXs),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
