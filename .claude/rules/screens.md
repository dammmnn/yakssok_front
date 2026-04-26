---
description: Screen 및 Widget 작성 규칙
globs:
  - "lib/features/*/screens/**/*.dart"
  - "lib/features/*/widgets/**/*.dart"
  - "lib/shared/widgets/**/*.dart"
---

# Screen / Widget 규칙

## Widget 선택 기준
- IMPORTANT: StatelessWidget 우선. 내부 상태(setState) 필요할 때만 StatefulWidget
- ConsumerWidget: provider를 읽어야 할 때
- ConsumerStatefulWidget: provider + 로컬 상태 둘 다 필요할 때

## const 사용
- IMPORTANT: const 생성자 항상 사용 (`const SizedBox()`, `const EdgeInsets.all(16)` 등)
- const로 선언 가능한 Widget은 반드시 const
- IMPORTANT: magic number 금지. 수치는 `AppDimensions` 상수로 추출
- IMPORTANT: 색상 직접 하드코딩 금지. `Theme.of(context).colorScheme` 또는 `AppTheme` 색상 상수 사용
- 문자열 라벨/메시지는 `AppStrings` 상수 또는 별도 상수 파일로 분리

## 구현 전 UI 분해 (필수)
- IMPORTANT: Screen 구현을 시작하기 전에 화면을 Widget 조각으로 분해한 목록을 먼저 제시
- Screen 파일은 뼈대(Scaffold + 최상위 레이아웃)만 담당. 나머지는 widgets/에 위임
- 분리 기준 — 아래 중 하나라도 해당하면 별도 Widget 파일:
  - 반복되는 UI 단위 (리스트 아이템, 카드 등)
  - 독립적으로 스크롤·애니메이션되는 섹션
  - 조건에 따라 보이거나 숨겨지는 블록
  - 재사용 가능성이 있는 컴포넌트
- 예시: HomeScreen → `home_screen.dart`(뼈대) + `appointment_card.dart` + `upcoming_section.dart` + `quick_action_bar.dart`

## build() 메서드
- IMPORTANT: build() 80줄 초과 금지. 초과 시 즉시 별도 Widget 파일로 분리
- build() 내 비즈니스 로직 금지 (API 호출, 데이터 변환 등)
- 복잡한 조건 렌더링은 별도 Widget으로 추출

## 파일 구조
```dart
// screens/: 라우트 단위 전체 화면
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  // Scaffold 포함. AppBar, body, bottomSheet 등 레이아웃 담당
}

// widgets/: 재사용 가능한 부품
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment});
  final AppointmentModel appointment;
  // 단일 책임. 외부에서 데이터를 받아 표시만 함
}
```

## 리소스
- 이미지: `CachedNetworkImage` 사용 (NetworkImage 금지)
- 긴 리스트: `ListView.builder` 사용 (ListView children 금지)
- dispose() 필수: TextEditingController, ScrollController, AnimationController, StreamSubscription

## 비동기 UI
- StatefulWidget에서 async 작업 후 반드시 `if (!mounted) return;` 체크
- AsyncValue 상태별 처리: loading/error/data 모두 처리
