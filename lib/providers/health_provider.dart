import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/health_summary.dart';
import 'repository_providers.dart';

part 'health_provider.g.dart';

@riverpod
Future<HealthSummary> todayHealthSummary(TodayHealthSummaryRef ref) {
  return ref.watch(healthRepositoryProvider).getTodaySummary();
}
