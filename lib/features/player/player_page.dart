import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../data/providers/content_providers.dart';
import '../../data/providers/merged_wird_provider.dart';
import '../../data/providers/streak_providers.dart';
import '../../data/providers/user_state_providers.dart';
import '../../theme/mihrab_theme_extension.dart';
import 'widgets/completion_view.dart';
import 'widgets/counter_button.dart';
import 'widgets/repeat_group_view.dart';
import 'widgets/step_view.dart';

sealed class PlayerMode {
  const PlayerMode();
  const factory PlayerMode.wird() = _PlayerWird;
  const factory PlayerMode.collection(String id) = _PlayerCollection;
}

class _PlayerWird extends PlayerMode {
  const _PlayerWird();
}

class _PlayerCollection extends PlayerMode {
  const _PlayerCollection(this.id);
  final String id;
}

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({required this.mode, super.key});

  final PlayerMode mode;

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  final PageController _pageController = PageController();

  /// The step the user is actively progressing through. Only advances when
  /// they finish a step via the Continue button.
  int _activeStep = 0;

  /// The page currently visible. May be any value in [0, _activeStep] when
  /// the user is reviewing past steps; equals [_activeStep] otherwise.
  int _viewedStep = 0;

  int _count = 0;
  bool _isComplete = false;
  late final DateTime _startedAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    unawaited(WakelockPlus.enable());
  }

  @override
  void dispose() {
    _pageController.dispose();
    unawaited(WakelockPlus.disable());
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  bool get _isViewingActive => _viewedStep == _activeStep;

  Future<void> _advance(int totalSteps, int currentStepCount) async {
    if (_count + 1 < currentStepCount) {
      setState(() => _count += 1);
      return;
    }
    if (_activeStep + 1 >= totalSteps) {
      await _finish();
      return;
    }
    setState(() {
      _activeStep += 1;
      _viewedStep = _activeStep;
      _count = 0;
    });
    await _pageController.animateToPage(
      _activeStep,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    setState(() => _isComplete = true);
    switch (widget.mode) {
      case _PlayerWird():
        await ref.read(completionLogControllerProvider.notifier).logWird();
      case _PlayerCollection(:final id):
        await ref
            .read(completionLogControllerProvider.notifier)
            .logCollection(id);
    }
  }

  Future<bool> _confirmExit() async {
    final theme = Theme.of(context);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pause your Wird?'),
        content: Text(
          'Your progress will be saved within this session.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'discard'),
            child: const Text('Discard'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, 'pause'),
            child: const Text('Pause'),
          ),
        ],
      ),
    );
    return result != null;
  }

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: m.playerBackground,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: m.playerBackground,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (widget.mode) {
      case _PlayerWird():
        final asyncMerged = ref.watch(mergedDailyWirdProvider);
        return asyncMerged.when(
          loading: () => const _PlayerLoading(),
          error: (e, _) => _PlayerError(error: e.toString()),
          data: (merged) {
            if (merged.isEmpty) {
              return const _PlayerEmpty(
                label: 'No wird selected. Visit settings to pick one.',
              );
            }
            return _buildLoaded(context, steps: merged.steps);
          },
        );
      case _PlayerCollection(:final id):
        final adhkarAsync = ref.watch(adhkarRepositoryProvider);
        final collectionsAsync = ref.watch(collectionsByIdProvider);
        if (!adhkarAsync.hasValue || !collectionsAsync.hasValue) {
          return const _PlayerLoading();
        }
        if (adhkarAsync.hasError) {
          return _PlayerError(error: adhkarAsync.error.toString());
        }
        final collection = collectionsAsync.value![id];
        if (collection == null) {
          return const _PlayerEmpty(label: 'Collection not found.');
        }
        final steps = resolveSteps(
          steps: collection.steps,
          adhkar: adhkarAsync.value!,
        );
        return _buildLoaded(context, steps: steps);
    }
  }

  Widget _buildLoaded(
    BuildContext context, {
    required List<ResolvedStep> steps,
  }) {
    if (_isComplete) {
      final streak = switch (widget.mode) {
        _PlayerWird() => ref.watch(wirdStreakProvider),
        _PlayerCollection(:final id) =>
          ref.watch(collectionStreakProvider(id)),
      };
      return CompletionView(
        streakDays: streak,
        elapsed: DateTime.now().difference(_startedAt),
        onDone: () => context.go('/'),
      );
    }

    final m = context.mihrab;
    final total = steps.length;
    final active = steps[_activeStep];
    final progress = (_activeStep + (_count / active.effectiveCount)) / total;

    return SafeArea(
      child: Column(
        children: [
          _TopBar(
            current: _viewedStep + 1,
            total: total,
            onClose: () async {
              if (await _confirmExit()) {
                if (!context.mounted) return;
                context.go('/');
              }
            },
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 2,
              backgroundColor: m.playerOnBackground.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(m.playerAccent),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (i) {
                if (i > _activeStep) {
                  // Forward beyond the active step is not allowed.
                  _pageController.animateToPage(
                    _activeStep,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                  return;
                }
                setState(() => _viewedStep = i);
              },
              itemCount: total,
              itemBuilder: (context, i) {
                final step = steps[i];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: step.hasRepeatGroup
                      ? RepeatGroupView(members: step.groupMembers)
                      : StepView(dhikr: step.primary),
                );
              },
            ),
          ),
          if (_isViewingActive)
            _CounterZone(
              current: _count,
              total: active.effectiveCount,
              onTap: () => _advance(total, active.effectiveCount),
            )
          else
            _ReviewingZone(
              onResume: () async {
                await _pageController.animateToPage(
                  _activeStep,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                );
                setState(() => _viewedStep = _activeStep);
              },
            ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.current,
    required this.total,
    required this.onClose,
  });

  final int current;
  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Close',
            onPressed: onClose,
            icon: Icon(Icons.close, color: m.playerOnBackground),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Step $current of $total',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: m.playerOnBackground.withValues(alpha: 0.8),
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _CounterZone extends StatelessWidget {
  const _CounterZone({
    required this.current,
    required this.total,
    required this.onTap,
  });

  final int current;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    final isFinalCount = current + 1 >= total;
    final label = total == 1
        ? 'Continue →'
        : (isFinalCount ? 'Continue →' : 'Tap to count');

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Column(
        children: [
          if (total > 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: m.playerOnBackground.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$current',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: m.playerAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' / $total',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: m.playerOnBackground.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          if (total > 1) const SizedBox(height: 16),
          CounterButton(
            label: label,
            isFinal: isFinalCount,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _ReviewingZone extends StatelessWidget {
  const _ReviewingZone({required this.onResume});

  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Column(
        children: [
          Text(
            'Reviewing a completed step',
            style: theme.textTheme.labelLarge?.copyWith(
              color: m.playerOnBackground.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: onResume,
              style: OutlinedButton.styleFrom(
                foregroundColor: m.playerOnBackground,
                side: BorderSide(
                  color: m.playerOnBackground.withValues(alpha: 0.4),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Resume current step →'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerLoading extends StatelessWidget {
  const _PlayerLoading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.mihrab.playerAccent),
    );
  }
}

class _PlayerError extends StatelessWidget {
  const _PlayerError({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          error,
          textAlign: TextAlign.center,
          style: TextStyle(color: m.playerOnBackground),
        ),
      ),
    );
  }
}

class _PlayerEmpty extends StatelessWidget {
  const _PlayerEmpty({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: m.playerOnBackground),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
