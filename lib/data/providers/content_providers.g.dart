// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetBundle)
final assetBundleProvider = AssetBundleProvider._();

final class AssetBundleProvider
    extends $FunctionalProvider<AssetBundle, AssetBundle, AssetBundle>
    with $Provider<AssetBundle> {
  AssetBundleProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'assetBundleProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$assetBundleHash();

  @$internal
  @override
  $ProviderElement<AssetBundle> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AssetBundle create(Ref ref) {
    return assetBundle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetBundle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetBundle>(value),
    );
  }
}

String _$assetBundleHash() => r'05918ac73d48cecb019264aef4f8b20db4807660';

@ProviderFor(adhkarRepository)
final adhkarRepositoryProvider = AdhkarRepositoryProvider._();

final class AdhkarRepositoryProvider extends $FunctionalProvider<
        AsyncValue<Map<String, Dhikr>>,
        Map<String, Dhikr>,
        FutureOr<Map<String, Dhikr>>>
    with
        $FutureModifier<Map<String, Dhikr>>,
        $FutureProvider<Map<String, Dhikr>> {
  AdhkarRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adhkarRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adhkarRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Dhikr>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Dhikr>> create(Ref ref) {
    return adhkarRepository(ref);
  }
}

String _$adhkarRepositoryHash() => r'17dddefb9835a2b06396ad8f21d467a3ef6bef1c';

@ProviderFor(wirdsRepository)
final wirdsRepositoryProvider = WirdsRepositoryProvider._();

final class WirdsRepositoryProvider extends $FunctionalProvider<
        AsyncValue<List<Wird>>, List<Wird>, FutureOr<List<Wird>>>
    with $FutureModifier<List<Wird>>, $FutureProvider<List<Wird>> {
  WirdsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'wirdsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wirdsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<List<Wird>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Wird>> create(Ref ref) {
    return wirdsRepository(ref);
  }
}

String _$wirdsRepositoryHash() => r'5baf46082cd585ac35173f531aa1dcbb5c60548e';

@ProviderFor(collectionsRepository)
final collectionsRepositoryProvider = CollectionsRepositoryProvider._();

final class CollectionsRepositoryProvider extends $FunctionalProvider<
        AsyncValue<List<Collection>>,
        List<Collection>,
        FutureOr<List<Collection>>>
    with $FutureModifier<List<Collection>>, $FutureProvider<List<Collection>> {
  CollectionsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collectionsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<List<Collection>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Collection>> create(Ref ref) {
    return collectionsRepository(ref);
  }
}

String _$collectionsRepositoryHash() =>
    r'18d723948a11b568610e57fcbae6153bac3b3887';

/// Convenience: wirds keyed by id.

@ProviderFor(wirdsById)
final wirdsByIdProvider = WirdsByIdProvider._();

/// Convenience: wirds keyed by id.

final class WirdsByIdProvider extends $FunctionalProvider<
        AsyncValue<Map<String, Wird>>,
        Map<String, Wird>,
        FutureOr<Map<String, Wird>>>
    with
        $FutureModifier<Map<String, Wird>>,
        $FutureProvider<Map<String, Wird>> {
  /// Convenience: wirds keyed by id.
  WirdsByIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'wirdsByIdProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wirdsByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Wird>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Wird>> create(Ref ref) {
    return wirdsById(ref);
  }
}

String _$wirdsByIdHash() => r'08e4c4a6c46aa00e42f255ee937f82322080cc46';

@ProviderFor(collectionsById)
final collectionsByIdProvider = CollectionsByIdProvider._();

final class CollectionsByIdProvider extends $FunctionalProvider<
        AsyncValue<Map<String, Collection>>,
        Map<String, Collection>,
        FutureOr<Map<String, Collection>>>
    with
        $FutureModifier<Map<String, Collection>>,
        $FutureProvider<Map<String, Collection>> {
  CollectionsByIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collectionsByIdProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectionsByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Collection>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Collection>> create(Ref ref) {
    return collectionsById(ref);
  }
}

String _$collectionsByIdHash() => r'4592e55ed4c52a0d55b1086e412b5793cf8a2108';
