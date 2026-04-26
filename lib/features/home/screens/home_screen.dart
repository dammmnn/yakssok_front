import 'package:flutter/material.dart';
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
    // Load today's medicine list once when the screen opens.
    _todayMedicinesFuture = fetchTodayMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF0A7A33),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 34),
      ),
      body: SafeArea(
        child: FutureBuilder<List<TodayMedicine>>(
          future: _todayMedicinesFuture,
          builder: (context, snapshot) {
            final medicines = snapshot.data ?? const <TodayMedicine>[];

            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 108),
              children: [
                const AppHeader(
                  title: '약쏙',
                  actionLabel: '집 바로가기',
                  logoAssetPath: 'assets/yakssok_logo.png',
                  logoWidth: 44,
                  logoHeight: 44,
                ),
                const SizedBox(height: 22),
                const HomeGreetingSection(),
                const SizedBox(height: 20),
                const HomeProgressCard(),
                const SizedBox(height: 26),
                const HomeSectionHeader(
                  title: '오늘의 약',
                  actionText: '전체 일정',
                ),
                const SizedBox(height: 14),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (snapshot.hasError)
                  const _MedicineStatusCard(
                    message: '오늘의 약 정보를 불러오지 못했어요.',
                  )
                else if (medicines.isEmpty)
                  const _MedicineStatusCard(
                    message: '오늘은 복용할 약이 없어요.',
                  )
                else
                  ..._buildMedicineCards(medicines),
                const SizedBox(height: 26),
                const HealthSummarySection(),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildMedicineCards(List<TodayMedicine> medicines) {
    // Convert fetched data into card widgets for the list.
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
        if (index != medicines.length - 1) const SizedBox(height: 18),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF516074),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
