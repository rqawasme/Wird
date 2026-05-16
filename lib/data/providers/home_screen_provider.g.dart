// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeScreenData)
final homeScreenDataProvider = HomeScreenDataProvider._();

final class HomeScreenDataProvider extends $FunctionalProvider<
        AsyncValue<HomeScreenData>, HomeScreenData, FutureOr<HomeScreenData>>
    with $FutureModifier<HomeScreenData>, $FutureProvider<HomeScreenData> {
  HomeScreenDataProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'homeScreenDataProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$homeScreenDataHash();

  @$internal
  @override
  $FutureProviderElement<HomeScreenData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<HomeScreenData> create(Ref ref) {
    return homeScreenData(ref);
  }
}

String _$homeScreenDataHash() => r'337d0d4d1e5e039cf56d84711209cfc5a09600d8';
