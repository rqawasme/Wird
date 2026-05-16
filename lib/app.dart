import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/models/app_settings.dart';
import 'data/providers/user_state_providers.dart';
import 'router.dart';
import 'theme/mihrab_theme.dart';

class WirdApp extends ConsumerStatefulWidget {
  const WirdApp({super.key});

  @override
  ConsumerState<WirdApp> createState() => _WirdAppState();
}

class _WirdAppState extends ConsumerState<WirdApp> {
  late final _router = buildRouter(ref);

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(
      settingsControllerProvider.select((s) => s.themeMode),
    );
    return MaterialApp.router(
      title: 'Wird',
      debugShowCheckedModeBanner: false,
      theme: MihrabTheme.light(),
      darkTheme: MihrabTheme.dark(),
      themeMode: _toThemeMode(themeMode),
      routerConfig: _router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
    );
  }

  ThemeMode _toThemeMode(ThemeModePref pref) {
    switch (pref) {
      case ThemeModePref.system:
        return ThemeMode.system;
      case ThemeModePref.light:
        return ThemeMode.light;
      case ThemeModePref.dark:
        return ThemeMode.dark;
    }
  }
}
