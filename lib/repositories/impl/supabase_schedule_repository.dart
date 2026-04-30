import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/medicine.dart';
import '../../models/schedule.dart';
import '../schedule_repository.dart';

class SupabaseScheduleRepository implements ScheduleRepository {
  SupabaseClient get _db => Supabase.instance.client;

  @override
  Future<List<Schedule>> getSchedulesByDate(DateTime date) async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return [];
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final data = await _db
        .from('schedules')
        .select('*, medicines(*)')
        .eq('user_id', userId)
        .gte('scheduled_at', start.toIso8601String())
        .lt('scheduled_at', end.toIso8601String())
        .order('scheduled_at');
    return (data as List)
        .map((row) => _fromRow(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Map<DateTime, List<Schedule>>> getSchedulesByMonth(
      int year, int month) async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return {};
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    final data = await _db
        .from('schedules')
        .select('*, medicines(*)')
        .eq('user_id', userId)
        .gte('scheduled_at', start.toIso8601String())
        .lt('scheduled_at', end.toIso8601String());

    final result = <DateTime, List<Schedule>>{};
    for (final row in data as List) {
      final schedule = _fromRow(row as Map<String, dynamic>);
      final key = DateTime(
        schedule.scheduledAt.year,
        schedule.scheduledAt.month,
        schedule.scheduledAt.day,
      );
      (result[key] ??= []).add(schedule);
    }
    return result;
  }

  @override
  Future<({double complianceRate, int streakDays})> getMonthlyStats(
      int year, int month) async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return (complianceRate: 0.0, streakDays: 0);

    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    final data = await _db
        .from('schedules')
        .select('status, scheduled_at')
        .eq('user_id', userId)
        .gte('scheduled_at', start.toIso8601String())
        .lt('scheduled_at', end.toIso8601String());

    final schedules = (data as List).cast<Map<String, dynamic>>();
    final taken = schedules.where((r) => r['status'] == 'taken').length;
    final missed = schedules.where((r) => r['status'] == 'missed').length;
    final total = taken + missed;
    final complianceRate = total == 0 ? 0.0 : taken / total;

    final takenDates = schedules
        .where((r) => r['status'] == 'taken')
        .map((r) {
          final dt = DateTime.parse(r['scheduled_at'] as String);
          return DateTime(dt.year, dt.month, dt.day);
        })
        .toSet();

    final today = DateTime.now();
    var streak = 0;
    var day = DateTime(today.year, today.month, today.day);
    while (takenDates.contains(day)) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }

    return (complianceRate: complianceRate, streakDays: streak);
  }

  @override
  Future<Schedule> add(Schedule schedule) async {
    final userId = _db.auth.currentUser!.id;

    // 약이 DB에 없으면 먼저 등록
    await _db.from('medicines').upsert({
      'id': schedule.medicine.id,
      'user_id': userId,
      'name': schedule.medicine.name,
      'image_url': schedule.medicine.imageUrl,
      'company': schedule.medicine.company,
      'dosage': schedule.medicine.dosage,
      'description': schedule.medicine.description,
      'cautions': schedule.medicine.cautions,
    });

    final data = await _db
        .from('schedules')
        .insert({
          'user_id': userId,
          'medicine_id': schedule.medicine.id,
          'scheduled_at': schedule.scheduledAt.toIso8601String(),
          'slot': schedule.slot.name,
          'status': schedule.status.name,
          'dose_count': schedule.doseCount,
          'meal_relation': schedule.mealRelation,
        })
        .select('*, medicines(*)')
        .single();

    return _fromRow(data);
  }

  @override
  Future<Schedule> markTaken(String scheduleId, {DateTime? takenAt}) async {
    final data = await _db
        .from('schedules')
        .update({
          'status': ScheduleStatus.taken.name,
          'taken_at': (takenAt ?? DateTime.now()).toIso8601String(),
        })
        .eq('id', scheduleId)
        .select('*, medicines(*)')
        .single();
    return _fromRow(data);
  }

  @override
  Future<void> remove(String id) async {
    await _db.from('schedules').delete().eq('id', id);
  }

  Schedule _fromRow(Map<String, dynamic> row) {
    final m = row['medicines'] as Map<String, dynamic>;
    return Schedule(
      id: row['id'] as String,
      medicine: Medicine(
        id: m['id'] as String,
        name: m['name'] as String,
        imageUrl: m['image_url'] as String?,
        company: m['company'] as String?,
        dosage: m['dosage'] as String?,
        description: m['description'] as String?,
        cautions: m['cautions'] as String?,
      ),
      scheduledAt: DateTime.parse(row['scheduled_at'] as String),
      slot: ScheduleSlot.values.byName(row['slot'] as String),
      status: ScheduleStatus.values.byName(row['status'] as String),
      doseCount: row['dose_count'] as int?,
      mealRelation: row['meal_relation'] as String?,
      takenAt: row['taken_at'] != null
          ? DateTime.parse(row['taken_at'] as String)
          : null,
    );
  }
}
