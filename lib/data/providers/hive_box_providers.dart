import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';

import '../models/app_settings.dart';
import '../models/collection_selection.dart';
import '../models/completion_entry.dart';

/// Box references are provided here so the controllers below stay
/// override-able. Each is overridden in `main.dart` once the boxes are open.
final settingsBoxProvider = Provider<Box<AppSettings>>((ref) {
  throw UnimplementedError('settingsBoxProvider must be overridden in main()');
});

final collectionSelectionBoxProvider = Provider<Box<CollectionSelection>>((ref) {
  throw UnimplementedError('collectionSelectionBoxProvider must be overridden in main()');
});

final completionLogBoxProvider = Provider<Box<CompletionEntry>>((ref) {
  throw UnimplementedError('completionLogBoxProvider must be overridden in main()');
});
