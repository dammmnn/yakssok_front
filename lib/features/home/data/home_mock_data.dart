import 'package:flutter/material.dart';
import 'package:yakssok_front/features/home/models/today_medicine.dart';
import 'package:yakssok_front/features/home/widgets/medicine_card.dart';

// Replace this mock source with an API call later.
Future<List<TodayMedicine>> fetchTodayMedicines() async {
  await Future<void>.delayed(const Duration(milliseconds: 300));

  return const [
    TodayMedicine(
      tone: MedicineCardTone.blue,
      chipText: '아침 약',
      timeText: '09:45 AM',
      title: '리피토',
      description: '아침 식사 후 1정 복용',
      buttonText: '복용 완료',
      icon: Icons.medication_rounded,
    ),
    TodayMedicine(
      tone: MedicineCardTone.green,
      chipText: '점심 약',
      timeText: '12:30 PM',
      title: '메트포르민',
      description: '점심 식사 직후 500mg 복용',
      buttonText: '복용하기',
      icon: Icons.medication_liquid_rounded,
    ),
    TodayMedicine(
      tone: MedicineCardTone.red,
      chipText: '알림',
      timeText: '07:00 AM',
      title: '리시노프릴',
      description: '복용 시간이 지났습니다',
      buttonText: '지금 복용',
      icon: Icons.warning_amber_rounded,
    ),
  ];
}
