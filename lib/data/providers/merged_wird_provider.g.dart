// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merged_wird_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mergedDailyWird)
final mergedDailyWirdProvider = MergedDailyWirdProvider._();

final class MergedDailyWirdProvider extends $FunctionalProvider<
        AsyncValue<MergedWird>, MergedWird, FutureOr<MergedWird>>
    with $FutureModifier<MergedWird>, $FutureProvider<MergedWird> {
  MergedDailyWirdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'mergedDailyWirdProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$mergedDailyWirdHash();

  @$internal
  @override
  $FutureProviderElement<MergedWird> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<MergedWird> create(Ref ref) {
    return mergedDailyWird(ref);
  }
}

String _$mergedDailyWirdHash() => r'c92a1d05fa46ed97293652c9a6660cf77251e9aa';
