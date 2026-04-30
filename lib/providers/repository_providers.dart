import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/auth_repository.dart';
import '../repositories/health_repository.dart';
import '../repositories/impl/local_health_repository.dart';
import '../repositories/impl/supabase_auth_repository.dart';
import '../repositories/impl/supabase_interaction_repository.dart';
import '../repositories/impl/supabase_medicine_repository.dart';
import '../repositories/impl/supabase_schedule_repository.dart';
import '../repositories/interaction_repository.dart';
import '../repositories/medicine_repository.dart';
import '../repositories/schedule_repository.dart';
import '../services/medicine_service.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    SupabaseAuthRepository();

@Riverpod(keepAlive: true)
MedicineRepository medicineRepository(MedicineRepositoryRef ref) =>
    SupabaseMedicineRepository();

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    SupabaseScheduleRepository();

@Riverpod(keepAlive: true)
HealthRepository healthRepository(HealthRepositoryRef ref) =>
    LocalHealthRepository();

@Riverpod(keepAlive: true)
InteractionRepository interactionRepository(InteractionRepositoryRef ref) =>
    SupabaseInteractionRepository();

/// 식약처 API 서비스. 백엔드와 무관하게 항상 사용.
@Riverpod(keepAlive: true)
MedicineService medicineService(MedicineServiceRef ref) => MedicineService();
