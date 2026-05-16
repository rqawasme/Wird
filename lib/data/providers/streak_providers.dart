import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/streak_calculator.dart';
import '../models/completion_entry.dart';
import 'user_state_providers.dart';

part 'streak_providers.g.dart';

/// Streak for the merged daily Wird.
@riverpod
int wirdStreak(Ref ref) {
  final entries = ref.watch(completionLogControllerProvider);
  final keys = entries
      .where((e) =>
          e.contentType == CompletionContentType.wird &&
          e.contentId == kDailyWirdContentId,)
      .map((e) => e.dateKey);
  return calculateStreak(dateKeys: keys);
}

/// Streak for an individual collection.
@riverpod
int collectionStreak(Ref ref, String collectionId) {
  final entries = ref.watch(completionLogControllerProvider);
  final keys = entries
      .where((e) =>
          e.contentType == CompletionContentType.collection &&
          e.contentId == collectionId,)
      .map((e) => e.dateKey);
  return calculateStreak(dateKeys: keys);
}

/// "This month: 22/26"-style summary for the daily Wird.
@riverpod
({int completed, int total}) wirdMonthProgress(Ref ref) {
  final entries = ref.watch(completionLogControllerProvider);
  final keys = entries
      .where((e) =>
          e.contentType == CompletionContentType.wird &&
          e.contentId == kDailyWirdContentId,)
      .map((e) => e.dateKey);
  return thisMonthProgress(dateKeys: keys);
}

@riverpod
({int completed, int total}) collectionMonthProgress(Ref ref, String collectionId) {
  final entries = ref.watch(completionLogControllerProvider);
  final keys = entries
      .where((e) =>
          e.contentType == CompletionContentType.collection &&
          e.contentId == collectionId,)
      .map((e) => e.dateKey);
  return thisMonthProgress(dateKeys: keys);
}

/// True if the daily Wird has been completed today.
@riverpod
bool wirdDoneToday(Ref ref) {
  final entries = ref.watch(completionLogControllerProvider);
  final today = _todayKey();
  return entries.any((e) =>
      e.contentType == CompletionContentType.wird &&
      e.contentId == kDailyWirdContentId &&
      e.dateKey == today,);
}

@riverpod
bool collectionDoneToday(Ref ref, String collectionId) {
  final entries = ref.watch(completionLogControllerProvider);
  final today = _todayKey();
  return entries.any((e) =>
      e.contentType == CompletionContentType.collection &&
      e.contentId == collectionId &&
      e.dateKey == today,);
}

String _todayKey() {
  final now = DateTime.now().toLocal();
  return '${now.year.toString().padLeft(4, '0')}-'
      '${now.month.toString().padLeft(2, '0')}-'
      '${now.day.toString().padLeft(2, '0')}';
}
