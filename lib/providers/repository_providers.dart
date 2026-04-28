import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/auth_repository.dart';
import '../repositories/health_repository.dart';
import '../repositories/impl/local_auth_repository.dart';
import '../repositories/impl/local_health_repository.dart';
import '../repositories/impl/local_medicine_repository.dart';
import '../repositories/impl/local_schedule_repository.dart';
import '../repositories/medicine_repository.dart';
import '../repositories/schedule_repository.dart';
import '../services/medicine_service.dart';

part 'repository_providers.g.dart';

/// 백엔드 교체 지점.
/// 백엔드가 확정되면 LocalXxxRepository → RemoteXxxRepository로 한 줄만 바꾸면 된다.

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) => LocalAuthRepository();

@Riverpod(keepAlive: true)
MedicineRepository medicineRepository(MedicineRepositoryRef ref) =>
    LocalMedicineRepository();

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    LocalScheduleRepository();

@Riverpod(keepAlive: true)
HealthRepository healthRepository(HealthRepositoryRef ref) =>
    LocalHealthRepository();

/// 식약처 API 서비스. 백엔드와 무관하게 항상 사용.
@Riverpod(keepAlive: true)
MedicineService medicineService(MedicineServiceRef ref) => MedicineService();
