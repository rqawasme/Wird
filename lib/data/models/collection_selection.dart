import 'package:hive_ce/hive.dart';

part 'collection_selection.g.dart';

@HiveType(typeId: 2)
class CollectionSelection extends HiveObject {
  CollectionSelection({
    required this.collectionId,
    this.enabled = false,
    this.notificationTime,
    this.sortOrder = 0,
  });

  @HiveField(0)
  String collectionId;

  @HiveField(1)
  bool enabled;

  @HiveField(2)
  String? notificationTime;

  @HiveField(3)
  int sortOrder;
}
