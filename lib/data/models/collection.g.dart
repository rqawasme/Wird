// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Collection _$CollectionFromJson(Map<String, dynamic> json) => _Collection(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      period: $enumDecodeNullable(_$CollectionPeriodEnumMap, json['period']),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => WirdStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionToJson(_Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'tags': instance.tags,
      'period': _$CollectionPeriodEnumMap[instance.period],
      'durationMinutes': instance.durationMinutes,
      'steps': instance.steps,
    };

const _$CollectionPeriodEnumMap = {
  CollectionPeriod.morning: 'morning',
  CollectionPeriod.evening: 'evening',
  CollectionPeriod.beforeSleep: 'beforeSleep',
  CollectionPeriod.afterSalah: 'afterSalah',
  CollectionPeriod.anytime: 'anytime',
};
