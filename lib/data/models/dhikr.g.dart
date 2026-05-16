// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dhikr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dhikr _$DhikrFromJson(Map<String, dynamic> json) => _Dhikr(
      id: json['id'] as String,
      title: json['title'] as String,
      arabic: json['arabic'] as String,
      translation: json['translation'] as String,
      transliteration: json['transliteration'] as String,
      virtues: json['virtues'] as String,
      count: (json['count'] as num).toInt(),
      source: json['source'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      repeatGroup: json['repeatGroup'] as String?,
    );

Map<String, dynamic> _$DhikrToJson(_Dhikr instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'arabic': instance.arabic,
      'translation': instance.translation,
      'transliteration': instance.transliteration,
      'virtues': instance.virtues,
      'count': instance.count,
      'source': instance.source,
      'tags': instance.tags,
      'repeatGroup': instance.repeatGroup,
    };
