import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/medicine.dart';
import '../medicine_repository.dart';

class SupabaseMedicineRepository implements MedicineRepository {
  SupabaseClient get _db => Supabase.instance.client;

  @override
  Future<List<Medicine>> getMyMedicines() async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return [];
    final data = await _db
        .from('medicines')
        .select()
        .eq('user_id', userId)
        .order('created_at');
    return (data as List)
        .map((row) => _fromRow(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Medicine>> search(String query) async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return [];
    final data = await _db
        .from('medicines')
        .select()
        .eq('user_id', userId)
        .ilike('name', '%$query%');
    return (data as List)
        .map((row) => _fromRow(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Medicine> register(Medicine medicine) async {
    final userId = _db.auth.currentUser!.id;
    final data = await _db
        .from('medicines')
        .insert({
          'user_id': userId,
          'name': medicine.name,
          'image_url': medicine.imageUrl,
          'company': medicine.company,
          'dosage': medicine.dosage,
          'description': medicine.description,
          'cautions': medicine.cautions,
        })
        .select()
        .single();
    return _fromRow(data);
  }

  @override
  Future<void> remove(String id) async {
    await _db.from('medicines').delete().eq('id', id);
  }

  Medicine _fromRow(Map<String, dynamic> row) => Medicine(
        id: row['id'] as String,
        name: row['name'] as String,
        imageUrl: row['image_url'] as String?,
        company: row['company'] as String?,
        dosage: row['dosage'] as String?,
        description: row['description'] as String?,
        cautions: row['cautions'] as String?,
      );
}
