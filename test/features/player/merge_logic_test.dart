import 'package:flutter_test/flutter_test.dart';
import 'package:wird/data/models/dhikr.dart';
import 'package:wird/data/models/wird.dart';
import 'package:wird/data/providers/merged_wird_provider.dart';

Dhikr _d(String id, {int count = 1, String? group}) => Dhikr(
      id: id,
      title: id,
      arabic: id,
      translation: id,
      transliteration: id,
      virtues: '',
      count: count,
      source: '',
      repeatGroup: group,
    );

Wird _w(String id, List<WirdStep> steps) => Wird(
      id: id,
      title: id,
      subtitle: '',
      cover: '',
      author: '',
      createdAt: '',
      durationMinutes: 1,
      steps: steps,
    );

void main() {
  group('mergeWirds', () {
    test('empty input returns empty merged wird', () {
      final merged =
          mergeWirds(wirds: const <Wird>[], adhkar: const <String, Dhikr>{});
      expect(merged.isEmpty, isTrue);
      expect(merged.steps, isEmpty);
    });

    test('single source: steps preserved in order', () {
      final adhkar = {
        'a': _d('a'),
        'b': _d('b'),
      };
      final wird = _w('w1', const [WirdStep(dhikrId: 'a'), WirdStep(dhikrId: 'b')]);
      final merged = mergeWirds(wirds: [wird], adhkar: adhkar);
      expect(merged.steps.map((s) => s.primary.id).toList(), ['a', 'b']);
    });

    test('multi-source: duplicates are deduped, both sources noted', () {
      final adhkar = {'a': _d('a'), 'b': _d('b'), 'c': _d('c')};
      final w1 = _w('w1',
          const [WirdStep(dhikrId: 'a'), WirdStep(dhikrId: 'b')],);
      final w2 = _w('w2',
          const [WirdStep(dhikrId: 'b'), WirdStep(dhikrId: 'c')],);
      final merged = mergeWirds(wirds: [w2, w1], adhkar: adhkar);
      // sorted by id: w1 then w2
      expect(merged.sourceWirds.map((w) => w.id).toList(), ['w1', 'w2']);
      expect(merged.steps.map((s) => s.primary.id).toList(), ['a', 'b', 'c']);
    });

    test('higher count override later in walk wins', () {
      final adhkar = {'a': _d('a', count: 10)};
      final w1 =
          _w('w1', const [WirdStep(dhikrId: 'a', countOverride: 33)]);
      final w2 =
          _w('w2', const [WirdStep(dhikrId: 'a', countOverride: 100)]);
      final merged = mergeWirds(wirds: [w1, w2], adhkar: adhkar);
      expect(merged.steps, hasLength(1));
      expect(merged.steps.first.effectiveCount, 100);
    });

    test('lower override after higher does not downgrade', () {
      final adhkar = {'a': _d('a', count: 10)};
      final w1 =
          _w('w1', const [WirdStep(dhikrId: 'a', countOverride: 100)]);
      final w2 =
          _w('w2', const [WirdStep(dhikrId: 'a', countOverride: 33)]);
      final merged = mergeWirds(wirds: [w1, w2], adhkar: adhkar);
      expect(merged.steps.first.effectiveCount, 100);
    });

    test('repeat group: presented once with all members', () {
      final adhkar = {
        'q1': _d('q1', count: 3, group: 'quls'),
        'q2': _d('q2', count: 3, group: 'quls'),
        'q3': _d('q3', count: 3, group: 'quls'),
      };
      final w1 = _w('w1',
          const [WirdStep(dhikrId: 'q1'), WirdStep(dhikrId: 'q2'), WirdStep(dhikrId: 'q3')],);
      final merged = mergeWirds(wirds: [w1], adhkar: adhkar);
      expect(merged.steps, hasLength(1));
      expect(merged.steps.first.groupMembers.length, 3);
      expect(merged.steps.first.hasRepeatGroup, isTrue);
      expect(merged.steps.first.effectiveCount, 3);
    });

    test('repeat group across two sources is not duplicated', () {
      final adhkar = {
        'q1': _d('q1', count: 3, group: 'quls'),
        'q2': _d('q2', count: 3, group: 'quls'),
      };
      final w1 = _w('w1', const [WirdStep(dhikrId: 'q1')]);
      final w2 = _w('w2', const [WirdStep(dhikrId: 'q2')]);
      final merged = mergeWirds(wirds: [w1, w2], adhkar: adhkar);
      expect(merged.steps, hasLength(1));
      expect(merged.steps.first.hasRepeatGroup, isTrue);
    });

    test('unknown dhikrId is skipped without throwing', () {
      final adhkar = {'a': _d('a')};
      final w = _w('w', const [
        WirdStep(dhikrId: 'a'),
        WirdStep(dhikrId: 'missing'),
      ]);
      final merged = mergeWirds(wirds: [w], adhkar: adhkar);
      expect(merged.steps, hasLength(1));
      expect(merged.steps.first.primary.id, 'a');
    });
  });

  group('resolveSteps', () {
    test('a collection with non-grouped adhkar resolves in order', () {
      final adhkar = {'a': _d('a'), 'b': _d('b')};
      final resolved = resolveSteps(
        steps: const [WirdStep(dhikrId: 'a'), WirdStep(dhikrId: 'b')],
        adhkar: adhkar,
      );
      expect(resolved.map((r) => r.primary.id).toList(), ['a', 'b']);
    });

    test('a collection with members of one group renders one step', () {
      final adhkar = {
        'q1': _d('q1', group: 'quls'),
        'q2': _d('q2', group: 'quls'),
      };
      final resolved = resolveSteps(
        steps: const [WirdStep(dhikrId: 'q1'), WirdStep(dhikrId: 'q2')],
        adhkar: adhkar,
      );
      expect(resolved, hasLength(1));
      expect(resolved.first.groupMembers, hasLength(2));
    });
  });
}
