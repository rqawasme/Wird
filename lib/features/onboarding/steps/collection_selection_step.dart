import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/collection.dart';
import '../../../data/providers/content_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';
import '../../preview/preview_modal.dart';

class CollectionSelectionStep extends ConsumerWidget {
  const CollectionSelectionStep({
    required this.selected,
    required this.onToggle,
    required this.onContinue,
    required this.onSkip,
    super.key,
  });

  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final collectionsAsync = ref.watch(collectionsRepositoryProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add dua collections',
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Optional. Collections are short routines you can recite alongside '
            'your Wird — for moments like anxiety, travel, or before sleep.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.mihrab.mutedForeground,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: collectionsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Could not load: $e')),
              data: (collections) => ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: collections.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final c = collections[i];
                  return _CollectionTile(
                    collection: c,
                    isSelected: selected.contains(c.id),
                    onTap: () => onToggle(c.id),
                    onPreview: () =>
                        PreviewModal.show(context, wird: null, collection: c),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onSkip,
                  child: const Text('Skip'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: onContinue,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({
    required this.collection,
    required this.isSelected,
    required this.onTap,
    required this.onPreview,
  });

  final Collection collection;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor =
        isSelected ? theme.colorScheme.primary : context.mihrab.borderSubtle;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.bookmark_outline,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      collection.name,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Preview',
                    onPressed: onPreview,
                    icon: const Icon(Icons.visibility_outlined),
                    color: context.mihrab.mutedForeground,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                collection.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.mihrab.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  if (collection.period != null)
                    _miniChip(context, _formatPeriod(collection.period!),
                        emphasized: true,),
                  for (final tag in collection.tags)
                    _miniChip(context, '#$tag'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatPeriod(CollectionPeriod p) {
    switch (p) {
      case CollectionPeriod.morning:
        return 'morning';
      case CollectionPeriod.evening:
        return 'evening';
      case CollectionPeriod.beforeSleep:
        return 'before sleep';
      case CollectionPeriod.afterSalah:
        return 'after salah';
      case CollectionPeriod.anytime:
        return 'anytime';
    }
  }

  Widget _miniChip(BuildContext context, String label,
      {bool emphasized = false,}) {
    final m = context.mihrab;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: emphasized ? m.todoBadgeBackground : m.doneBadgeBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: emphasized ? m.todoBadgeForeground : m.doneBadgeForeground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
