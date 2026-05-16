import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/providers/home_screen_provider.dart';
import '../../router.dart';
import '../../theme/mihrab_theme_extension.dart';
import 'widgets/collection_card.dart';
import 'widgets/streak_strip.dart';
import 'widgets/wird_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dataAsync = ref.watch(homeScreenDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wird',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: dataAsync.when(
          loading: () => const _LoadingSkeleton(),
          error: (e, _) => _ErrorState(
            onRetry: () => ref.invalidate(homeScreenDataProvider),
            message: e.toString(),
          ),
          data: (data) => RefreshIndicator(
            onRefresh: () async => ref.invalidate(homeScreenDataProvider),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                _Greeting(),
                const SizedBox(height: 16),
                StreakStrip(streakDays: data.wirdStreak),
                const SizedBox(height: 20),
                if (!data.hasSelectedWird)
                  _EmptyWirdState(
                    onChoose: () => context.push(AppRoutes.settings),
                  )
                else
                  WirdCard(
                    title: 'Your Wird',
                    subtitle: _subtitleForMergedWird(data),
                    doneToday: data.wirdDoneToday,
                    streak: data.wirdStreak,
                    monthCompleted: data.wirdMonthCompleted,
                    monthTotal: data.wirdMonthTotal,
                    onTap: () => context.push(AppRoutes.wirdPlayer),
                  ),
                if (data.enabledCollections.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  _SectionHeader('Collections'),
                  const SizedBox(height: 12),
                  for (final c in data.enabledCollections) ...[
                    CollectionCard(
                      title: c.collection.name,
                      subtitle: c.collection.description,
                      doneToday: c.doneToday,
                      streak: c.streak,
                      monthCompleted: c.monthCompleted,
                      monthTotal: c.monthTotal,
                      onTap: () => context
                          .push(AppRoutes.collectionPlayerFor(c.collection.id)),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _subtitleForMergedWird(HomeScreenData data) {
    final sources = data.mergedWird.sourceWirds;
    final count = data.mergedWird.totalSteps;
    final titles = sources.map((w) => w.title).join(', ');
    final src = sources.length == 1 ? 'source' : 'sources';
    return '$count adhkar from ${sources.length} $src: $titles';
  }
}

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final weekday = DateFormat('EEEE').format(now).toUpperCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weekday,
          style: theme.textTheme.labelSmall?.copyWith(
            color: context.mihrab.mutedForeground,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Assalāmu ʿalaykum',
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _EmptyWirdState extends StatelessWidget {
  const _EmptyWirdState({required this.onChoose});

  final VoidCallback onChoose;

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
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(Icons.menu_book_outlined,
              size: 32, color: m.mutedForeground),
          const SizedBox(height: 12),
          Text(
            'No wird selected',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            'Choose a classical wird source to begin.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: m.mutedForeground),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onChoose,
            child: const Text('Open settings'),
          ),
        ],
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    final theme = Theme.of(context);
    Widget block({double height = 80}) => Container(
          height: height,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: m.borderSubtle),
          ),
        );
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        block(height: 36),
        const SizedBox(height: 16),
        block(),
        const SizedBox(height: 20),
        block(height: 140),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry, required this.message});

  final VoidCallback onRetry;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 32, color: context.mihrab.mutedForeground),
            const SizedBox(height: 12),
            Text(
              'Something went wrong',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: context.mihrab.mutedForeground),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
