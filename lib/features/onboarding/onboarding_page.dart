import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/providers/notification_provider.dart';
import '../../data/providers/user_state_providers.dart';
import '../../router.dart';
import '../../theme/mihrab_theme_extension.dart';
import 'steps/collection_selection_step.dart';
import 'steps/notification_setup_step.dart';
import 'steps/welcome_step.dart';
import 'steps/wird_selection_step.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _pageController = PageController();
  int _index = 0;

  final Set<String> _selectedWirds = <String>{};
  final Set<String> _selectedCollections = <String>{};
  bool _notificationsEnabled = false;
  TimeOfDay? _wirdTime = const TimeOfDay(hour: 6, minute: 30);
  final Map<String, TimeOfDay?> _collectionTimes = {};

  static const int _stepCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _go(int next) async {
    setState(() => _index = next);
    await _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    final settings = ref.read(settingsControllerProvider.notifier);
    await settings.setSelectedWirdIds(_selectedWirds.toList());

    final selectionsCtl =
        ref.read(collectionSelectionsControllerProvider.notifier);
    for (final id in _selectedCollections) {
      await selectionsCtl.setEnabled(id, enabled: true);
      final t = _collectionTimes[id];
      if (_notificationsEnabled && t != null) {
        await selectionsCtl.setNotificationTime(id, _hhmm(t));
      }
    }
    // Persist order matching selection order for now; the user can reorder later.
    await selectionsCtl
        .reorder(_selectedCollections.toList(growable: false));

    await settings.setNotificationsEnabled(_notificationsEnabled);
    await settings.setWirdNotificationTime(
      _notificationsEnabled && _wirdTime != null ? _hhmm(_wirdTime!) : null,
    );

    if (_notificationsEnabled) {
      final notifier = ref.read(notificationServiceProvider);
      await notifier.requestPermission();
      await notifier.cancelAll();
      if (_wirdTime != null) {
        await notifier.scheduleDailyWird(hhmm: _hhmm(_wirdTime!));
      }
      for (final id in _selectedCollections) {
        final t = _collectionTimes[id];
        if (t != null) {
          await notifier.scheduleCollection(
            collectionId: id,
            collectionName: id,
            hhmm: _hhmm(t),
          );
        }
      }
    }

    await settings.markOnboardingComplete();
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  String _hhmm(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _ProgressHeader(index: _index, total: _stepCount),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _index = i),
                children: [
                  WelcomeStep(onContinue: () => _go(1)),
                  WirdSelectionStep(
                    selected: _selectedWirds,
                    onToggle: (id) => setState(() {
                      if (!_selectedWirds.add(id)) _selectedWirds.remove(id);
                    }),
                    onContinue: () => _go(2),
                  ),
                  CollectionSelectionStep(
                    selected: _selectedCollections,
                    onToggle: (id) => setState(() {
                      if (!_selectedCollections.add(id)) {
                        _selectedCollections.remove(id);
                      }
                    }),
                    onContinue: () => _go(3),
                    onSkip: () => _go(3),
                  ),
                  NotificationSetupStep(
                    notificationsEnabled: _notificationsEnabled,
                    onToggle: (v) => setState(() => _notificationsEnabled = v),
                    wirdTime: _wirdTime,
                    onWirdTimeChange: (t) =>
                        setState(() => _wirdTime = t ?? _wirdTime),
                    collectionIds: _selectedCollections.toList(),
                    collectionTimes: _collectionTimes,
                    onCollectionTimeChange: (id, t) =>
                        setState(() => _collectionTimes[id] = t),
                    onFinish: _finish,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.index, required this.total});

  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fraction = (index + 1) / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STEP ${index + 1} OF $total',
            style: theme.textTheme.labelSmall?.copyWith(
              color: context.mihrab.mutedForeground,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 3,
              backgroundColor: context.mihrab.borderSubtle,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
