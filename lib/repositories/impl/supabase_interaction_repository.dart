import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/drug_interaction.dart';
import '../interaction_repository.dart';

class SupabaseInteractionRepository implements InteractionRepository {
  SupabaseClient get _db => Supabase.instance.client;

  @override
  Future<List<DrugInteraction>> checkInteractions(
      List<String> medicineNames) async {
    if (medicineNames.length < 2) return [];

    final data = await _db.from('drug_interactions').select().or(
          medicineNames
              .expand((a) => medicineNames
                  .where((b) => b != a)
                  .map((b) => 'and(drug_a_name.eq.$a,drug_b_name.eq.$b)'))
              .join(','),
        );

    return (data as List)
        .map((row) => _fromRow(row as Map<String, dynamic>))
        .toList();
  }

  DrugInteraction _fromRow(Map<String, dynamic> row) => DrugInteraction(
        id: row['id'] as String,
        drugAName: row['drug_a_name'] as String,
        drugBName: row['drug_b_name'] as String,
        severity: InteractionSeverity.values.byName(row['severity'] as String),
        description: row['description'] as String,
      );
}
