// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider extends $FunctionalProvider<
    SettingsRepository,
    SettingsRepository,
    SettingsRepository> with $Provider<SettingsRepository> {
  SettingsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'b5db66695b92b524ac8ca260eecc56a249efd29d';

@ProviderFor(collectionSelectionRepository)
final collectionSelectionRepositoryProvider =
    CollectionSelectionRepositoryProvider._();

final class CollectionSelectionRepositoryProvider extends $FunctionalProvider<
        CollectionSelectionRepository,
        CollectionSelectionRepository,
        CollectionSelectionRepository>
    with $Provider<CollectionSelectionRepository> {
  CollectionSelectionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collectionSelectionRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionSelectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionSelectionRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CollectionSelectionRepository create(Ref ref) {
    return collectionSelectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionSelectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<CollectionSelectionRepository>(value),
    );
  }
}

String _$collectionSelectionRepositoryHash() =>
    r'3c58865bb06b2347c054a7b80742e0e41a45f6c4';

@ProviderFor(completionLogRepository)
final completionLogRepositoryProvider = CompletionLogRepositoryProvider._();

final class CompletionLogRepositoryProvider extends $FunctionalProvider<
    CompletionLogRepository,
    CompletionLogRepository,
    CompletionLogRepository> with $Provider<CompletionLogRepository> {
  CompletionLogRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'completionLogRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$completionLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompletionLogRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CompletionLogRepository create(Ref ref) {
    return completionLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompletionLogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompletionLogRepository>(value),
    );
  }
}

String _$completionLogRepositoryHash() =>
    r'258ce0766513a2b7f6bad8e01cdf0ec55b564177';

/// Surfaces the current settings snapshot. Mutations route through the
/// methods on this controller so widgets only have one source of truth.

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

/// Surfaces the current settings snapshot. Mutations route through the
/// methods on this controller so widgets only have one source of truth.
final class SettingsControllerProvider
    extends $NotifierProvider<SettingsController, AppSettings> {
  /// Surfaces the current settings snapshot. Mutations route through the
  /// methods on this controller so widgets only have one source of truth.
  SettingsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettings>(value),
    );
  }
}

String _$settingsControllerHash() =>
    r'd3538c50478d7f0a7e53c88665a266431bbb64aa';

/// Surfaces the current settings snapshot. Mutations route through the
/// methods on this controller so widgets only have one source of truth.

abstract class _$SettingsController extends $Notifier<AppSettings> {
  AppSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppSettings, AppSettings>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AppSettings, AppSettings>, AppSettings, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CollectionSelectionsController)
final collectionSelectionsControllerProvider =
    CollectionSelectionsControllerProvider._();

final class CollectionSelectionsControllerProvider extends $NotifierProvider<
    CollectionSelectionsController, List<CollectionSelection>> {
  CollectionSelectionsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collectionSelectionsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionSelectionsControllerHash();

  @$internal
  @override
  CollectionSelectionsController create() => CollectionSelectionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CollectionSelection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CollectionSelection>>(value),
    );
  }
}

String _$collectionSelectionsControllerHash() =>
    r'060f62084efa975d3481e417def331228835c007';

abstract class _$CollectionSelectionsController
    extends $Notifier<List<CollectionSelection>> {
  List<CollectionSelection> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<CollectionSelection>, List<CollectionSelection>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<CollectionSelection>, List<CollectionSelection>>,
        List<CollectionSelection>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CompletionLogController)
final completionLogControllerProvider = CompletionLogControllerProvider._();

final class CompletionLogControllerProvider
    extends $NotifierProvider<CompletionLogController, List<CompletionEntry>> {
  CompletionLogControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'completionLogControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$completionLogControllerHash();

  @$internal
  @override
  CompletionLogController create() => CompletionLogController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CompletionEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CompletionEntry>>(value),
    );
  }
}

String _$completionLogControllerHash() =>
    r'58267d3db57a0754c084fbc41934d2eba161dd05';

abstract class _$CompletionLogController
    extends $Notifier<List<CompletionEntry>> {
  List<CompletionEntry> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<CompletionEntry>, List<CompletionEntry>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<CompletionEntry>, List<CompletionEntry>>,
        List<CompletionEntry>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
