---
description: 테스트 작성 규칙
globs:
  - "test/**/*.dart"
---

# 테스트 규칙

## 구조
`test/` 디렉토리는 `lib/`와 동일한 구조를 유지한다.
```
test/
  features/
    home/
      providers/
        home_provider_test.dart
      widgets/
        home_screen_test.dart
  shared/
    widgets/
      app_header_test.dart
```

## 테스트 파일명
- `{파일명}_test.dart` (예: home_provider_test.dart)

## Provider 테스트
```dart
void main() {
  group('HomeProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          // 실제 API 대신 mock 주입
          apiClientProvider.overrideWithValue(MockApiClient()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('초기 상태는 loading', () {
      expect(
        container.read(homeProvider),
        const AsyncValue<List<HomeModel>>.loading(),
      );
    });
  });
}
```

## Widget 테스트
```dart
void main() {
  testWidgets('AppointmentCard가 제목을 표시한다', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppointmentCard(title: '팀 미팅'),
      ),
    );

    expect(find.text('팀 미팅'), findsOneWidget);
  });
}
```

## 규칙
- IMPORTANT: 외부 의존성(API, DB)은 반드시 mock으로 대체
- group()으로 연관 테스트 묶기
- 테스트명은 한국어로 "~한다" 형식 (무엇을 하는지 명확히)
- 실행: `flutter test` 또는 `flutter test test/features/home/`
