// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'44319c38d7920334eef94d208dfd391069d7f841';

/// 백엔드 교체 지점.
/// 백엔드가 확정되면 LocalXxxRepository → RemoteXxxRepository로 한 줄만 바꾸면 된다.
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$medicineRepositoryHash() =>
    r'5a79664cfdbfc98eebd35002eeeb280ac5a6bc70';

/// See also [medicineRepository].
@ProviderFor(medicineRepository)
final medicineRepositoryProvider = Provider<MedicineRepository>.internal(
  medicineRepository,
  name: r'medicineRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicineRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MedicineRepositoryRef = ProviderRef<MedicineRepository>;
String _$scheduleRepositoryHash() =>
    r'cd43dbc51a647f9ba527f8abf1b5410b83c6df2a';

/// See also [scheduleRepository].
@ProviderFor(scheduleRepository)
final scheduleRepositoryProvider = Provider<ScheduleRepository>.internal(
  scheduleRepository,
  name: r'scheduleRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scheduleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ScheduleRepositoryRef = ProviderRef<ScheduleRepository>;
String _$healthRepositoryHash() => r'00e394a981b8745b9664d068131c0d4e98240a42';

/// See also [healthRepository].
@ProviderFor(healthRepository)
final healthRepositoryProvider = Provider<HealthRepository>.internal(
  healthRepository,
  name: r'healthRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HealthRepositoryRef = ProviderRef<HealthRepository>;
String _$medicineServiceHash() => r'a2da781ebd1b72110f70c849312f476c1cd364c5';

/// 식약처 API 서비스. 백엔드와 무관하게 항상 사용.
///
/// Copied from [medicineService].
@ProviderFor(medicineService)
final medicineServiceProvider = Provider<MedicineService>.internal(
  medicineService,
  name: r'medicineServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicineServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MedicineServiceRef = ProviderRef<MedicineService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
