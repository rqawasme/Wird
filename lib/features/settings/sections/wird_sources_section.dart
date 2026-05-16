import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/wird.dart';
import '../../../data/providers/content_providers.dart';
import '../../../data/providers/user_state_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';
import '../../preview/preview_modal.dart';

class WirdSourcesSection extends ConsumerWidget {
  const WirdSourcesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final wirdsAsync = ref.watch(wirdsRepositoryProvider);
    final settings = ref.watch(settingsControllerProvider);
    final selected = settings.selectedWirdIds.toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(label: 'WIRD SOURCES'),
        const SizedBox(height: 10),
        wirdsAsync.when(
          loading: () => const _Skeleton(),
          error: (e, _) => Text('Could not load: $e',
              style: theme.textTheme.bodySmall),
          data: (wirds) => Column(
            children: [
              for (final w in wirds) ...[
                _Tile(
                  wird: w,
                  isSelected: selected.contains(w.id),
                  onToggle: () async {
                    final next = selected.toSet();
                    if (!next.add(w.id)) next.remove(w.id);
                    await ref
                        .read(settingsControllerProvider.notifier)
                        .setSelectedWirdIds(next.toList());
                  },
                  onPreview: () => PreviewModal.show(context, wird: w),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.wird,
    required this.isSelected,
    required this.onToggle,
    required this.onPreview,
  });

  final Wird wird;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : m.borderSubtle,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color:
                    isSelected ? theme.colorScheme.primary : m.mutedForeground,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wird.title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      wird.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: m.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Preview',
                onPressed: onPreview,
                icon: const Icon(Icons.visibility_outlined),
                color: m.mutedForeground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.label});

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

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mihrab.borderSubtle),
      ),
    );
  }
}
