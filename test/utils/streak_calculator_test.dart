import 'package:flutter_test/flutter_test.dart';
import 'package:wird/utils/date_keys.dart';
import 'package:wird/utils/streak_calculator.dart';

void main() {
  group('calculateStreak', () {
    final fixedNow = DateTime(2025, 6, 15, 14, 0);

    test('empty log returns 0', () {
      expect(
        calculateStreak(dateKeys: const <String>{}, now: fixedNow),
        0,
      );
    });

    test('only today returns 1', () {
      expect(
        calculateStreak(
          dateKeys: <String>{dateKeyFor(fixedNow)},
          now: fixedNow,
        ),
        1,
      );
    });

    test('today + previous 4 consecutive days returns 5', () {
      final keys = <String>{
        for (var i = 0; i < 5; i++) dateKeyOffset(fixedNow, i),
      };
      expect(calculateStreak(dateKeys: keys, now: fixedNow), 5);
    });

    test('gap of one day breaks the streak', () {
      final keys = <String>{
        dateKeyFor(fixedNow),
        dateKeyOffset(fixedNow, 1),
        // missing day 2
        dateKeyOffset(fixedNow, 3),
        dateKeyOffset(fixedNow, 4),
      };
      expect(calculateStreak(dateKeys: keys, now: fixedNow), 2);
    });

    test('today missing but yesterday present: streak counts from yesterday',
        () {
      final keys = <String>{
        dateKeyOffset(fixedNow, 1),
        dateKeyOffset(fixedNow, 2),
        dateKeyOffset(fixedNow, 3),
      };
      expect(calculateStreak(dateKeys: keys, now: fixedNow), 3);
    });

    test('today and yesterday both missing: streak is 0', () {
      final keys = <String>{
        dateKeyOffset(fixedNow, 2),
        dateKeyOffset(fixedNow, 3),
        dateKeyOffset(fixedNow, 4),
      };
      expect(calculateStreak(dateKeys: keys, now: fixedNow), 0);
    });

    test('duplicates are counted once', () {
      final keys = <String>[
        dateKeyFor(fixedNow),
        dateKeyFor(fixedNow),
        dateKeyOffset(fixedNow, 1),
      ];
      expect(calculateStreak(dateKeys: keys, now: fixedNow), 2);
    });
  });

  group('thisMonthProgress', () {
    test('counts only entries in the current month', () {
      final ref = DateTime(2025, 6, 10);
      final keys = <String>{
        '2025-06-01',
        '2025-06-05',
        '2025-06-10',
        '2025-05-31',
      };
      final r = thisMonthProgress(dateKeys: keys, now: ref);
      expect(r.completed, 3);
      expect(r.total, 10);
    });
  });
}
