import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/adaptive_ui_settings.dart';

part 'adaptive_ui_provider.g.dart';

const _kLevelKey = 'adaptive_ui_level';

@Riverpod(keepAlive: true)
class AdaptiveUIController extends _$AdaptiveUIController {
  @override
  Future<AdaptiveUISettings> build() async {
    final prefs = await SharedPreferences.getInstance();
    final idx = prefs.getInt(_kLevelKey) ?? 0;
    final level = AdaptiveLevel.values[idx.clamp(0, 2)];
    return AdaptiveUISettings(level: level);
  }

  Future<void> setLevel(AdaptiveLevel level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kLevelKey, level.index);
    state = AsyncData(AdaptiveUISettings(level: level));
  }

  Future<void> upgradeLevel() async {
    final current = state.valueOrNull;
    if (current == null || current.level == AdaptiveLevel.accessible) return;
    await setLevel(AdaptiveLevel.values[current.level.index + 1]);
  }

  Future<void> resetLevel() async {
    await setLevel(AdaptiveLevel.normal);
  }
}
