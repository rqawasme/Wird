import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/dhikr.dart';

class AdhkarRepository {
  const AdhkarRepository(this._bundle);

  final AssetBundle _bundle;

  Future<Map<String, Dhikr>> loadAll() async {
    final raw = await _bundle.loadString('assets/data/adhkar.json');
    final decoded = json.decode(raw) as List<dynamic>;
    final map = <String, Dhikr>{};
    for (final item in decoded) {
      final dhikr = Dhikr.fromJson(item as Map<String, dynamic>);
      map[dhikr.id] = dhikr;
    }
    return map;
  }
}
