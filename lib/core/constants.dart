/// 앱 전역 상수. API 키/URL 등 환경 의존 값은 --dart-define에서 주입.
class AppConstants {
  AppConstants._();

  // 식약처 공공데이터 API
  static const String moefBaseUrl = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService';

  /// 빌드 시 주입: flutter run --dart-define=MOEF_API_KEY=xxx
  static const String moefApiKey = String.fromEnvironment('MOEF_API_KEY');

  /// 백엔드 미정. 추후 REST 서버 URL이 확정되면 주입.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  // Supabase (anon key는 공개 키로 클라이언트 노출 허용)
  static const String supabaseUrl = 'https://okdircruppnochiszncs.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9rZGlyY3J1cHBub2NoaXN6bmNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc0MDkyMTUsImV4cCI6MjA5Mjk4NTIxNX0.xq7EHxk5_PnfUn_ArQGUgMg8KXweZ6dk5rbBftCP8FM';

  // 로컬 저장 키
  static const String storageKeyAuthUser = 'auth_user';
  static const String storageKeyMedicines = 'medicines';
  static const String storageKeySchedules = 'schedules';
}
