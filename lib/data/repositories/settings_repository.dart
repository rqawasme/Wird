import 'package:hive_ce/hive.dart';

import '../models/app_settings.dart';

/// Wraps the single-key settings Hive box. The repository hides the box key
/// so callers can stay focused on intent. Mutation goes through
/// [save] which calls [Box.put] for cross-isolate consistency.
class SettingsRepository {
  SettingsRepository(this._box);

  static const String boxName = 'settings';
  static const String _key = 'singleton';

  final Box<AppSettings> _box;

  AppSettings read() {
    return _box.get(_key) ?? _seed();
  }

  Future<AppSettings> save(AppSettings settings) async {
    await _box.put(_key, settings);
    return settings;
  }

  Future<AppSettings> update(AppSettings Function(AppSettings current) edit) async {
    final next = edit(read());
    return save(next);
  }

  AppSettings _seed() {
    return AppSettings(
      onboardingCompleted: false,
      themeMode: ThemeModePref.system,
      notificationsEnabled: false,
      selectedWirdIds: <String>[],
      arabicFontScale: 1.0,
    );
  }
}
