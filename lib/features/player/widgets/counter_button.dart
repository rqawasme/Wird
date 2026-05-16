import 'dart:async';

import 'package:flutter/material.dart';

import '../../../services/haptics_service.dart';
import '../../../theme/mihrab_theme_extension.dart';

/// Large tap-to-count button used in the player. Pulses on tap.
class CounterButton extends StatefulWidget {
  const CounterButton({
    required this.label,
    required this.onTap,
    required this.isFinal,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool isFinal;

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  final _haptics = const HapticsService();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.98,
      upperBound: 1.0,
      value: 1.0,
    );
    _scale = _ctrl.drive(
      Tween<double>(begin: 0.98, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTap() {
    _ctrl.value = 0.96;
    _ctrl.forward(from: 0.96);
    if (widget.isFinal) {
      unawaited(_haptics.stepComplete());
    } else {
      unawaited(_haptics.count());
    }
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final m = context.mihrab;
    final theme = Theme.of(context);
    return ScaleTransition(
      scale: _scale,
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: FilledButton(
          onPressed: _onTap,
          style: FilledButton.styleFrom(
            backgroundColor: m.playerAccent,
            foregroundColor: m.playerBackground,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

