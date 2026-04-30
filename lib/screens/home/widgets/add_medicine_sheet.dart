import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../models/medicine.dart';
import '../../../models/schedule.dart';
import '../../../providers/saved_medicine_provider.dart';

class AddMedicineSheet extends ConsumerStatefulWidget {
  const AddMedicineSheet({super.key});

  @override
  ConsumerState<AddMedicineSheet> createState() => _AddMedicineSheetState();
}

class _AddMedicineSheetState extends ConsumerState<AddMedicineSheet> {
  final _searchController = TextEditingController();
  Medicine? _selectedMedicine;
  ScheduleSlot? _selectedSlot;
  int _doseCount = 1;

  // 검색 결과 (추후 API 연동 예정 — 현재 mock)
  List<Medicine> _searchResults = [];

  static const _mockMedicines = [
    Medicine(
      id: 'm1',
      name: '타이레놀 (500mg)',
      company: '(주)한국얀센',
      dosage: '500mg',
      description: '해열, 진통, 소염제',
    ),
    Medicine(
      id: 'm2',
      name: '아로나민 골드',
      company: '일동제약',
      description: '비타민 B1 주성분 복합제',
    ),
    Medicine(
      id: 'm3',
      name: '베아제 정',
      company: '대웅제약',
      description: '소화효소제',
    ),
  ];

  static const _slots = [
    (slot: ScheduleSlot.morning, label: '아침'),
    (slot: ScheduleSlot.lunch, label: '점심'),
    (slot: ScheduleSlot.evening, label: '저녁'),
    (slot: ScheduleSlot.bedtime, label: '취침 전'),
    (slot: ScheduleSlot.custom, label: '직접 설정'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    setState(() {
      _searchResults = _mockMedicines
          .where((m) =>
              m.name.toLowerCase().contains(query.toLowerCase()) ||
              (m.company?.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
    });
  }

  Future<void> _onAdd() async {
    if (_selectedMedicine == null || _selectedSlot == null) return;
    await ref.read(savedMedicineControllerProvider.notifier).add(
          medicineName: _selectedMedicine!.name,
          company: _selectedMedicine!.company,
          description: _selectedMedicine!.description,
          imageUrl: _selectedMedicine!.imageUrl,
          slot: _selectedSlot!,
          doseCount: _doseCount,
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final canAdd = _selectedMedicine != null && _selectedSlot != null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusXl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppDimensions.paddingSm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingXxl,
                AppDimensions.paddingLg,
                AppDimensions.paddingMd,
                AppDimensions.paddingLg,
              ),
              child: Row(
                children: [
                  Text(
                    '약 추가하기',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingXxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SearchField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                    ),
                    if (_searchResults.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.paddingMd),
                      ..._searchResults.map((m) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppDimensions.paddingSm),
                            child: _MedicineResultCard(
                              medicine: m,
                              isSelected: _selectedMedicine?.id == m.id,
                              onTap: () => setState(() {
                                _selectedMedicine =
                                    _selectedMedicine?.id == m.id ? null : m;
                              }),
                            ),
                          )),
                    ] else if (_selectedMedicine != null) ...[
                      const SizedBox(height: AppDimensions.paddingMd),
                      _MedicineResultCard(
                        medicine: _selectedMedicine!,
                        isSelected: true,
                        onTap: () =>
                            setState(() => _selectedMedicine = null),
                      ),
                    ],
                    const SizedBox(height: AppDimensions.paddingXxl),
                    Text(
                      '복용 시간',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppDimensions.paddingMd),
                    Wrap(
                      spacing: AppDimensions.paddingSm,
                      runSpacing: AppDimensions.paddingSm,
                      children: _slots
                          .map((s) => _SlotChip(
                                label: s.label,
                                isSelected: _selectedSlot == s.slot,
                                onTap: () =>
                                    setState(() => _selectedSlot = s.slot),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppDimensions.paddingXxl),
                    Text(
                      '복용량',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppDimensions.paddingMd),
                    _DoseCounter(
                      count: _doseCount,
                      onDecrement: () {
                        if (_doseCount > 1) setState(() => _doseCount--);
                      },
                      onIncrement: () => setState(() => _doseCount++),
                    ),
                    const SizedBox(height: AppDimensions.paddingXxl),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingXxl,
                0,
                AppDimensions.paddingXxl,
                AppDimensions.paddingXxl,
              ),
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: canAdd ? _onAdd : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.progressTeal,
                    disabledBackgroundColor:
                        AppColors.progressTeal.withValues(alpha: 0.4),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusXl),
                    ),
                  ),
                  child: const Text(
                    '약 추가하기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: '약 이름을 입력하세요',
        hintStyle: const TextStyle(color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.background,
        suffixIcon: const Icon(Icons.search_rounded,
            color: AppColors.progressTeal),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXl,
          vertical: AppDimensions.paddingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _MedicineResultCard extends StatelessWidget {
  const _MedicineResultCard({
    required this.medicine,
    required this.isSelected,
    required this.onTap,
  });

  final Medicine medicine;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLg),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.progressTealLight,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: medicine.imageUrl != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMd),
                        child: Image.network(medicine.imageUrl!,
                            fit: BoxFit.cover),
                      )
                    : const Icon(Icons.medication_rounded,
                        color: AppColors.progressTeal, size: 32),
              ),
              const SizedBox(width: AppDimensions.paddingLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    if (medicine.company != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        medicine.company!,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    if (medicine.description != null) ...[
                      const SizedBox(height: AppDimensions.paddingXs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingSm,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.progressTealLight,
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusPill),
                        ),
                        child: Text(
                          medicine.description!,
                          style: const TextStyle(
                            color: AppColors.progressTeal,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppDimensions.paddingSm),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.progressTeal
                      : AppColors.background,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Icon(
                  Icons.check_rounded,
                  color:
                      isSelected ? Colors.white : AppColors.textMuted,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXl,
          vertical: AppDimensions.paddingMd,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.progressTealLight : AppColors.background,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColors.progressTeal
                : AppColors.textSecondary,
            fontWeight:
                isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class _DoseCounter extends StatelessWidget {
  const _DoseCounter({
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      child: Row(
        children: [
          _CounterButton(
              icon: Icons.remove_rounded, onTap: onDecrement),
          Expanded(
            child: Center(
              child: Text(
                '$count알',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          _CounterButton(icon: Icons.add_rounded, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: AppColors.textPrimary, size: 22),
        ),
      ),
    );
  }
}
