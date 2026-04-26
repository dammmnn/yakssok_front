---
description: freezed 데이터 모델 작성 규칙
globs:
  - "lib/features/*/models/**/*.dart"
  - "lib/shared/models/**/*.dart"
---

# freezed 모델 규칙

## 필수 구조
모든 데이터 모델은 freezed + json_serializable을 사용한다.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_model.freezed.dart';
part 'example_model.g.dart';

@freezed
class ExampleModel with _$ExampleModel {
  const factory ExampleModel({
    required String id,
    required String name,
    String? optionalField,
  }) = _ExampleModel;

  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);
}
```

## 규칙
- IMPORTANT: `Map<String, dynamic>` 직접 사용 금지. 반드시 freezed 클래스로 변환
- IMPORTANT: nullable 필드는 `?` 표시 필수. `required`와 명확히 구분
- 모델 파일명: `{name}_model.dart` (예: user_model.dart)
- API 응답 전용 모델은 `{name}_response.dart`로 구분
- 코드 생성 후 `.freezed.dart`, `.g.dart` 파일은 git에 포함 (빌드 서버 없음)
- 생성 명령어: `dart run build_runner build --delete-conflicting-outputs`

## 금지
- `dynamic` 타입 사용 금지
- `Map<String, dynamic>` 필드 직접 노출 금지
- 모델 클래스 내 비즈니스 로직 금지 (순수 데이터만)
