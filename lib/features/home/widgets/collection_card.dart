import 'package:flutter/material.dart';

import 'wird_card.dart';

/// Collections share the same card layout as the daily Wird. Kept as a
/// separate widget so the home page reads clearly and so we can add
/// collection-specific affordances later (period chip, etc.) without
/// touching wird_card.dart.
class CollectionCard extends StatelessWidget {
  const CollectionCard({
    required this.title,
    required this.subtitle,
    required this.doneToday,
    required this.streak,
    required this.monthCompleted,
    required this.monthTotal,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool doneToday;
  final int streak;
  final int monthCompleted;
  final int monthTotal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WirdCard(
      title: title,
      subtitle: subtitle,
      doneToday: doneToday,
      streak: streak,
      monthCompleted: monthCompleted,
      monthTotal: monthTotal,
      onTap: onTap,
    );
  }
}
