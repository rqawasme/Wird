import 'date_keys.dart';

/// Pure function that turns an unordered set of completion date keys into the
/// user's current streak length, counted backwards from [now].
///
/// Rules:
///   - If today has a completion, the streak includes today and counts
///     consecutive prior days that also have completions.
///   - If today has no completion but yesterday does, the streak is the count
///     of consecutive days ending at yesterday. This avoids penalising users
///     who haven't yet completed their wird today.
///   - If neither today nor yesterday has a completion, the streak is zero.
int calculateStreak({
  required Iterable<String> dateKeys,
  DateTime? now,
}) {
  final keySet = dateKeys.toSet();
  if (keySet.isEmpty) return 0;

  final reference = now ?? DateTime.now();
  final today = todayKey(now: reference);
  final yesterday = dateKeyOffset(reference, 1);

  final hasToday = keySet.contains(today);
  final hasYesterday = keySet.contains(yesterday);

  if (!hasToday && !hasYesterday) return 0;

  var offset = hasToday ? 0 : 1;
  var streak = 0;
  while (keySet.contains(dateKeyOffset(reference, offset))) {
    streak += 1;
    offset += 1;
  }
  return streak;
}

/// Count of completion days inside the current calendar month, relative to
/// [now] (or "today" in local time). Used for the "this month: 22/26" footer
/// on the home cards.
({int completed, int total}) thisMonthProgress({
  required Iterable<String> dateKeys,
  DateTime? now,
}) {
  final reference = (now ?? DateTime.now()).toLocal();
  final prefix =
      '${reference.year.toString().padLeft(4, '0')}-${reference.month.toString().padLeft(2, '0')}';
  final completedSet = <String>{};
  for (final key in dateKeys) {
    if (key.startsWith(prefix)) completedSet.add(key);
  }
  final daysSoFar = reference.day;
  return (completed: completedSet.length, total: daysSoFar);
}
