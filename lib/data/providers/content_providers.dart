import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/collection.dart';
import '../models/dhikr.dart';
import '../models/wird.dart';
import '../repositories/adhkar_repository.dart';
import '../repositories/collections_repository.dart';
import '../repositories/wirds_repository.dart';

part 'content_providers.g.dart';

@Riverpod(keepAlive: true)
AssetBundle assetBundle(Ref ref) => rootBundle;

@Riverpod(keepAlive: true)
Future<Map<String, Dhikr>> adhkarRepository(Ref ref) async {
  final bundle = ref.watch(assetBundleProvider);
  return AdhkarRepository(bundle).loadAll();
}

@Riverpod(keepAlive: true)
Future<List<Wird>> wirdsRepository(Ref ref) async {
  final bundle = ref.watch(assetBundleProvider);
  return WirdsRepository(bundle).loadAll();
}

@Riverpod(keepAlive: true)
Future<List<Collection>> collectionsRepository(Ref ref) async {
  final bundle = ref.watch(assetBundleProvider);
  return CollectionsRepository(bundle).loadAll();
}

/// Convenience: wirds keyed by id.
@Riverpod(keepAlive: true)
Future<Map<String, Wird>> wirdsById(Ref ref) async {
  final future = ref.watch(wirdsRepositoryProvider.future);
  final list = await future;
  return {for (final w in list) w.id: w};
}

@Riverpod(keepAlive: true)
Future<Map<String, Collection>> collectionsById(Ref ref) async {
  final future = ref.watch(collectionsRepositoryProvider.future);
  final list = await future;
  return {for (final c in list) c.id: c};
}
