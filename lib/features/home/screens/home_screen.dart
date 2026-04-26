import 'package:flutter/material.dart';
import 'package:yakssok_front/core/constants/app_colors.dart';
import 'package:yakssok_front/core/constants/app_dimensions.dart';
import 'package:yakssok_front/core/constants/app_strings.dart';
import 'package:yakssok_front/features/home/data/home_mock_data.dart';
import 'package:yakssok_front/features/home/models/today_medicine.dart';
import 'package:yakssok_front/features/home/widgets/health_summary_section.dart';
import 'package:yakssok_front/features/home/widgets/home_greeting_section.dart';
import 'package:yakssok_front/features/home/widgets/home_progress_card.dart';
import 'package:yakssok_front/features/home/widgets/home_section_header.dart';
import 'package:yakssok_front/features/home/widgets/medicine_card.dart';
import 'package:yakssok_front/shared/widgets/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<TodayMedicine>> _todayMedicinesFuture;

  @override
  void initState() {
    super.initState();
    _todayMedicinesFuture = fetchTodayMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.fabGreen,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: AppDimensions.fabIconSize),
      ),
      body: SafeArea(
        child: FutureBuilder<List<TodayMedicine>>(
          future: _todayMedicinesFuture,
          builder: (context, snapshot) {
            final medicines = snapshot.data ?? const <TodayMedicine>[];

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.homeListPaddingH,
                AppDimensions.homeListPaddingTop,
                AppDimensions.homeListPaddingH,
                AppDimensions.homeListPaddingBottom,
              ),
              children: [
                const AppHeader(
                  title: AppStrings.appTitle,
                  actionLabel: AppStrings.homeActionLabel,
                  logoAssetPath: 'assets/yakssok_logo.png',
                  logoWidth: AppDimensions.appLogoSize,
                  logoHeight: AppDimensions.appLogoSize,
                ),
                const SizedBox(height: AppDimensions.spaceXl),
                const HomeGreetingSection(),
                const SizedBox(height: AppDimensions.spaceL),
                const HomeProgressCard(),
                const SizedBox(height: AppDimensions.spaceXxl),
                const HomeSectionHeader(
                  title: AppStrings.todayMedicine,
                  actionText: AppStrings.fullSchedule,
                ),
                const SizedBox(height: AppDimensions.spaceS),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.loadingPaddingV,
                      ),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (snapshot.hasError)
                  const _MedicineStatusCard(
                    message: AppStrings.medicineLoadError,
                  )
                else if (medicines.isEmpty)
                  const _MedicineStatusCard(
                    message: AppStrings.medicineEmpty,
                  )
                else
                  ..._buildMedicineCards(medicines),
                const SizedBox(height: AppDimensions.spaceXxl),
                const HealthSummarySection(),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildMedicineCards(List<TodayMedicine> medicines) {
    return [
      for (var index = 0; index < medicines.length; index++) ...[
        MedicineCard(
          tone: medicines[index].tone,
          chipText: medicines[index].chipText,
          timeText: medicines[index].timeText,
          title: medicines[index].title,
          description: medicines[index].description,
          buttonText: medicines[index].buttonText,
          icon: medicines[index].icon,
        ),
        if (index != medicines.length - 1)
          const SizedBox(height: AppDimensions.spaceM),
      ],
    ];
  }
}

class _MedicineStatusCard extends StatelessWidget {
  const _MedicineStatusCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.statusCardPaddingH,
        vertical: AppDimensions.statusCardPaddingV,
      ),
      decoration: BoxDecoration(
        color: AppColors.medicineStatusCardBg,
        borderRadius: BorderRadius.circular(AppDimensions.radiusStatusCard),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.medicineStatusCardText,
          fontSize: AppDimensions.statusCardFontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
