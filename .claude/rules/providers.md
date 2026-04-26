---
description: Riverpod provider 작성 규칙
globs:
  - "lib/features/*/providers/**/*.dart"
  - "lib/core/network/**/*.dart"
---

# Riverpod Provider 규칙

## 필수 구조
@riverpod annotation을 사용한다.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'example_provider.g.dart';

// 단순 조회
@riverpod
Future<List<ExampleModel>> exampleList(ExampleListRef ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getExamples();
}

// 상태 변경이 필요한 경우
@riverpod
class ExampleNotifier extends _$ExampleNotifier {
  @override
  AsyncValue<ExampleModel?> build() => const AsyncValue.data(null);

  Future<void> load(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(apiClientProvider).getExample(id));
  }
}
```

## 규칙
- IMPORTANT: Widget에서 직접 API 호출 금지. 반드시 provider 경유
- IMPORTANT: provider 내 BuildContext 사용 금지
- 파일명: `{feature}_provider.dart`
- 비동기 상태는 `AsyncValue<T>` 사용. 별도 isLoading/error 필드 금지
- ref.watch는 build() 최상단에만. 조건문 안에서 watch 금지
- 에러는 try-catch로 잡아 AsyncValue.error로 변환

## setState 허용 범위
- 로컬 UI 상태만 허용: TextField focus, 애니메이션 트리거
- 서버 데이터, 공유 상태는 반드시 provider 사용
