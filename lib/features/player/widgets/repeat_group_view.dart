import 'package:flutter/material.dart';

import '../../../data/models/dhikr.dart';
import '../../../theme/mihrab_text_styles.dart';
import '../../../theme/mihrab_theme_extension.dart';

class RepeatGroupView extends StatelessWidget {
  const RepeatGroupView({required this.members, super.key});

  final List<Dhikr> members;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    final mt = context.mihrabText;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GROUP',
            style: theme.textTheme.labelSmall?.copyWith(
              color: m.playerOnBackground.withValues(alpha: 0.6),
              letterSpacing: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < members.length; i++) ...[
            if (i != 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Divider(
                  color: m.playerOnBackground.withValues(alpha: 0.12),
                  height: 1,
                ),
              ),
            Text(
              members[i].title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: m.playerOnBackground.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                members[i].arabic,
                textAlign: TextAlign.right,
                style: mt.arabic.copyWith(color: m.playerOnBackground),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              members[i].translation,
              style: mt.translation.copyWith(
                color: m.playerOnBackground.withValues(alpha: 0.85),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
