import 'package:flutter/material.dart';

import '../../../theme/mihrab_theme_extension.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  // TODO(wird): wire to package_info_plus when added.
  static const String _version = '0.1.0';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT',
          style: theme.textTheme.labelSmall?.copyWith(
            color: m.mutedForeground,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: m.borderSubtle),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Version',
                        style: theme.textTheme.bodyLarge,),
                  ),
                  Text(_version,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: m.mutedForeground,
                      ),),
                ],
              ),
              const SizedBox(height: 10),
              Divider(color: m.borderSubtle, height: 1),
              const SizedBox(height: 10),
              Text(
                'Wird is a Safi Solutions product.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: m.mutedForeground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'safisolutions.com',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: m.mutedForeground,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ComingSoonTile extends StatelessWidget {
  const ComingSoonTile({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: m.borderSubtle),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.lock_clock, color: m.mutedForeground),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyLarge),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: m.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: m.doneBadgeBackground,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Soon',
              style: theme.textTheme.labelSmall?.copyWith(
                color: m.doneBadgeForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
