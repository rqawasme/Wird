import 'package:flutter/material.dart';

import '../../../theme/mihrab_theme_extension.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({required this.onContinue, super.key});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: context.mihrab.streakChipBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              'و',
              style: TextStyle(
                fontSize: 40,
                color: context.mihrab.streakChipForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome to Wird',
            style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            'A focused space for daily remembrance. Choose one or more classical wirds, '
            'add dua collections for moments you want to mark, and Wird will guide you '
            'through them one step at a time. Everything stays on this device — no '
            'accounts, no clutter.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: context.mihrab.mutedForeground,
              height: 1.6,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onContinue,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
