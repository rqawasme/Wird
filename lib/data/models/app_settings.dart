import 'package:hive_ce/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 10)
enum ThemeModePref {
  @HiveField(0)
  system,
  @HiveField(1)
  light,
  @HiveField(2)
  dark,
}

@HiveType(typeId: 1)
class AppSettings extends HiveObject {
  AppSettings({
    this.onboardingCompleted = false,
    this.themeMode = ThemeModePref.system,
    this.notificationsEnabled = false,
    List<String>? selectedWirdIds,
    this.wirdNotificationTime,
    this.arabicFontScale = 1.0,
  }) : selectedWirdIds = selectedWirdIds ?? <String>[];

  @HiveField(0)
  bool onboardingCompleted;

  @HiveField(1)
  ThemeModePref themeMode;

  @HiveField(2)
  bool notificationsEnabled;

  @HiveField(3)
  List<String> selectedWirdIds;

  /// "HH:mm" 24-hour local time. Null when no daily reminder is set.
  @HiveField(4)
  String? wirdNotificationTime;

  /// Stub for v2. Default 1.0 — the slider in settings is disabled for now.
  @HiveField(5)
  double arabicFontScale;
}
