// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_selection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionSelectionAdapter extends TypeAdapter<CollectionSelection> {
  @override
  final typeId = 2;

  @override
  CollectionSelection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionSelection(
      collectionId: fields[0] as String,
      enabled: fields[1] == null ? false : fields[1] as bool,
      notificationTime: fields[2] as String?,
      sortOrder: fields[3] == null ? 0 : (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CollectionSelection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.collectionId)
      ..writeByte(1)
      ..write(obj.enabled)
      ..writeByte(2)
      ..write(obj.notificationTime)
      ..writeByte(3)
      ..write(obj.sortOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionSelectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
