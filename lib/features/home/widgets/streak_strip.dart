import 'package:flutter/material.dart';

import '../../../theme/mihrab_theme_extension.dart';

class StreakStrip extends StatelessWidget {
  const StreakStrip({required this.streakDays, super.key});

  final int streakDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    final label = streakDays == 1 ? 'day' : 'days';
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: m.streakChipBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            Icons.local_fire_department,
            color: m.streakChipForeground,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  streakDays == 0 ? 'Begin a new streak' : 'Current streak',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: m.streakChipForeground.withValues(alpha: 0.85),
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  streakDays == 0
                      ? 'Complete your Wird to start'
                      : '$streakDays $label',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: m.streakChipForeground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
