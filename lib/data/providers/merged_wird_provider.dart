import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/dhikr.dart';
import '../models/wird.dart';
import 'content_providers.dart';
import 'user_state_providers.dart';

part 'merged_wird_provider.g.dart';

/// A single resolved step in the user's daily Wird: the [Dhikr] plus the
/// effective count, plus its sibling adhkar if it belongs to a repeat group.
class ResolvedStep {
  ResolvedStep({
    required this.primary,
    required this.effectiveCount,
    required this.groupMembers,
  });

  final Dhikr primary;
  final int effectiveCount;

  /// All adhkar that should be rendered together for this step, including
  /// [primary]. Length is 1 when there is no [Dhikr.repeatGroup].
  final List<Dhikr> groupMembers;

  bool get hasRepeatGroup => groupMembers.length > 1;
}

class MergedWird {
  MergedWird({required this.steps, required this.sourceWirds});

  final List<ResolvedStep> steps;
  final List<Wird> sourceWirds;

  bool get isEmpty => steps.isEmpty;
  int get totalSteps => steps.length;
}

/// Compose a list of wirds into a single deduplicated sequence. Pure function
/// — extracted from the provider so the algorithm can be unit-tested.
///
/// Algorithm:
///   1. Sort wirds by id for stability.
///   2. Walk each wird's steps in order.
///   3. For a dhikr that has no repeat group: add it on first sight; if it
///      reappears with a higher effective count, bump the existing step.
///   4. For a dhikr that has a repeat group: add the *group* on first sight,
///      gathering all members from [adhkar] and using the maximum of their
///      counts as the group's count. Subsequent members of the same group
///      are skipped; if a later occurrence has a higher count, the group's
///      count is bumped.
MergedWird mergeWirds({
  required List<Wird> wirds,
  required Map<String, Dhikr> adhkar,
}) {
  final sorted = List<Wird>.of(wirds)
    ..sort((a, b) => a.id.compareTo(b.id));

  if (sorted.isEmpty) {
    return MergedWird(steps: const [], sourceWirds: const []);
  }

  final byRepeatGroup = <String, List<Dhikr>>{};
  for (final dhikr in adhkar.values) {
    final group = dhikr.repeatGroup;
    if (group != null) {
      byRepeatGroup.putIfAbsent(group, () => <Dhikr>[]).add(dhikr);
    }
  }

  final seenDhikrIds = <String>{};
  final seenGroups = <String>{};
  final resolved = <ResolvedStep>[];
  final indexByDhikrId = <String, int>{};
  final indexByGroup = <String, int>{};

  for (final wird in sorted) {
    for (final step in wird.steps) {
      final dhikr = adhkar[step.dhikrId];
      if (dhikr == null) continue;
      final effective = step.countOverride ?? dhikr.count;

      final group = dhikr.repeatGroup;
      if (group != null) {
        if (seenGroups.contains(group)) {
          final existingIdx = indexByGroup[group]!;
          final existing = resolved[existingIdx];
          if (effective > existing.effectiveCount) {
            resolved[existingIdx] = ResolvedStep(
              primary: existing.primary,
              effectiveCount: effective,
              groupMembers: existing.groupMembers,
            );
          }
          continue;
        }
        final members = (byRepeatGroup[group] ?? <Dhikr>[dhikr])
          ..sort((a, b) => a.id.compareTo(b.id));
        final groupCount = members
            .map((m) => m.count)
            .fold<int>(effective, (acc, c) => c > acc ? c : acc);
        resolved.add(
          ResolvedStep(
            primary: members.first,
            effectiveCount: groupCount,
            groupMembers: members,
          ),
        );
        indexByGroup[group] = resolved.length - 1;
        seenGroups.add(group);
        for (final m in members) {
          seenDhikrIds.add(m.id);
        }
        continue;
      }

      if (seenDhikrIds.contains(dhikr.id)) {
        final existingIdx = indexByDhikrId[dhikr.id]!;
        final existing = resolved[existingIdx];
        if (effective > existing.effectiveCount) {
          resolved[existingIdx] = ResolvedStep(
            primary: existing.primary,
            effectiveCount: effective,
            groupMembers: existing.groupMembers,
          );
        }
        continue;
      }

      resolved.add(
        ResolvedStep(
          primary: dhikr,
          effectiveCount: effective,
          groupMembers: <Dhikr>[dhikr],
        ),
      );
      indexByDhikrId[dhikr.id] = resolved.length - 1;
      seenDhikrIds.add(dhikr.id);
    }
  }

  return MergedWird(steps: resolved, sourceWirds: sorted);
}

/// Resolve a single wird or collection's steps into [ResolvedStep]s using the
/// adhkar pool. Used by the player for non-merged content (collections).
List<ResolvedStep> resolveSteps({
  required List<WirdStep> steps,
  required Map<String, Dhikr> adhkar,
}) {
  final byRepeatGroup = <String, List<Dhikr>>{};
  for (final dhikr in adhkar.values) {
    final group = dhikr.repeatGroup;
    if (group != null) {
      byRepeatGroup.putIfAbsent(group, () => <Dhikr>[]).add(dhikr);
    }
  }

  final resolved = <ResolvedStep>[];
  final seenGroups = <String>{};
  for (final step in steps) {
    final dhikr = adhkar[step.dhikrId];
    if (dhikr == null) continue;
    final effective = step.countOverride ?? dhikr.count;

    final group = dhikr.repeatGroup;
    if (group != null) {
      if (seenGroups.contains(group)) continue;
      final members = (byRepeatGroup[group] ?? <Dhikr>[dhikr])
        ..sort((a, b) => a.id.compareTo(b.id));
      final groupCount = members
          .map((m) => m.count)
          .fold<int>(effective, (acc, c) => c > acc ? c : acc);
      resolved.add(
        ResolvedStep(
          primary: members.first,
          effectiveCount: groupCount,
          groupMembers: members,
        ),
      );
      seenGroups.add(group);
      continue;
    }

    resolved.add(
      ResolvedStep(
        primary: dhikr,
        effectiveCount: effective,
        groupMembers: <Dhikr>[dhikr],
      ),
    );
  }
  return resolved;
}

@Riverpod(keepAlive: true)
Future<MergedWird> mergedDailyWird(Ref ref) async {
  final selectedIds = ref.watch(
    settingsControllerProvider.select((s) => s.selectedWirdIds),
  );
  final wirdsByIdFuture = ref.watch(wirdsByIdProvider.future);
  final adhkarFuture = ref.watch(adhkarRepositoryProvider.future);
  final wirdsById = await wirdsByIdFuture;
  final adhkar = await adhkarFuture;
  final selected =
      selectedIds.map((id) => wirdsById[id]).whereType<Wird>().toList();
  return mergeWirds(wirds: selected, adhkar: adhkar);
}
