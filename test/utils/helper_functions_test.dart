import 'package:flutter_test/flutter_test.dart';
import 'package:zitlac/utils/helper_functions.dart';

void main() {
  final helper = HelperFunctions();

  group('formatDuration', () {
    test('Returns formatted string for duration with all units', () {
      final duration = Duration(
        hours: 1,
        minutes: 2,
        seconds: 3,
        milliseconds: 4,
        microseconds: 5,
      );
      final result = helper.formatDuration(duration);
      expect(result, contains('1 h'));
      expect(result, contains('2 m'));
      expect(result, contains('3 s'));
      expect(result, contains('4 ms'));
      expect(result, contains('5 µs'));
    });

    test('Returns "0 µs" for zero duration', () {
      final result = helper.formatDuration(Duration.zero);
      expect(result, '0 µs');
    });

    test('Omits zero values', () {
      final result = helper.formatDuration(Duration(seconds: 10));
      expect(result, '10 s');
    });
  });
}
