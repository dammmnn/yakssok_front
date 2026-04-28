# 약쏙 (Yak-SSok)

약 복용 관리 앱 — 복약 일정 관리, 약 정보 검색, 복약 달력을 제공합니다.

---

## 기술 스택

| 항목 | 내용 |
|---|---|
| Framework | Flutter (Dart) |
| 상태관리 | Riverpod (riverpod_annotation) |
| 라우팅 | go_router |
| 데이터 모델 | freezed + json_serializable |
| 달력 | table_calendar |
| 네트워크 | Dio |
| 로컬 저장 | shared_preferences |

---

## 시작하기

**요구 사항**
- Flutter 3.x 이상
- Xcode (iOS 빌드용)

**설치 및 실행**

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (freezed / riverpod)
dart run build_runner build --delete-conflicting-outputs

# 실행
flutter run
```
