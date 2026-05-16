import 'package:flutter/services.dart';

/// Thin wrapper around [HapticFeedback] so call sites read clearly. Kept
/// stateless and synchronous on purpose.
class HapticsService {
  const HapticsService();

  Future<void> count() => HapticFeedback.lightImpact();

  Future<void> stepComplete() => HapticFeedback.mediumImpact();

  Future<void> wirdComplete() => HapticFeedback.heavyImpact();

  Future<void> selection() => HapticFeedback.selectionClick();
}
