import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/retention_mode.dart';

void main() {
  group('RetentionMode', () {
    test('has 3 values', () {
      expect(RetentionMode.values.length, 3);
    });

    test('values are in expected order', () {
      expect(RetentionMode.values[0], RetentionMode.keepAll);
      expect(RetentionMode.values[1], RetentionMode.keepLatestN);
      expect(RetentionMode.values[2], RetentionMode.deleteAfterHeard);
    });

    test('name returns expected strings', () {
      expect(RetentionMode.keepAll.name, 'keepAll');
      expect(RetentionMode.keepLatestN.name, 'keepLatestN');
      expect(RetentionMode.deleteAfterHeard.name, 'deleteAfterHeard');
    });
  });
}
