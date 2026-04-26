class AppStrings {
  AppStrings._();

  // App
  static const String appTitle = '약쏙';

  // App header actions
  static const String emergencyCall = '긴급 호출';
  static const String homeActionLabel = '집 바로가기';

  // Home screen section titles
  static const String todayMedicine = '오늘의 약';
  static const String fullSchedule = '전체 일정';

  // Medicine loading states
  static const String medicineLoadError = '오늘의 약 정보를 불러오지 못했어요.';
  static const String medicineEmpty = '오늘은 복용할 약이 없어요.';

  // Medicine card chip labels
  static const String medicineChipMorning = '아침 약';
  static const String medicineChipLunch = '점심 약';
  static const String medicineChipAlert = '알림';

  // Medicine card time labels
  static const String medicineTimeMorning = '09:45 AM';
  static const String medicineTimeLunch = '12:30 PM';
  static const String medicineTimeMissed = '07:00 AM';

  // Medicine names
  static const String medicineLipitor = '리피토';
  static const String medicineMetformin = '메트포르민';
  static const String medicineLisinopril = '리시노프릴';

  // Medicine descriptions
  static const String medicineLipitorDesc = '1알 · 아침 식사 후';
  static const String medicineMetforminDesc = '500mg · 점심 식사 직후';
  static const String medicineLisinoprilDesc = '복용 시간을 놓쳤습니다!';

  // Medicine button labels
  static const String medicineBtnTaken = '복용 완료';
  static const String medicineBtnTake = '복용하기';
  static const String medicineBtnTakeNow = '지금 드세요';
}
