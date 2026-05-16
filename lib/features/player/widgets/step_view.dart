import 'package:flutter/material.dart';

import '../../../data/models/dhikr.dart';
import '../../../theme/mihrab_text_styles.dart';
import '../../../theme/mihrab_theme_extension.dart';

class StepView extends StatelessWidget {
  const StepView({required this.dhikr, super.key});

  final Dhikr dhikr;

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
            dhikr.title.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: m.playerOnBackground.withValues(alpha: 0.6),
              letterSpacing: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              dhikr.arabic,
              textAlign: TextAlign.right,
              style: mt.arabicLarge.copyWith(color: m.playerOnBackground),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            dhikr.transliteration,
            style: mt.transliteration.copyWith(
              color: m.playerOnBackground.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            dhikr.translation,
            style: mt.translation.copyWith(color: m.playerOnBackground),
          ),
          const SizedBox(height: 18),
          if (dhikr.virtues.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: m.playerOnBackground.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome_outlined,
                      size: 18,
                      color: m.playerOnBackground.withValues(alpha: 0.7),),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      dhikr.virtues,
                      style: mt.virtues.copyWith(
                        color: m.playerOnBackground.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14),
          Text(
            dhikr.source,
            style: mt.sourceCitation.copyWith(
              color: m.playerOnBackground.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}
