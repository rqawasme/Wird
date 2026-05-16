import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/content_providers.dart';
import '../../../data/providers/notification_provider.dart';
import '../../../data/providers/user_state_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';

class NotificationsSection extends ConsumerWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final settingsCtl = ref.read(settingsControllerProvider.notifier);
    final selections = ref.watch(collectionSelectionsControllerProvider);
    final selectionsCtl =
        ref.read(collectionSelectionsControllerProvider.notifier);
    final collectionsAsync = ref.watch(collectionsByIdProvider);
    final notifier = ref.read(notificationServiceProvider);

    Future<void> reschedule() async {
      await notifier.cancelAll();
      if (!settings.notificationsEnabled) return;
      final wirdTime = settings.wirdNotificationTime;
      if (wirdTime != null) {
        await notifier.scheduleDailyWird(hhmm: wirdTime);
      }
      for (final sel in selections.where((s) => s.enabled)) {
        final t = sel.notificationTime;
        if (t != null) {
          final name = (await ref.read(collectionsByIdProvider.future))[
                  sel.collectionId]
              ?.name ??
              sel.collectionId;
          await notifier.scheduleCollection(
            collectionId: sel.collectionId,
            collectionName: name,
            hhmm: t,
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('NOTIFICATIONS'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.mihrab.borderSubtle),
          ),
          child: SwitchListTile(
            value: settings.notificationsEnabled,
            onChanged: (v) async {
              await settingsCtl.setNotificationsEnabled(v);
              if (v) {
                await notifier.requestPermission();
              }
              await reschedule();
            },
            title: const Text('Enable notifications'),
            subtitle: Text(
              'Daily reminders for your Wird and collections',
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.mihrab.mutedForeground,
              ),
            ),
          ),
        ),
        if (settings.notificationsEnabled) ...[
          const SizedBox(height: 12),
          _TimeRow(
            label: 'Daily Wird reminder',
            time: _parse(settings.wirdNotificationTime),
            onPick: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _parse(settings.wirdNotificationTime) ??
                    const TimeOfDay(hour: 6, minute: 30),
              );
              if (picked == null) return;
              await settingsCtl.setWirdNotificationTime(_hhmm(picked));
              await reschedule();
            },
          ),
          const SizedBox(height: 16),
          collectionsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
            data: (byId) {
              final enabled =
                  selections.where((s) => s.enabled).toList(growable: false);
              if (enabled.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header('COLLECTION REMINDERS'),
                  const SizedBox(height: 8),
                  for (final sel in enabled) ...[
                    _TimeRow(
                      label: byId[sel.collectionId]?.name ?? sel.collectionId,
                      time: _parse(sel.notificationTime),
                      onPick: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: _parse(sel.notificationTime) ??
                              const TimeOfDay(hour: 21, minute: 0),
                        );
                        if (picked == null) return;
                        await selectionsCtl.setNotificationTime(
                          sel.collectionId,
                          _hhmm(picked),
                        );
                        await reschedule();
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              );
            },
          ),
        ],
      ],
    );
  }

  static TimeOfDay? _parse(String? hhmm) {
    if (hhmm == null) return null;
    final parts = hhmm.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  static String _hhmm(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.label,
    required this.time,
    required this.onPick,
  });

  final String label;
  final TimeOfDay? time;
  final Future<void> Function() onPick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: m.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, size: 20, color: m.mutedForeground),
            const SizedBox(width: 10),
            Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
            Text(
              time != null ? time!.format(context) : 'Set',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.labelSmall?.copyWith(
        color: context.mihrab.mutedForeground,
        letterSpacing: 1.4,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
