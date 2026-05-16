import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'app.dart';
import 'data/models/app_settings.dart';
import 'data/models/collection_selection.dart';
import 'data/models/completion_entry.dart';
import 'data/providers/hive_box_providers.dart';
import 'data/providers/notification_provider.dart';
import 'data/repositories/collection_selection_repository.dart';
import 'data/repositories/completion_log_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(AppSettingsAdapter())
    ..registerAdapter(ThemeModePrefAdapter())
    ..registerAdapter(CollectionSelectionAdapter())
    ..registerAdapter(CompletionEntryAdapter())
    ..registerAdapter(CompletionContentTypeAdapter());

  final settingsBox =
      await Hive.openBox<AppSettings>(SettingsRepository.boxName);
  final collectionSelectionBox = await Hive.openBox<CollectionSelection>(
    CollectionSelectionRepository.boxName,
  );
  final completionLogBox = await Hive.openBox<CompletionEntry>(
    CompletionLogRepository.boxName,
  );

  final notifications = await NotificationService.init();

  runApp(
    ProviderScope(
      overrides: [
        settingsBoxProvider.overrideWithValue(settingsBox),
        collectionSelectionBoxProvider.overrideWithValue(collectionSelectionBox),
        completionLogBoxProvider.overrideWithValue(completionLogBox),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
      child: const WirdApp(),
    ),
  );
}
