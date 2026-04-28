# YAK-SSOK 프로젝트 (약쏙)

## 프로젝트 개요
복약 관리 Flutter 앱. 사용자가 약을 등록하고 복약 알림을 받으며, 약 정보 검색 및 약국 찾기 기능을 제공한다.

---

## 기술 스택

| 항목 | 선택 |
|---|---|
| Framework | Flutter (Dart) |
| 상태관리 | Riverpod (`flutter_riverpod`) |
| 백엔드 | 미정 (로컬 우선 개발 → 추후 REST API 연동) |
| 약 검색 | 식약처 공공데이터 API |
| HTTP 클라이언트 | Dio |
| 로컬 저장 | shared_preferences |
| 달력 | table_calendar |
| 지도 | google_maps_flutter |
| 알림 | flutter_local_notifications |
| 카메라 | camera + google_ml_kit |
| 음성 인식 | speech_to_text |

---

## 디렉토리 구조

```
lib/
├── main.dart
├── app.dart                          # MaterialApp, 테마, 라우팅
│
├── core/
│   ├── theme.dart                    # 색상, 폰트, 테마
│   ├── constants.dart                # API URL, 앱 상수
│   └── utils.dart                    # 공통 유틸 함수
│
├── models/
│   ├── user.dart
│   ├── medicine.dart                 # 약 정보 모델
│   ├── schedule.dart                 # 복약 일정 모델
│   └── pharmacy.dart                 # 약국 정보 모델
│
├── services/
│   ├── medicine_service.dart         # 식약처 공공데이터 API 연동
│   └── storage_service.dart          # 로컬 저장 (shared_preferences)
│
├── repositories/                     # 백엔드 교체 시 여기만 수정
│   ├── auth_repository.dart          # abstract 인터페이스
│   ├── medicine_repository.dart
│   └── schedule_repository.dart
│
├── repositories/impl/
│   ├── local_auth_repository.dart    # 현재: 로컬 mock 구현체
│   ├── local_medicine_repository.dart
│   └── local_schedule_repository.dart
│   # 백엔드 확정 시 remote_xxx_repository.dart 추가 후 교체
│
├── providers/
│   ├── auth_provider.dart
│   ├── medicine_provider.dart
│   └── schedule_provider.dart
│
├── screens/
│   ├── main_screen.dart              # BottomNavigationBar (홈/검색/달력/더보기)
│   │
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── email_login_screen.dart
│   │   ├── signup_screen.dart        # 관동의 선택
│   │   ├── signup_info_screen.dart   # 정보 입력
│   │   ├── find_id_screen.dart
│   │   └── find_password_screen.dart
│   │
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   │       ├── progress_card.dart        # 오늘의 진행 상황 (2/5)
│   │       ├── medicine_card.dart        # 아침약/점심약/알림 카드
│   │       └── health_summary_card.dart  # 수분, 걸음 요약
│   │
│   ├── search/
│   │   ├── search_screen.dart
│   │   ├── search_result_screen.dart     # 약 인식 결과 상세
│   │   └── widgets/
│   │       ├── search_bar.dart           # 음성/카메라/텍스트 검색
│   │       └── recent_search_item.dart
│   │
│   ├── calendar/
│   │   ├── calendar_screen.dart
│   │   └── widgets/
│   │       └── medicine_schedule_item.dart
│   │
│   ├── pharmacy/
│   │   ├── pharmacy_screen.dart          # 약국 찾기 지도
│   │   └── widgets/
│   │       └── pharmacy_list_item.dart
│   │
│   ├── warning/
│   │   └── medicine_warning_screen.dart  # 복약 경고 (위험 조합)
│   │
│   └── more/
│       ├── more_screen.dart
│       ├── my_page_screen.dart
│       └── widgets/
│           └── more_menu_item.dart
│
└── widgets/                          # 앱 전체 공통 위젯
    ├── custom_button.dart
    ├── emergency_button.dart         # 우측 상단 긴급 호출 버튼
    └── loading_indicator.dart
```

---

## 라우팅 흐름

