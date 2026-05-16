// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletionEntryAdapter extends TypeAdapter<CompletionEntry> {
  @override
  final typeId = 3;

  @override
  CompletionEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletionEntry(
      id: fields[0] as String,
      contentType: fields[1] as CompletionContentType,
      contentId: fields[2] as String,
      completedAt: fields[3] as DateTime,
      dateKey: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompletionEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.contentType)
      ..writeByte(2)
      ..write(obj.contentId)
      ..writeByte(3)
      ..write(obj.completedAt)
      ..writeByte(4)
      ..write(obj.dateKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletionEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompletionContentTypeAdapter extends TypeAdapter<CompletionContentType> {
  @override
  final typeId = 11;

  @override
  CompletionContentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CompletionContentType.wird;
      case 1:
        return CompletionContentType.collection;
      default:
        return CompletionContentType.wird;
    }
  }

  @override
  void write(BinaryWriter writer, CompletionContentType obj) {
    switch (obj) {
      case CompletionContentType.wird:
        writer.writeByte(0);
      case CompletionContentType.collection:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletionContentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
