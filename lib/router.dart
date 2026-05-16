import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'data/providers/user_state_providers.dart';
import 'features/home/home_page.dart';
import 'features/onboarding/onboarding_page.dart';
import 'features/player/player_page.dart';
import 'features/settings/settings_page.dart';

class AppRoutes {
  const AppRoutes._();

  static const String onboarding = '/onboarding';
  static const String home = '/';
  static const String settings = '/settings';
  static const String wirdPlayer = '/player/wird';
  static const String collectionPlayer = '/player/collection/:id';

  static String collectionPlayerFor(String id) => '/player/collection/$id';
}

GoRouter buildRouter(WidgetRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final settings = ref.read(settingsControllerProvider);
      final onboarded = settings.onboardingCompleted;
      final goingToOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!onboarded && !goingToOnboarding) return AppRoutes.onboarding;
      if (onboarded && goingToOnboarding) return AppRoutes.home;
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: HomePage()),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: OnboardingPage()),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.wirdPlayer,
        name: 'wirdPlayer',
        builder: (context, state) => const PlayerPage(mode: PlayerMode.wird()),
      ),
      GoRoute(
        path: AppRoutes.collectionPlayer,
        name: 'collectionPlayer',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PlayerPage(mode: PlayerMode.collection(id));
        },
      ),
    ],
  );
}