```
앱 시작
 └── 로그인 여부 확인 (storage_service)
      ├── 미로그인 → /auth/login
      │    ├── /auth/email-login
      │    ├── /auth/signup → /auth/signup-info
      │    ├── /auth/find-id
      │    └── /auth/find-password
      └── 로그인 → /main (BottomNav)
            ├── 홈 ─────────────→ /warning (복약 경고 감지 시)
            ├── 검색 ────────────→ /search/result
            ├── 달력
            └── 더보기 ──────────→ /more/my-page
                                  └── /pharmacy
```

---

## API 연동

### 백엔드 전략 (미정 → 교체 용이한 구조)

백엔드가 확정되기 전까지 **로컬(shared_preferences) 기반**으로 개발.
Repository 패턴을 사용해 백엔드 확정 시 `impl/` 구현체만 교체하면 됨.

```dart
// 현재: 로컬 구현체 주입
final authRepositoryProvider = Provider((ref) => LocalAuthRepository());

// 백엔드 확정 후: 한 줄만 교체
final authRepositoryProvider = Provider((ref) => RemoteAuthRepository(dio));
```

### 백엔드 옵션별 대응
| 옵션 | 추가 패키지 | 작업 범위 |
|---|---|---|
| REST API | `dio` | `remote_xxx_repository.dart` 추가 |
| Firebase | `firebase_core`, `cloud_firestore` | `firebase_xxx_repository.dart` 추가 |
| Supabase | `supabase_flutter` | `supabase_xxx_repository.dart` 추가 |

### 식약처 공공데이터 API (확정)
- 약 검색: `http://apis.data.go.kr/1471000/DrbEasyDrugInfoService`
- 인증키: `constants.dart`의 `moefApiKey`에서 관리 (하드코딩 금지)
- 문서: https://www.data.go.kr

---

## 상태관리 (Riverpod)

```dart
// 예시: 복약 일정 provider
final scheduleProvider = StateNotifierProvider<ScheduleNotifier, List<Schedule>>((ref) {
  return ScheduleNotifier(ref.read(medicineServiceProvider));
});
```

- 인증 상태: `authProvider`
- 약 목록: `medicineProvider`
- 복약 일정: `scheduleProvider`

---

## 주요 기능 정의

### 홈 화면
- 오늘의 복약 진행 상황 표시 (N/5)
- 시간대별 약 카드 (아침/점심/저녁/알림)
- 복약 완료 / 복용하기 / 지금 드세요 액션
- 건강 요약 (수분, 걸음 수)
- 우측 상단 긴급 호출 버튼

### 약 검색
- 텍스트 검색 (식약처 API)
- 음성 검색 (speech_to_text)
- 카메라 인식 (google_ml_kit)
- 최근 검색한 약 목록

### 달력
- 월별 복약 달력 (table_calendar)
- 날짜별 복약 목록 조회

### 약국 찾기
- 현재 위치 기반 주변 약국 표시 (google_maps_flutter)
- 약국 목록 + 거리 표시
- 전화 연결

### 복약 경고
- 위험한 약 조합 감지 시 경고 화면 표시
- 확인 후 복약 진행 or 취소

### 더보기 / 마이페이지
- 내 정보 관리
- 알림 설정
- 로그아웃

---

## 코딩 컨벤션

- 파일명: `snake_case.dart`
- 클래스명: `PascalCase`
- 변수/함수명: `camelCase`
- 위젯은 `StatelessWidget` 우선, 상태 필요 시 `ConsumerWidget` (Riverpod)
- API 호출은 반드시 `services/`에서만 처리
- UI에서 직접 API 호출 금지 → `provider` 경유

---

## 환경 변수 관리

민감한 키는 `--dart-define` 또는 `.env` 파일로 관리, 코드에 하드코딩 금지.

```bash
flutter run --dart-define=API_KEY=your_key_here
```

---

## 패키지 목록 (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  shared_preferences: ^2.2.3   # 로컬 저장 (현재 백엔드 대체)
  table_calendar: ^3.1.2
  google_maps_flutter: ^2.6.0
  flutter_local_notifications: ^17.2.2
  camera: ^0.10.5+9
  google_mlkit_text_recognition: ^0.13.0
  speech_to_text: ^6.6.2
  go_router: ^14.2.0
  dio: ^5.4.3+1                # 식약처 API용 (백엔드 확정 시 REST 연동에도 사용)
```
