import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/collection.dart';
import 'content_providers.dart';
import 'merged_wird_provider.dart';
import 'streak_providers.dart';
import 'user_state_providers.dart';

part 'home_screen_provider.g.dart';

class EnabledCollectionView {
  EnabledCollectionView({
    required this.collection,
    required this.doneToday,
    required this.streak,
    required this.monthCompleted,
    required this.monthTotal,
  });

  final Collection collection;
  final bool doneToday;
  final int streak;
  final int monthCompleted;
  final int monthTotal;
}

class HomeScreenData {
  HomeScreenData({
    required this.hasSelectedWird,
    required this.mergedWird,
    required this.wirdDoneToday,
    required this.wirdStreak,
    required this.wirdMonthCompleted,
    required this.wirdMonthTotal,
    required this.enabledCollections,
  });

  final bool hasSelectedWird;
  final MergedWird mergedWird;
  final bool wirdDoneToday;
  final int wirdStreak;
  final int wirdMonthCompleted;
  final int wirdMonthTotal;
  final List<EnabledCollectionView> enabledCollections;
}

/// Per-collection sync stats, gathered into one record so we can do all the
/// ref.watch calls up-front (before any await) and then assemble the view
/// after the async data lands.
class _PerCollection {
  _PerCollection({
    required this.doneToday,
    required this.streak,
    required this.monthCompleted,
    required this.monthTotal,
  });
  final bool doneToday;
  final int streak;
  final int monthCompleted;
  final int monthTotal;
}

@riverpod
Future<HomeScreenData> homeScreenData(Ref ref) async {
  final settings = ref.watch(settingsControllerProvider);
  final selections = ref.watch(collectionSelectionsControllerProvider);
  final wirdDone = ref.watch(wirdDoneTodayProvider);
  final wirdStreak = ref.watch(wirdStreakProvider);
  final wirdMonth = ref.watch(wirdMonthProgressProvider);
  final mergedFuture = ref.watch(mergedDailyWirdProvider.future);
  final collectionsByIdFuture = ref.watch(collectionsByIdProvider.future);

  final enabled = selections.where((s) => s.enabled).toList()
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  final perCollection = <String, _PerCollection>{};
  for (final sel in enabled) {
    perCollection[sel.collectionId] = _PerCollection(
      doneToday: ref.watch(collectionDoneTodayProvider(sel.collectionId)),
      streak: ref.watch(collectionStreakProvider(sel.collectionId)),
      monthCompleted:
          ref.watch(collectionMonthProgressProvider(sel.collectionId)).completed,
      monthTotal:
          ref.watch(collectionMonthProgressProvider(sel.collectionId)).total,
    );
  }

  final merged = await mergedFuture;
  final collectionsById = await collectionsByIdFuture;

  final views = <EnabledCollectionView>[];
  for (final sel in enabled) {
    final collection = collectionsById[sel.collectionId];
    if (collection == null) continue;
    final data = perCollection[sel.collectionId]!;
    views.add(
      EnabledCollectionView(
        collection: collection,
        doneToday: data.doneToday,
        streak: data.streak,
        monthCompleted: data.monthCompleted,
        monthTotal: data.monthTotal,
      ),
    );
  }

  return HomeScreenData(
    hasSelectedWird: settings.selectedWirdIds.isNotEmpty,
    mergedWird: merged,
    wirdDoneToday: wirdDone,
    wirdStreak: wirdStreak,
    wirdMonthCompleted: wirdMonth.completed,
    wirdMonthTotal: wirdMonth.total,
    enabledCollections: views,
  );
}
