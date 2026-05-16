/// Date-key helpers. A date key is a "YYYY-MM-DD" string in the device's
/// local time. We use these rather than raw [DateTime] values so equality and
/// streak math is unaffected by timestamps within a day.
String dateKeyFor(DateTime when) {
  final local = when.toLocal();
  final y = local.year.toString().padLeft(4, '0');
  final m = local.month.toString().padLeft(2, '0');
  final d = local.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

String todayKey({DateTime? now}) => dateKeyFor(now ?? DateTime.now());

/// Returns the key for the day [days] before [from]. Used by streak walking.
String dateKeyOffset(DateTime from, int days) {
  final local = from.toLocal();
  final shifted = DateTime(local.year, local.month, local.day - days);
  return dateKeyFor(shifted);
}
