import 'package:flutter/material.dart';
import 'package:yakssok_front/features/home/widgets/health_summary_section.dart';
import 'package:yakssok_front/features/home/widgets/home_greeting_section.dart';
import 'package:yakssok_front/features/home/widgets/home_progress_card.dart';
import 'package:yakssok_front/features/home/widgets/home_section_header.dart';
import 'package:yakssok_front/features/home/widgets/medicine_card.dart';
import 'package:yakssok_front/shared/widgets/app_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 108),
        children: const [
          AppHeader(actionLabel: '긴급 호출'),
          SizedBox(height: 22),
          HomeGreetingSection(),
          SizedBox(height: 20),
          HomeProgressCard(),
          SizedBox(height: 26),
          HomeSectionHeader(title: '오늘의 약', actionText: '전체 일정'),
          SizedBox(height: 14),
          MedicineCard(
            tone: MedicineCardTone.blue,
            chipText: '아침 약',
            timeText: '09:45 AM',
            title: '리피토',
            description: '1알 · 아침 식사 후',
            buttonText: '복용 완료',
            icon: Icons.medication_rounded,
          ),
          SizedBox(height: 18),
          MedicineCard(
            tone: MedicineCardTone.green,
            chipText: '점심 약',
            timeText: '12:30 PM',
            title: '메트포르민',
            description: '500mg · 점심 식사 직후',
            buttonText: '복용하기',
            icon: Icons.medication_liquid_rounded,
          ),
          SizedBox(height: 18),
          MedicineCard(
            tone: MedicineCardTone.red,
            chipText: '알림',
            timeText: '07:00 AM',
            title: '리시노프릴',
            description: '복용 시간을 놓쳤습니다!',
            buttonText: '지금 드세요',
            icon: Icons.warning_amber_rounded,
          ),
          SizedBox(height: 26),
          HealthSummarySection(),
        ],
      ),
    );
  }
}
