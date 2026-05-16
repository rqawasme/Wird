import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_settings.dart';
import '../models/collection_selection.dart';
import '../models/completion_entry.dart';
import '../repositories/collection_selection_repository.dart';
import '../repositories/completion_log_repository.dart';
import '../repositories/settings_repository.dart';
import 'hive_box_providers.dart';

part 'user_state_providers.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository(ref.watch(settingsBoxProvider));
}

@Riverpod(keepAlive: true)
CollectionSelectionRepository collectionSelectionRepository(Ref ref) {
  return CollectionSelectionRepository(ref.watch(collectionSelectionBoxProvider));
}

@Riverpod(keepAlive: true)
CompletionLogRepository completionLogRepository(Ref ref) {
  return CompletionLogRepository(ref.watch(completionLogBoxProvider));
}

/// Surfaces the current settings snapshot. Mutations route through the
/// methods on this controller so widgets only have one source of truth.
@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  AppSettings build() {
    return ref.watch(settingsRepositoryProvider).read();
  }

  Future<void> _persist(AppSettings Function(AppSettings s) edit) async {
    final repo = ref.read(settingsRepositoryProvider);
    final next = await repo.update(edit);
    state = AppSettings(
      onboardingCompleted: next.onboardingCompleted,
      themeMode: next.themeMode,
      notificationsEnabled: next.notificationsEnabled,
      selectedWirdIds: List<String>.of(next.selectedWirdIds),
      wirdNotificationTime: next.wirdNotificationTime,
      arabicFontScale: next.arabicFontScale,
    );
  }

  Future<void> markOnboardingComplete() =>
      _persist((s) => s..onboardingCompleted = true);

  Future<void> setThemeMode(ThemeModePref mode) =>
      _persist((s) => s..themeMode = mode);

  Future<void> setNotificationsEnabled(bool enabled) =>
      _persist((s) => s..notificationsEnabled = enabled);

  Future<void> setSelectedWirdIds(List<String> ids) =>
      _persist((s) => s..selectedWirdIds = List<String>.of(ids));

  Future<void> setWirdNotificationTime(String? hhmm) =>
      _persist((s) => s..wirdNotificationTime = hhmm);

  Future<void> setArabicFontScale(double scale) =>
      _persist((s) => s..arabicFontScale = scale);
}

@Riverpod(keepAlive: true)
class CollectionSelectionsController extends _$CollectionSelectionsController {
  @override
  List<CollectionSelection> build() {
    return ref.watch(collectionSelectionRepositoryProvider).readAll();
  }

  CollectionSelectionRepository get _repo =>
      ref.read(collectionSelectionRepositoryProvider);

  List<CollectionSelection> get _snapshot => _repo.readAll();

  Future<void> setEnabled(String collectionId, {required bool enabled}) async {
    final existing = _repo.read(collectionId);
    final next = existing ??
        CollectionSelection(
          collectionId: collectionId,
          sortOrder: _snapshot.length,
        );
    next.enabled = enabled;
    if (!enabled) next.notificationTime = null;
    await _repo.upsert(next);
    state = _snapshot;
  }

  Future<void> setNotificationTime(String collectionId, String? hhmm) async {
    final existing = _repo.read(collectionId);
    if (existing == null) return;
    existing.notificationTime = hhmm;
    await _repo.upsert(existing);
    state = _snapshot;
  }

  Future<void> reorder(List<String> idsInOrder) async {
    await _repo.reorder(idsInOrder);
    state = _snapshot;
  }
}

@Riverpod(keepAlive: true)
class CompletionLogController extends _$CompletionLogController {
  @override
  List<CompletionEntry> build() {
    return ref.watch(completionLogRepositoryProvider).readAll();
  }

  Future<CompletionEntry> logWird() async {
    final repo = ref.read(completionLogRepositoryProvider);
    final entry = await repo.log(
      type: CompletionContentType.wird,
      contentId: kDailyWirdContentId,
    );
    state = repo.readAll();
    return entry;
  }

  Future<CompletionEntry> logCollection(String collectionId) async {
    final repo = ref.read(completionLogRepositoryProvider);
    final entry = await repo.log(
      type: CompletionContentType.collection,
      contentId: collectionId,
    );
    state = repo.readAll();
    return entry;
  }
}
