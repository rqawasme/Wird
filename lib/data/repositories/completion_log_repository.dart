import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/completion_entry.dart';
import '../../utils/date_keys.dart';

class CompletionLogRepository {
  CompletionLogRepository(this._box, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  static const String boxName = 'completion_log';

  final Box<CompletionEntry> _box;
  final Uuid _uuid;

  List<CompletionEntry> readAll() => _box.values.toList(growable: false);

  Iterable<CompletionEntry> readFor({
    required CompletionContentType type,
    required String contentId,
  }) {
    return _box.values
        .where((e) => e.contentType == type && e.contentId == contentId);
  }

  /// Append a completion. If an entry already exists for the same content and
  /// dateKey, it is not duplicated — completing twice in one day still counts
  /// as one day for streak purposes.
  Future<CompletionEntry> log({
    required CompletionContentType type,
    required String contentId,
    DateTime? at,
  }) async {
    final when = at ?? DateTime.now();
    final dateKey = dateKeyFor(when);

    final existing = _box.values.firstWhere(
      (e) => e.contentType == type && e.contentId == contentId && e.dateKey == dateKey,
      orElse: () => _sentinel,
    );
    if (!identical(existing, _sentinel)) return existing;

    final entry = CompletionEntry(
      id: _uuid.v4(),
      contentType: type,
      contentId: contentId,
      completedAt: when,
      dateKey: dateKey,
    );
    await _box.put(entry.id, entry);
    return entry;
  }

  static final CompletionEntry _sentinel = CompletionEntry(
    id: '__sentinel__',
    contentType: CompletionContentType.wird,
    contentId: '__sentinel__',
    completedAt: DateTime.fromMillisecondsSinceEpoch(0),
    dateKey: '',
  );
}
