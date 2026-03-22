import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/show_host.dart';

void main() {
  group('ShowHost', () {
    test('fromJson parses name', () {
      final h = ShowHost.fromJson({'name': 'Bolgár György'});
      expect(h.name, 'Bolgár György');
    });

    test('fromJson uses default name when missing', () {
      final h = ShowHost.fromJson({});
      expect(h.name, 'Ismeretlen műsorvezető');
    });

    test('fromJson uses default name when null', () {
      final h = ShowHost.fromJson({'name': null});
      expect(h.name, 'Ismeretlen műsorvezető');
    });

    test('toJson serializes name', () {
      const h = ShowHost(name: 'Test Host');
      expect(h.toJson(), {'name': 'Test Host'});
    });

    test('copyWith overrides name', () {
      const h = ShowHost(name: 'Original');
      final copy = h.copyWith(name: 'Changed');
      expect(copy.name, 'Changed');
    });

    test('copyWith preserves name when not given', () {
      const h = ShowHost(name: 'Keep');
      final copy = h.copyWith();
      expect(copy.name, 'Keep');
    });

    test('toString returns JSON', () {
      const h = ShowHost(name: 'Test');
      expect(h.toString(), contains('"name"'));
      expect(h.toString(), contains('Test'));
    });
  });
}
