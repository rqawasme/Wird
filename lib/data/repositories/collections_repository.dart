import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/collection.dart';

class CollectionsRepository {
  const CollectionsRepository(this._bundle);

  final AssetBundle _bundle;

  Future<List<Collection>> loadAll() async {
    final raw = await _bundle.loadString('assets/data/collections.json');
    final decoded = json.decode(raw) as List<dynamic>;
    return decoded
        .map((item) => Collection.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
