import 'package:freezed_annotation/freezed_annotation.dart';

part 'dhikr.freezed.dart';
part 'dhikr.g.dart';

@freezed
abstract class Dhikr with _$Dhikr {
  const factory Dhikr({
    required String id,
    required String title,
    required String arabic,
    required String translation,
    required String transliteration,
    required String virtues,
    required int count,
    required String source,
    @Default(<String>[]) List<String> tags,
    String? repeatGroup,
  }) = _Dhikr;

  factory Dhikr.fromJson(Map<String, dynamic> json) => _$DhikrFromJson(json);
}
