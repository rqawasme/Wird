import 'package:hive_ce/hive.dart';

part 'completion_entry.g.dart';

@HiveType(typeId: 11)
enum CompletionContentType {
  @HiveField(0)
  wird,
  @HiveField(1)
  collection,
}

/// Sentinel id used for the merged daily Wird. The user's daily streak is
/// computed over completions with this id so it survives source changes.
const String kDailyWirdContentId = 'daily_wird';

@HiveType(typeId: 3)
class CompletionEntry extends HiveObject {
  CompletionEntry({
    required this.id,
    required this.contentType,
    required this.contentId,
    required this.completedAt,
    required this.dateKey,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  CompletionContentType contentType;

  @HiveField(2)
  String contentId;

  @HiveField(3)
  DateTime completedAt;

  /// "YYYY-MM-DD" in the device's local time at the moment of completion.
  @HiveField(4)
  String dateKey;
}
