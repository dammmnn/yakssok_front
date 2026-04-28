import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme.dart';
import '../../widgets/emergency_button.dart';
import 'widgets/calendar_schedule_section.dart';
import 'widgets/calendar_stats_section.dart';
import 'widgets/medicine_calendar.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            elevation: 0,
            floating: true,
            snap: true,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            title: _CalendarAppBar(),
            titleSpacing: AppDimensions.paddingXl,
            toolbarHeight: 64,
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.paddingXl,
              AppDimensions.paddingMd,
              AppDimensions.paddingXl,
              AppDimensions.paddingXxl,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CalendarTitle(),
                  SizedBox(height: AppDimensions.paddingXl),
                  MedicineCalendar(),
                  SizedBox(height: AppDimensions.paddingXxl),
                  CalendarScheduleSection(),
                  SizedBox(height: AppDimensions.paddingXxl),
                  CalendarStatsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarAppBar extends StatelessWidget {
  const _CalendarAppBar();

  static const _logoPath = 'assets/yakssok_wordmark.png';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          _logoPath,
          width: 128,
          height: 32,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
          semanticLabel: AppStrings.appName,
        ),
        const Spacer(),
        const EmergencyButton(),
      ],
    );
  }
}

class _CalendarTitle extends StatelessWidget {
  const _CalendarTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.calendarTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: AppDimensions.paddingXs),
        Text(
          AppStrings.calendarSubtitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.progressTeal,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
