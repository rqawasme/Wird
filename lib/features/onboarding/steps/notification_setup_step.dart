import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/collection.dart';
import '../../../data/providers/content_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';

class NotificationSetupStep extends ConsumerWidget {
  const NotificationSetupStep({
    required this.notificationsEnabled,
    required this.onToggle,
    required this.wirdTime,
    required this.onWirdTimeChange,
    required this.collectionIds,
    required this.collectionTimes,
    required this.onCollectionTimeChange,
    required this.onFinish,
    super.key,
  });

  final bool notificationsEnabled;
  final ValueChanged<bool> onToggle;
  final TimeOfDay? wirdTime;
  final ValueChanged<TimeOfDay?> onWirdTimeChange;
  final List<String> collectionIds;
  final Map<String, TimeOfDay?> collectionTimes;
  final void Function(String collectionId, TimeOfDay? time)
      onCollectionTimeChange;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final collectionsAsync = ref.watch(collectionsByIdProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set up reminders',
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'A gentle nudge at the time you choose. You can change this later in '
            'Settings.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.mihrab.mutedForeground,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.mihrab.borderSubtle),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  value: notificationsEnabled,
                  onChanged: onToggle,
                  title: const Text('Enable notifications'),
                  subtitle: Text(
                    'Allow Wird to send daily reminders',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.mihrab.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (notificationsEnabled) ...[
            _timeRow(
              context,
              label: 'Daily Wird reminder',
              time: wirdTime,
              onPick: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: wirdTime ?? const TimeOfDay(hour: 6, minute: 30),
                );
                onWirdTimeChange(picked);
              },
            ),
            if (collectionIds.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'COLLECTION REMINDERS',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: context.mihrab.mutedForeground,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: collectionsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Could not load: $e')),
                  data: (byId) {
                    final collections = collectionIds
                        .map((id) => byId[id])
                        .whereType<Collection>()
                        .toList();
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: collections.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final c = collections[i];
                        return _timeRow(
                          context,
                          label: c.name,
                          time: collectionTimes[c.id],
                          onPick: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: collectionTimes[c.id] ??
                                  const TimeOfDay(hour: 21, minute: 0),
                            );
                            onCollectionTimeChange(c.id, picked);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ] else
              const Spacer(),
          ] else
            const Spacer(),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onFinish,
              child: const Text('Finish'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeRow(
    BuildContext context, {
    required String label,
    required TimeOfDay? time,
    required Future<void> Function() onPick,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.mihrab.borderSubtle),
          color: theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
            Text(
              time != null ? _format(context, time) : 'Set',
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

  String _format(BuildContext context, TimeOfDay time) =>
      time.format(context);
}
