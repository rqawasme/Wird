import 'dart:async';

import 'package:flutter/material.dart';

import '../../../services/haptics_service.dart';
import '../../../theme/mihrab_text_styles.dart';
import '../../../theme/mihrab_theme_extension.dart';

class CompletionView extends StatefulWidget {
  const CompletionView({
    required this.streakDays,
    required this.elapsed,
    required this.onDone,
    super.key,
  });

  final int streakDays;
  final Duration elapsed;
  final VoidCallback onDone;

  @override
  State<CompletionView> createState() => _CompletionViewState();
}

class _CompletionViewState extends State<CompletionView> {
  @override
  void initState() {
    super.initState();
    unawaited(const HapticsService().wirdComplete());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    final mt = context.mihrabText;
    final minutes = widget.elapsed.inMinutes;
    final seconds = widget.elapsed.inSeconds - minutes * 60;
    final dayWord = widget.streakDays == 1 ? 'day' : 'days';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          children: [
            const Spacer(),
            Icon(Icons.check_circle_outline,
                size: 56, color: m.playerAccent),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَقَبَّلَ اللَّهُ مِنَّا وَمِنْكُمْ',
                textAlign: TextAlign.center,
                style: mt.arabicLarge.copyWith(color: m.playerOnBackground),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'May Allah accept it from you',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: m.playerOnBackground.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 28),
            _Stat(
              label: 'TIME',
              value:
                  '$minutes:${seconds.toString().padLeft(2, '0')}',
            ),
            const SizedBox(height: 12),
            _Stat(
              label: 'STREAK',
              value: '${widget.streakDays} $dayWord',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: widget.onDone,
                style: FilledButton.styleFrom(
                  backgroundColor: m.playerAccent,
                  foregroundColor: m.playerBackground,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: m.playerOnBackground.withValues(alpha: 0.6),
            letterSpacing: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: m.playerOnBackground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
