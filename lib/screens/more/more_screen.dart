import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme.dart';
import 'widgets/more_menu_item.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static const _logoPath = 'assets/yakssok_wordmark.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            centerTitle: true,
            title: Image.asset(
              _logoPath,
              width: 128,
              height: 32,
              fit: BoxFit.contain,
              semanticLabel: AppStrings.appName,
            ),
            toolbarHeight: 64,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.paddingXl,
              AppDimensions.paddingMd,
              AppDimensions.paddingXl,
              AppDimensions.paddingXxl,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.moreTitle,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: AppDimensions.paddingXl),
                  const _MenuCard(),
                  const SizedBox(height: AppDimensions.paddingXxl),
                  const _DailyQuoteCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: const Column(
          children: [
            MoreMenuItem(
              icon: Icons.bookmark_rounded,
              iconColor: AppColors.progressTeal,
              iconBackgroundColor: Color(0xFFE6FAF8),
              label: AppStrings.moreSavedMedicine,
            ),
            MoreMenuItem(
              icon: Icons.favorite_rounded,
              iconColor: AppColors.lunchPrimary,
              iconBackgroundColor: AppColors.lunchBg,
              label: AppStrings.moreHealthInfo,
            ),
            MoreMenuItem(
              icon: Icons.person_rounded,
              iconColor: AppColors.morningPrimary,
              iconBackgroundColor: AppColors.morningBg,
              label: AppStrings.moreMyInfo,
            ),
            MoreMenuItem(
              icon: Icons.settings_rounded,
              iconColor: AppColors.textSecondary,
              iconBackgroundColor: AppColors.background,
              label: AppStrings.moreSettings,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyQuoteCard extends StatefulWidget {
  const _DailyQuoteCard();

  @override
  State<_DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends State<_DailyQuoteCard> {
  late final String _quote;

  @override
  void initState() {
    super.initState();
    final index = Random().nextInt(AppStrings.moreDailyQuotes.length);
    _quote = AppStrings.moreDailyQuotes[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.format_quote_rounded,
                color: AppColors.progressTeal,
                size: AppDimensions.iconLg,
              ),
              const SizedBox(width: AppDimensions.paddingSm),
              Text(
                AppStrings.moreDailyQuoteTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.progressTeal,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          Text(
            _quote,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
