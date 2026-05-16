import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Channel and payload constants. Payloads deep-link via go_router redirect.
class NotificationChannels {
  const NotificationChannels._();

  static const String dailyWirdChannelId = 'wird_daily';
  static const String dailyWirdChannelName = 'Daily wird reminder';
  static const String collectionChannelId = 'wird_collections';
  static const String collectionChannelName = 'Collection reminders';

  static const String payloadDailyWird = 'open:daily_wird';
  static String payloadCollection(String id) => 'open:collection:$id';
}

class NotificationService {
  NotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  static const int _dailyWirdNotificationId = 1;
  // Collection ids are hashed to a stable int in [_collectionNotificationId].

  static Future<NotificationService> init() async {
    tz_data.initializeTimeZones();
    final localTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimezone.identifier));

    final plugin = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await plugin.initialize(
      settings: const InitializationSettings(android: androidInit, iOS: darwinInit),
    );
    return NotificationService(plugin);
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final granted = await _plugin
              .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
      return granted;
    }
    if (Platform.isAndroid) {
      final granted = await _plugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ??
          true;
      return granted;
    }
    return true;
  }

  Future<void> cancelAll() => _plugin.cancelAll();

  Future<void> scheduleDailyWird({required String hhmm}) async {
    final parts = hhmm.split(':');
    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;

    await _plugin.zonedSchedule(
      id: _dailyWirdNotificationId,
      title: 'Time for your Wird',
      body: 'Take a moment for remembrance.',
      scheduledDate: _nextInstanceOf(hour, minute),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.dailyWirdChannelId,
          NotificationChannels.dailyWirdChannelName,
          channelDescription: 'Daily reminder to recite your Wird.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: NotificationChannels.payloadDailyWird,
    );
  }

  Future<void> scheduleCollection({
    required String collectionId,
    required String collectionName,
    required String hhmm,
  }) async {
    final parts = hhmm.split(':');
    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;

    await _plugin.zonedSchedule(
      id: _collectionNotificationId(collectionId),
      title: collectionName,
      body: 'Take a moment for these duas.',
      scheduledDate: _nextInstanceOf(hour, minute),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.collectionChannelId,
          NotificationChannels.collectionChannelName,
          channelDescription: 'Reminders for individual dua collections.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: NotificationChannels.payloadCollection(collectionId),
    );
  }

  Future<void> cancelCollection(String collectionId) =>
      _plugin.cancel(id: _collectionNotificationId(collectionId));

  Future<void> cancelDailyWird() => _plugin.cancel(id: _dailyWirdNotificationId);

  Future<String?> getInitialPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      return details!.notificationResponse?.payload;
    }
    return null;
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Stable positive int derived from the collection id, well clear of
  /// [_dailyWirdNotificationId]. Mixed using a 32-bit FNV-1a so two collections
  /// never collide in practice.
  int _collectionNotificationId(String id) {
    const int prime = 0x01000193;
    var hash = 0x811C9DC5;
    for (final cu in id.codeUnits) {
      hash = (hash ^ cu) & 0xFFFFFFFF;
      hash = (hash * prime) & 0xFFFFFFFF;
    }
    return 1000 + (hash % 1000000);
  }
}

/// Avoid coupling main.dart and tests to the singleton above.
@visibleForTesting
class FakeNotificationService extends NotificationService {
  FakeNotificationService() : super(FlutterLocalNotificationsPlugin());
}
