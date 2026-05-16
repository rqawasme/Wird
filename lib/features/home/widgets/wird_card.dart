import 'package:flutter/material.dart';

import '../../../theme/mihrab_theme_extension.dart';

class WirdCard extends StatelessWidget {
  const WirdCard({
    required this.title,
    required this.subtitle,
    required this.doneToday,
    required this.streak,
    required this.monthCompleted,
    required this.monthTotal,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool doneToday;
  final int streak;
  final int monthCompleted;
  final int monthTotal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: m.borderSubtle),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: m.mutedForeground,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _StatusBadge(done: doneToday),
                ],
              ),
              const SizedBox(height: 14),
              Divider(color: m.borderSubtle, height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatColumn(label: 'STREAK', value: '$streak'),
                  const SizedBox(width: 24),
                  _StatColumn(
                    label: 'THIS MONTH',
                    value: '$monthCompleted/$monthTotal',
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: m.mutedForeground,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    final theme = Theme.of(context);
    final bg = done ? m.doneBadgeBackground : m.todoBadgeBackground;
    final fg = done ? m.doneBadgeForeground : m.todoBadgeForeground;
    final label = done ? 'Done' : 'To do';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (done)
            Icon(Icons.check_circle, size: 14, color: fg)
          else
            Icon(Icons.circle_outlined, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium
                ?.copyWith(color: fg, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: m.mutedForeground,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
