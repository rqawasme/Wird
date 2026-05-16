import 'package:hive_ce/hive.dart';

import '../models/collection_selection.dart';

class CollectionSelectionRepository {
  CollectionSelectionRepository(this._box);

  static const String boxName = 'collection_selections';

  final Box<CollectionSelection> _box;

  List<CollectionSelection> readAll() {
    final list = _box.values.toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return list;
  }

  CollectionSelection? read(String id) => _box.get(id);

  Future<CollectionSelection> upsert(CollectionSelection selection) async {
    await _box.put(selection.collectionId, selection);
    return selection;
  }

  Future<void> delete(String id) => _box.delete(id);

  Future<void> reorder(List<String> idsInOrder) async {
    for (var i = 0; i < idsInOrder.length; i++) {
      final id = idsInOrder[i];
      final existing = _box.get(id);
      if (existing == null) continue;
      existing.sortOrder = i;
      await existing.save();
    }
  }
}
