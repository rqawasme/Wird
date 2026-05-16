// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final typeId = 1;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      onboardingCompleted: fields[0] == null ? false : fields[0] as bool,
      themeMode:
          fields[1] == null ? ThemeModePref.system : fields[1] as ThemeModePref,
      notificationsEnabled: fields[2] == null ? false : fields[2] as bool,
      selectedWirdIds: (fields[3] as List?)?.cast<String>(),
      wirdNotificationTime: fields[4] as String?,
      arabicFontScale: fields[5] == null ? 1.0 : (fields[5] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.onboardingCompleted)
      ..writeByte(1)
      ..write(obj.themeMode)
      ..writeByte(2)
      ..write(obj.notificationsEnabled)
      ..writeByte(3)
      ..write(obj.selectedWirdIds)
      ..writeByte(4)
      ..write(obj.wirdNotificationTime)
      ..writeByte(5)
      ..write(obj.arabicFontScale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModePrefAdapter extends TypeAdapter<ThemeModePref> {
  @override
  final typeId = 10;

  @override
  ThemeModePref read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModePref.system;
      case 1:
        return ThemeModePref.light;
      case 2:
        return ThemeModePref.dark;
      default:
        return ThemeModePref.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModePref obj) {
    switch (obj) {
      case ThemeModePref.system:
        writer.writeByte(0);
      case ThemeModePref.light:
        writer.writeByte(1);
      case ThemeModePref.dark:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModePrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
