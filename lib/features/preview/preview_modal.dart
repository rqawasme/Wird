import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/collection.dart';
import '../../data/models/dhikr.dart';
import '../../data/models/wird.dart';
import '../../data/providers/content_providers.dart';
import '../../theme/mihrab_text_styles.dart';
import '../../theme/mihrab_theme_extension.dart';

class PreviewModal extends ConsumerWidget {
  const PreviewModal._({
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.estimatedMinutes,
  });

  factory PreviewModal.forWird(Wird w) => PreviewModal._(
        title: w.title,
        subtitle: '${w.author} • ${w.subtitle}',
        steps: w.steps,
        estimatedMinutes: w.durationMinutes,
      );

  factory PreviewModal.forCollection(Collection c) => PreviewModal._(
        title: c.name,
        subtitle: c.description,
        steps: c.steps,
        estimatedMinutes: c.durationMinutes,
      );

  final String title;
  final String subtitle;
  final List<WirdStep> steps;
  final int estimatedMinutes;

  static Future<void> show(
    BuildContext context, {
    required Wird? wird,
    Collection? collection,
  }) {
    assert((wird == null) != (collection == null),
        'Provide either a wird or a collection');
    final modal = wird != null
        ? PreviewModal.forWird(wird)
        : PreviewModal.forCollection(collection!);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => modal,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adhkarAsync = ref.watch(adhkarRepositoryProvider);
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scroll) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: context.mihrab.borderSubtle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: context.mihrab.mutedForeground),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _statChip(context, '${steps.length} steps'),
                        const SizedBox(width: 8),
                        _statChip(context, '~$estimatedMinutes min'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: adhkarAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Could not load: $e')),
                  data: (adhkar) => ListView.separated(
                    controller: scroll,
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    itemCount: steps.length,
                    separatorBuilder: (_, __) => Divider(
                      color: context.mihrab.borderSubtle,
                      height: 24,
                    ),
                    itemBuilder: (context, i) {
                      final step = steps[i];
                      final dhikr = adhkar[step.dhikrId];
                      if (dhikr == null) return const SizedBox.shrink();
                      final count = step.countOverride ?? dhikr.count;
                      return _PreviewRow(dhikr: dhikr, count: count);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.mihrab.doneBadgeBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: context.mihrab.doneBadgeForeground,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({required this.dhikr, required this.count});

  final Dhikr dhikr;
  final int count;

  @override
  Widget build(BuildContext context) {
    final mihrabText = context.mihrabText;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dhikr.title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: context.mihrab.mutedForeground,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  dhikr.arabic,
                  style: mihrabText.arabic,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: context.mihrab.todoBadgeBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '× $count',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: context.mihrab.todoBadgeForeground,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
