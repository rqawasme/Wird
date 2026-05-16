import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/app_settings.dart';
import '../../../data/providers/user_state_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';

class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    final settings = ref.watch(settingsControllerProvider);
    final ctl = ref.read(settingsControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'APPEARANCE',
          style: theme.textTheme.labelSmall?.copyWith(
            color: m.mutedForeground,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        SegmentedButton<ThemeModePref>(
          segments: const [
            ButtonSegment(
              value: ThemeModePref.system,
              label: Text('System'),
              icon: Icon(Icons.smartphone_outlined),
            ),
            ButtonSegment(
              value: ThemeModePref.light,
              label: Text('Light'),
              icon: Icon(Icons.light_mode_outlined),
            ),
            ButtonSegment(
              value: ThemeModePref.dark,
              label: Text('Dark'),
              icon: Icon(Icons.dark_mode_outlined),
            ),
          ],
          selected: <ThemeModePref>{settings.themeMode},
          onSelectionChanged: (s) => ctl.setThemeMode(s.first),
          showSelectedIcon: false,
        ),
        const SizedBox(height: 18),
        Text(
          'Arabic font size',
          style: theme.textTheme.bodyLarge,
        ),
        Slider(
          value: settings.arabicFontScale,
          min: 0.85,
          max: 1.25,
          divisions: 4,
          label: settings.arabicFontScale.toStringAsFixed(2),
          onChanged: null,
        ),
        Text(
          'Coming soon',
          style: theme.textTheme.bodySmall?.copyWith(
            color: m.mutedForeground,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
