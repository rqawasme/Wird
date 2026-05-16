// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streak for the merged daily Wird.

@ProviderFor(wirdStreak)
final wirdStreakProvider = WirdStreakProvider._();

/// Streak for the merged daily Wird.

final class WirdStreakProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Streak for the merged daily Wird.
  WirdStreakProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'wirdStreakProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wirdStreakHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return wirdStreak(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$wirdStreakHash() => r'62bcf9333bbafb142eaf386d972c5aac019a2859';

/// Streak for an individual collection.

@ProviderFor(collectionStreak)
final collectionStreakProvider = CollectionStreakFamily._();

/// Streak for an individual collection.

final class CollectionStreakProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Streak for an individual collection.
  CollectionStreakProvider._(
      {required CollectionStreakFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'collectionStreakProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionStreakHash();

  @override
  String toString() {
    return r'collectionStreakProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as String;
    return collectionStreak(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionStreakProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectionStreakHash() => r'f634672d89e13aa9448d7ee510609d0eae4d3d07';

/// Streak for an individual collection.

final class CollectionStreakFamily extends $Family
    with $FunctionalFamilyOverride<int, String> {
  CollectionStreakFamily._()
      : super(
          retry: null,
          name: r'collectionStreakProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Streak for an individual collection.

  CollectionStreakProvider call(
    String collectionId,
  ) =>
      CollectionStreakProvider._(argument: collectionId, from: this);

  @override
  String toString() => r'collectionStreakProvider';
}

/// "This month: 22/26"-style summary for the daily Wird.

@ProviderFor(wirdMonthProgress)
final wirdMonthProgressProvider = WirdMonthProgressProvider._();

/// "This month: 22/26"-style summary for the daily Wird.

final class WirdMonthProgressProvider extends $FunctionalProvider<
        ({
          int completed,
          int total,
        }),
        ({
          int completed,
          int total,
        }),
        ({
          int completed,
          int total,
        })>
    with
        $Provider<
            ({
              int completed,
              int total,
            })> {
  /// "This month: 22/26"-style summary for the daily Wird.
  WirdMonthProgressProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'wirdMonthProgressProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wirdMonthProgressHash();

  @$internal
  @override
  $ProviderElement<
      ({
        int completed,
        int total,
      })> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  ({
    int completed,
    int total,
  }) create(Ref ref) {
    return wirdMonthProgress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
      ({
        int completed,
        int total,
      }) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<
          ({
            int completed,
            int total,
          })>(value),
    );
  }
}

String _$wirdMonthProgressHash() => r'b79b230f84ea690e73bf08b9368a19dd65364697';

@ProviderFor(collectionMonthProgress)
final collectionMonthProgressProvider = CollectionMonthProgressFamily._();

final class CollectionMonthProgressProvider extends $FunctionalProvider<
        ({
          int completed,
          int total,
        }),
        ({
          int completed,
          int total,
        }),
        ({
          int completed,
          int total,
        })>
    with
        $Provider<
            ({
              int completed,
              int total,
            })> {
  CollectionMonthProgressProvider._(
      {required CollectionMonthProgressFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'collectionMonthProgressProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionMonthProgressHash();

  @override
  String toString() {
    return r'collectionMonthProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<
      ({
        int completed,
        int total,
      })> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  ({
    int completed,
    int total,
  }) create(Ref ref) {
    final argument = this.argument as String;
    return collectionMonthProgress(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
      ({
        int completed,
        int total,
      }) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<
          ({
            int completed,
            int total,
          })>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionMonthProgressProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectionMonthProgressHash() =>
    r'7ce0f932e3fac72ed2d4e0db9a16a2bfc24556c8';

final class CollectionMonthProgressFamily extends $Family
    with
        $FunctionalFamilyOverride<
            ({
              int completed,
              int total,
            }),
            String> {
  CollectionMonthProgressFamily._()
      : super(
          retry: null,
          name: r'collectionMonthProgressProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CollectionMonthProgressProvider call(
    String collectionId,
  ) =>
      CollectionMonthProgressProvider._(argument: collectionId, from: this);

  @override
  String toString() => r'collectionMonthProgressProvider';
}

/// True if the daily Wird has been completed today.

@ProviderFor(wirdDoneToday)
final wirdDoneTodayProvider = WirdDoneTodayProvider._();

/// True if the daily Wird has been completed today.

final class WirdDoneTodayProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True if the daily Wird has been completed today.
  WirdDoneTodayProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'wirdDoneTodayProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wirdDoneTodayHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return wirdDoneToday(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$wirdDoneTodayHash() => r'2ac378c8bcac531cf54123edb94b505045ba0d3a';

@ProviderFor(collectionDoneToday)
final collectionDoneTodayProvider = CollectionDoneTodayFamily._();

final class CollectionDoneTodayProvider
    extends $FunctionalProvider<bool, bool, bool> with $Provider<bool> {
  CollectionDoneTodayProvider._(
      {required CollectionDoneTodayFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'collectionDoneTodayProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionDoneTodayHash();

  @override
  String toString() {
    return r'collectionDoneTodayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return collectionDoneToday(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionDoneTodayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectionDoneTodayHash() =>
    r'd7f4bdcd46a0d9d444c2f4328dda44e0e4a2994c';

final class CollectionDoneTodayFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  CollectionDoneTodayFamily._()
      : super(
          retry: null,
          name: r'collectionDoneTodayProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CollectionDoneTodayProvider call(
    String collectionId,
  ) =>
      CollectionDoneTodayProvider._(argument: collectionId, from: this);

  @override
  String toString() => r'collectionDoneTodayProvider';
}
