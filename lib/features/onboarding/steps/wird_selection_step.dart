import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/wird.dart';
import '../../../data/providers/content_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';
import '../../preview/preview_modal.dart';

class WirdSelectionStep extends ConsumerWidget {
  const WirdSelectionStep({
    required this.selected,
    required this.onToggle,
    required this.onContinue,
    super.key,
  });

  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final wirdsAsync = ref.watch(wirdsRepositoryProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your wird sources',
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Pick one or more. They\'ll be merged into a single daily Wird, '
            'deduplicated and ordered for you.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.mihrab.mutedForeground,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: wirdsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Could not load: $e')),
              data: (wirds) => ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: wirds.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final wird = wirds[i];
                  return _WirdTile(
                    wird: wird,
                    isSelected: selected.contains(wird.id),
                    onTap: () => onToggle(wird.id),
                    onPreview: () =>
                        PreviewModal.show(context, wird: wird),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: selected.isEmpty ? null : onContinue,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

class _WirdTile extends StatelessWidget {
  const _WirdTile({
    required this.wird,
    required this.isSelected,
    required this.onTap,
    required this.onPreview,
  });

  final Wird wird;
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
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: context.mihrab.doneBadgeBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.menu_book_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wird.title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      wird.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.mihrab.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      wird.author,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: context.mihrab.mutedForeground,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
