import 'package:freezed_annotation/freezed_annotation.dart';

import 'wird.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

enum CollectionPeriod {
  morning,
  evening,
  beforeSleep,
  afterSalah,
  anytime,
}

@freezed
abstract class Collection with _$Collection {
  const factory Collection({
    required String id,
    required String name,
    required String description,
    @Default(<String>[]) List<String> tags,
    CollectionPeriod? period,
    required int durationMinutes,
    required List<WirdStep> steps,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
