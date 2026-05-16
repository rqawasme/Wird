import 'package:freezed_annotation/freezed_annotation.dart';

part 'wird.freezed.dart';
part 'wird.g.dart';

@freezed
abstract class WirdStep with _$WirdStep {
  const factory WirdStep({
    required String dhikrId,
    int? countOverride,
  }) = _WirdStep;

  factory WirdStep.fromJson(Map<String, dynamic> json) => _$WirdStepFromJson(json);
}

@freezed
abstract class Wird with _$Wird {
  const factory Wird({
    required String id,
    required String title,
    required String subtitle,
    required String cover,
    required String author,
    required String createdAt,
    required int durationMinutes,
    required List<WirdStep> steps,
  }) = _Wird;

  factory Wird.fromJson(Map<String, dynamic> json) => _$WirdFromJson(json);
}
