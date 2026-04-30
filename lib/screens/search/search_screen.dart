import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../widgets/emergency_button.dart';
import 'camera_screen.dart';

/// 검색 탭 — 음성/카메라/챗봇 진입과 최근 검색 목록.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            title: _SearchHeader(),
            titleSpacing: AppDimensions.paddingXxl,
            toolbarHeight: 64,
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.paddingXxl,
              AppDimensions.paddingXxl,
              AppDimensions.paddingXxl,
              AppDimensions.paddingXxl,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SearchTitle(),
                  SizedBox(height: AppDimensions.paddingXxl),
                  _SearchMethodGrid(),
                  SizedBox(height: AppDimensions.paddingXxl),
                  _RecentSearchSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

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

class _SearchTitle extends StatelessWidget {
  const _SearchTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.searchTitle,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 34,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
        ),
        const SizedBox(height: AppDimensions.paddingSm),
        Text(
          AppStrings.searchSubtitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class _SearchMethodGrid extends StatelessWidget {
  const _SearchMethodGrid();

  @override
  Widget build(BuildContext context) {
    final gridHeight =
        (MediaQuery.sizeOf(context).height * 0.47).clamp(380.0, 520.0);

    return SizedBox(
      height: gridHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 4,
            child: _SearchMethodCard(
              backgroundColor: AppColors.searchVoiceBg,
              iconBackgroundColor: AppColors.searchVoiceIconBg,
              foregroundColor: AppColors.searchVoicePrimary,
              icon: Icons.mic_rounded,
              title: AppStrings.voiceSearch,
              description: AppStrings.voiceSearchDescription,
              isPrimary: true,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingXs),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: _SearchMethodCard(
                    backgroundColor: AppColors.searchCameraBg,
                    iconBackgroundColor: AppColors.searchCameraIconBg,
                    foregroundColor: AppColors.searchCameraPrimary,
                    icon: Icons.camera_alt_rounded,
                    title: AppStrings.cameraSearch,
                    description: AppStrings.cameraSearchDescription,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CameraScreen()),
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXs),
                Expanded(
                  child: _SearchMethodCard(
                    backgroundColor: AppColors.searchChatBg,
                    iconBackgroundColor: AppColors.searchChatIconBg,
                    foregroundColor: AppColors.searchChatPrimary,
                    icon: Icons.smart_toy_rounded,
                    title: AppStrings.chatSearch,
                    description: AppStrings.chatSearchDescription,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchMethodCard extends StatelessWidget {
  const _SearchMethodCard({
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.title,
    required this.description,
    this.isPrimary = false,
    this.onTap,
  });

  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String title;
  final String description;
  final bool isPrimary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isPrimary ? 52 : 40,
                height: isPrimary ? 52 : 40,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: foregroundColor,
                  size: isPrimary ? 28 : 20,
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: foregroundColor,
                            fontSize: isPrimary ? 24 : 16,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.paddingXs),
                        Text(
                          description,
                          style: TextStyle(
                            color: foregroundColor.withValues(alpha: 0.65),
                            fontSize: isPrimary ? 14 : 11,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: foregroundColor.withValues(alpha: 0.5),
                    size: isPrimary ? 18 : 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentSearchSection extends StatelessWidget {
  const _RecentSearchSection();

  static const _items = [
    _RecentSearchItem(
      name: '타이레놀정ㅋㅋ',
      dosage: '500mg',
      searchedAt: '2024.05.15',
      accentColor: AppColors.searchRecentGreen,
      isEmphasized: true,
    ),
    _RecentSearchItem(
      name: '아로나민 골드',
      searchedAt: '2024.05.12',
      accentColor: AppColors.searchRecentBlue,
    ),
    _RecentSearchItem(
      name: '베아제 정',
      searchedAt: '2024.05.10',
      accentColor: AppColors.searchRecentRed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.recentSearchMedicine,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.searchRecentBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXs,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text(AppStrings.clearAll),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXl),
        for (var i = 0; i < _items.length; i++) ...[
          if (i > 0) const SizedBox(height: AppDimensions.paddingLg),
          _RecentMedicineCard(item: _items[i]),
        ],
      ],
    );
  }
}

class _RecentMedicineCard extends StatelessWidget {
  const _RecentMedicineCard({required this.item});

  final _RecentSearchItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.paddingXxl,
            AppDimensions.paddingXl,
            AppDimensions.paddingLg,
            AppDimensions.paddingXl,
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 64,
                decoration: BoxDecoration(
                  color: item.accentColor,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingXxl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: item.isEmphasized ? 23 : 22,
                            fontWeight: item.isEmphasized
                                ? FontWeight.w800
                                : FontWeight.w400,
                            height: 1.25,
                          ),
                    ),
                    if (item.dosage != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.dosage!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                      ),
                    ],
                    const SizedBox(height: AppDimensions.paddingXs),
                    Text(
                      '${AppStrings.searchedAt}: ${item.searchedAt}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.searchChevron,
                size: 44,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentSearchItem {
  const _RecentSearchItem({
    required this.name,
    required this.searchedAt,
    required this.accentColor,
    this.dosage,
    this.isEmphasized = false,
  });

  final String name;
  final String searchedAt;
  final Color accentColor;
  final String? dosage;
  final bool isEmphasized;
}
