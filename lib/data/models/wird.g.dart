// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wird.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WirdStep _$WirdStepFromJson(Map<String, dynamic> json) => _WirdStep(
      dhikrId: json['dhikrId'] as String,
      countOverride: (json['countOverride'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WirdStepToJson(_WirdStep instance) => <String, dynamic>{
      'dhikrId': instance.dhikrId,
      'countOverride': instance.countOverride,
    };

_Wird _$WirdFromJson(Map<String, dynamic> json) => _Wird(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      cover: json['cover'] as String,
      author: json['author'] as String,
      createdAt: json['createdAt'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => WirdStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WirdToJson(_Wird instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'cover': instance.cover,
      'author': instance.author,
      'createdAt': instance.createdAt,
      'durationMinutes': instance.durationMinutes,
      'steps': instance.steps,
    };
