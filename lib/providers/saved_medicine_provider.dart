import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/schedule.dart';
import 'schedule_provider.dart';

part 'saved_medicine_provider.g.dart';

class SavedMedicine {
  const SavedMedicine({
    required this.id,
    required this.medicineName,
    this.company,
    this.description,
    this.imageUrl,
    required this.slot,
    required this.doseCount,
    required this.createdAt,
  });

  final String id;
  final String medicineName;
  final String? company;
  final String? description;
  final String? imageUrl;
  final ScheduleSlot slot;
  final int doseCount;
  final DateTime createdAt;

  static ScheduleSlot _slotFromString(String s) => switch (s) {
        'morning' => ScheduleSlot.morning,
        'lunch' => ScheduleSlot.lunch,
        'evening' => ScheduleSlot.evening,
        'bedtime' => ScheduleSlot.bedtime,
        _ => ScheduleSlot.custom,
      };

  factory SavedMedicine.fromRow(Map<String, dynamic> row) => SavedMedicine(
        id: row['id'] as String,
        medicineName: row['medicine_name'] as String,
        company: row['company'] as String?,
        description: row['description'] as String?,
        imageUrl: row['image_url'] as String?,
        slot: _slotFromString(row['slot'] as String),
        doseCount: row['dose_count'] as int,
        createdAt: DateTime.parse(row['created_at'] as String),
      );

  String get slotLabel => switch (slot) {
        ScheduleSlot.morning => '아침',
        ScheduleSlot.lunch => '점심',
        ScheduleSlot.evening => '저녁',
        ScheduleSlot.bedtime => '취침 전',
        ScheduleSlot.custom => '직접 설정',
      };
}

@riverpod
class SavedMedicineController extends _$SavedMedicineController {
  SupabaseClient get _db => Supabase.instance.client;

  @override
  Future<List<SavedMedicine>> build() async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return [];
    final rows = await _db
        .from('user_medicines')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return rows.map((r) => SavedMedicine.fromRow(r)).toList();
  }

  Future<void> add({
    required String medicineName,
    String? company,
    String? description,
    String? imageUrl,
    required ScheduleSlot slot,
    required int doseCount,
  }) async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return;

    const uuid = Uuid();
    final medicineId = uuid.v4();
    final scheduledAt = _scheduledAt(slot);

    // medicines 테이블에 약 등록
    await _db.from('medicines').upsert({
      'id': medicineId,
      'user_id': userId,
      'name': medicineName,
      if (company != null) 'company': company,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
    });

    // schedules 테이블에 오늘 일정 추가 → 홈 화면에 표시
    await _db.from('schedules').insert({
      'user_id': userId,
      'medicine_id': medicineId,
      'scheduled_at': scheduledAt.toIso8601String(),
      'slot': slot.name,
      'status': 'pending',
      'dose_count': doseCount,
    });

    // user_medicines 테이블에 저장 → 내가 저장한 약 화면에 표시
    await _db.from('user_medicines').insert({
      'user_id': userId,
      'medicine_name': medicineName,
      if (company != null) 'company': company,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      'slot': slot.name,
      'dose_count': doseCount,
    });

    ref.invalidateSelf();
    ref.invalidate(todaySchedulesProvider);
  }

  DateTime _scheduledAt(ScheduleSlot slot) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return switch (slot) {
      ScheduleSlot.morning => today.add(const Duration(hours: 8)),
      ScheduleSlot.lunch   => today.add(const Duration(hours: 12)),
      ScheduleSlot.evening => today.add(const Duration(hours: 18)),
      ScheduleSlot.bedtime => today.add(const Duration(hours: 21)),
      ScheduleSlot.custom  => today.add(const Duration(hours: 9)),
    };
  }

  Future<void> remove(String id) async {
    await _db.from('user_medicines').delete().eq('id', id);
    ref.invalidateSelf();
  }
}
