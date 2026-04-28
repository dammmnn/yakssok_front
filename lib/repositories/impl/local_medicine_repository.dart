import '../../models/medicine.dart';
import '../medicine_repository.dart';

/// 로컬 mock 구현. 백엔드 확정 전까지 메모리에 보관.
class LocalMedicineRepository implements MedicineRepository {
  final List<Medicine> _myMedicines = const [
    Medicine(
      id: 'lipitor',
      name: '리피토',
      company: '한국화이자',
      dosage: '10mg',
    ),
    Medicine(
      id: 'metformin',
      name: '메트포르민',
      company: '대웅제약',
      dosage: '500mg',
    ),
    Medicine(
      id: 'lisinopril',
      name: '리시노프릴',
      company: '종근당',
      dosage: '5mg',
    ),
  ];

  @override
  Future<List<Medicine>> search(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _myMedicines
        .where((m) => m.name.contains(query))
        .toList(growable: false);
  }

  @override
  Future<List<Medicine>> getMyMedicines() async => List.unmodifiable(_myMedicines);

  @override
  Future<Medicine> register(Medicine medicine) async {
    // mock: 실제 저장 없이 그대로 반환.
    return medicine;
  }

  @override
  Future<void> remove(String id) async {}
}
