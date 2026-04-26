import 'package:flutter/material.dart';
import 'package:yakssok_front/features/home/widgets/medicine_card.dart';

// "오늘의 약" 카드 1개를 그리기 위한 화면용 데이터 모델입니다.
class TodayMedicine {
  const TodayMedicine({
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
}
