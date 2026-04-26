# Flutter Team Project

## 프로젝트 개요
- Flutter 모바일 앱 (6인 팀: 프론트 2명, 백엔드 2명, AI 2명)
- 상태관리: Riverpod (flutter_riverpod + riverpod_annotation)
- 라우팅: go_router
- 네트워크: dio + retrofit
- 데이터 모델: freezed + json_serializable

## 디렉토리 구조 (절대 변경 금지)
```
lib/
  main.dart
  core/            → 공통 인프라 (2명 합의 후 수정)
    constants/
    theme/
    router/
    network/
    utils/
  features/        → 기능별 폴더 (화면 단위 분담)
    {feature_name}/
      screens/     → 페이지 Widget
      widgets/     → 해당 기능 전용 Widget
      providers/   → Riverpod provider
      models/      → freezed 데이터 클래스
  shared/          → 2개 이상 feature에서 공유하는 Widget·Model
    widgets/
    models/
```

## 빌드 & 검증 명령어
- 패키지 설치: `flutter pub get`
- 코드 생성: `dart run build_runner build --delete-conflicting-outputs`
- 포맷 체크: `dart format --set-exit-if-changed .`
- 정적 분석: `flutter analyze`
- 테스트: `flutter test`
- IMPORTANT: 코드 변경 후 반드시 `flutter analyze` 실행해서 에러 0개 확인

## 코딩 규칙

### Dart 스타일
- 파일명: snake_case (예: login_screen.dart)
- 클래스명: UpperCamelCase
- 변수/함수: lowerCamelCase
- bool 변수: is/has/can 접두사 (isLoading, hasError)
- private 필드: _ 접두사

### 하드코딩 금지
- IMPORTANT: 숫자 리터럴 직접 사용 금지. 반드시 상수로 추출 (magic number 금지)
- IMPORTANT: 문자열 리터럴 직접 사용 금지 (에러 메시지, 라우트 경로, API 엔드포인트 등)
- 색상값 직접 사용 금지 (`Color(0xFF...)` 금지) → AppTheme 또는 ColorScheme 사용
- 여백/크기 수치: `core/constants/app_dimensions.dart`에 정의 후 참조
- API 엔드포인트: `core/constants/api_constants.dart`에 정의
- 앱 문자열: `core/constants/app_strings.dart`에 정의 (다국어 대비)
- 허용 예외: `0`, `1` 같이 의미가 명확한 경우, `const EdgeInsets.zero` 등 Flutter 기본 상수

### Widget 규칙
- IMPORTANT: StatelessWidget 우선 사용. 상태 필요 없으면 StatefulWidget 금지
- IMPORTANT: const 생성자 적극 활용 (const SizedBox, const EdgeInsets 등)
- IMPORTANT: 화면 구현 전 UI를 Widget 단위로 먼저 분해하고 파일 목록을 제시한 뒤 작성
  - Screen 파일: 전체 레이아웃 뼈대만 (Scaffold, Column/Row 최상위 구조)
  - 각 섹션·카드·리스트 아이템은 별도 Widget 파일로 분리 → features/{feature}/widgets/
- build() 메서드 80줄 이상 시 Widget으로 분리
- build() 내 비즈니스 로직 금지 → provider로 분리

### 상태관리 (Riverpod)
- IMPORTANT: Widget에서 직접 API 호출 금지. 반드시 provider 통해서 호출
- setState는 로컬 UI 상태에만 허용 (예: TextField focus)
- @riverpod annotation 사용 권장

### 비동기 처리
- async/await 사용. then() 체인 금지
- try-catch로 에러 처리 필수
- StatefulWidget에서 async 작업 후 반드시 `if (!mounted) return;` 체크

### 네트워크
- API 응답은 반드시 freezed Model 클래스로 변환
- raw Map<String, dynamic> 직접 사용 금지
- core/network/api_client.dart의 dioProvider 사용

### 리소스 관리
- IMPORTANT: dispose()에서 컨트롤러/구독 해제 (TextEditingController, StreamSubscription 등)
- 이미지: cached_network_image 사용
- ListView 긴 리스트: ListView.builder 사용

## Git 규칙
- 브랜치: feat/기능명, fix/버그명, chore/작업명
- IMPORTANT: main, dev 브랜치에 직접 push 절대 금지
- 커밋 메시지: Conventional Commits (feat:, fix:, chore:, refactor:, test:, docs:)
- 커밋 전 반드시: `dart format . && flutter analyze`

## 변경 시 주의사항
- core/ 폴더 수정 시: 변경 범위와 이유를 설명하고 확인 요청
- shared/ 폴더 수정 시: 의존하는 feature 목록 확인 후 진행
- pubspec.yaml 패키지 추가 시: 추가 이유 설명
- 기존 파일 리팩토링 시: 최소 범위로 변경. 요청하지 않은 부분 수정 금지
