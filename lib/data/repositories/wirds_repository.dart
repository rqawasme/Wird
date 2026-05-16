import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/wird.dart';

class WirdsRepository {
  const WirdsRepository(this._bundle);

  final AssetBundle _bundle;

  Future<List<Wird>> loadAll() async {
    final raw = await _bundle.loadString('assets/data/wirds.json');
    final decoded = json.decode(raw) as List<dynamic>;
    return decoded
        .map((item) => Wird.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
