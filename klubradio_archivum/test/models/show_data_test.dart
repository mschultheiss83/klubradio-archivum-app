import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/show_data.dart';

void main() {
  group('ShowData', () {
    test('fromJson parses all fields', () {
      final sd = ShowData.fromJson({
        'id': 42,
        'title': 'Megbeszéljük',
        'count': 1500,
      });

      expect(sd.id, '42');
      expect(sd.title, 'Megbeszéljük');
      expect(sd.count, 1500);
    });

    test('fromJson handles string id', () {
      final sd = ShowData.fromJson({
        'id': 'abc',
        'title': 'Test',
        'count': 0,
      });
      expect(sd.id, 'abc');
    });

    test('toJson round-trip', () {
      final original = ShowData(id: '10', title: 'Show', count: 99);
      final json = original.toJson();
      final restored = ShowData.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.count, original.count);
    });

    test('toJson produces expected map', () {
      final sd = ShowData(id: '1', title: 'T', count: 5);
      expect(sd.toJson(), {'id': '1', 'title': 'T', 'count': 5});
    });
  });
}
