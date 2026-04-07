import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart';

void main() {
  late ApiCacheService cacheService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    cacheService = ApiCacheService();
  });

  group('save and get', () {
    test('save() stores data retrievable by get()', () async {
      await cacheService.save('key1', {'name': 'test'});
      final result = await cacheService.get('key1');
      expect(result, {'name': 'test'});
    });

    test('save() with expiry stores data with expiry timestamp', () async {
      await cacheService.save(
        'exp_key',
        'value',
        expiry: const Duration(hours: 1),
      );

      // Verify the raw stored entry contains a positive expiry
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('api_cache_exp_key');
      expect(raw, isNotNull);
      final entry = jsonDecode(raw!) as Map<String, dynamic>;
      final expiry = entry['expiry'] as int;
      expect(expiry, greaterThan(0));
    });

    test('save() without expiry stores data with -1 expiry (never expires)',
        () async {
      await cacheService.save('no_exp', 42);

      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('api_cache_no_exp');
      expect(raw, isNotNull);
      final entry = jsonDecode(raw!) as Map<String, dynamic>;
      expect(entry['expiry'], -1);
    });
  });

  group('get', () {
    test('returns null for non-existent key', () async {
      final result = await cacheService.get('nonexistent');
      expect(result, isNull);
    });

    test('returns cached data for valid key', () async {
      await cacheService.save('valid', [1, 2, 3]);
      final result = await cacheService.get('valid');
      expect(result, [1, 2, 3]);
    });

    test('returns null and removes entry when expired', () async {
      // Manually write an already-expired entry
      final prefs = await SharedPreferences.getInstance();
      final expiredEntry = jsonEncode({
        'data': jsonEncode('old_data'),
        'expiry': DateTime.now()
            .subtract(const Duration(hours: 1))
            .millisecondsSinceEpoch,
        'timestamp': DateTime.now()
            .subtract(const Duration(hours: 2))
            .millisecondsSinceEpoch,
      });
      await prefs.setString('api_cache_expired_key', expiredEntry);

      final result = await cacheService.get('expired_key');
      expect(result, isNull);

      // Verify the entry was removed
      expect(prefs.containsKey('api_cache_expired_key'), isFalse);
    });

    test('returns data when no expiry set (-1)', () async {
      await cacheService.save('forever', 'persistent');
      final result = await cacheService.get('forever');
      expect(result, 'persistent');
    });
  });

  group('remove', () {
    test('removes cached entry', () async {
      await cacheService.save('to_remove', 'data');
      expect(await cacheService.get('to_remove'), 'data');

      await cacheService.remove('to_remove');
      expect(await cacheService.get('to_remove'), isNull);
    });
  });

  group('isCached', () {
    test('returns true for existing key', () async {
      await cacheService.save('exists', true);
      expect(await cacheService.isCached('exists'), isTrue);
    });

    test('returns false for non-existent key', () async {
      expect(await cacheService.isCached('nope'), isFalse);
    });
  });

  group('isExpired', () {
    test('returns true for non-existent key', () async {
      expect(await cacheService.isExpired('missing'), isTrue);
    });

    test('returns false for non-expired entry', () async {
      await cacheService.save(
        'fresh',
        'value',
        expiry: const Duration(hours: 24),
      );
      expect(await cacheService.isExpired('fresh'), isFalse);
    });

    test('returns true for expired entry', () async {
      // Manually write an already-expired entry
      final prefs = await SharedPreferences.getInstance();
      final expiredEntry = jsonEncode({
        'data': jsonEncode('stale'),
        'expiry': DateTime.now()
            .subtract(const Duration(seconds: 10))
            .millisecondsSinceEpoch,
        'timestamp': DateTime.now()
            .subtract(const Duration(minutes: 5))
            .millisecondsSinceEpoch,
      });
      await prefs.setString('api_cache_stale', expiredEntry);

      expect(await cacheService.isExpired('stale'), isTrue);
    });

    test('returns false for entry with no expiry (-1)', () async {
      await cacheService.save('no_ttl', 'value');
      expect(await cacheService.isExpired('no_ttl'), isFalse);
    });
  });

  group('round-trip', () {
    test('save complex nested JSON and get returns same structure', () async {
      final complexData = {
        'podcasts': [
          {
            'id': 'pod-1',
            'title': 'Podcast One',
            'episodes': [
              {'id': 'ep-1', 'duration': 3600},
              {'id': 'ep-2', 'duration': 1800},
            ],
          },
          {
            'id': 'pod-2',
            'title': 'Podcast Two',
            'episodes': <Map<String, dynamic>>[],
          },
        ],
        'meta': {
          'total': 2,
          'page': 1,
          'hasMore': false,
          'tags': ['news', 'politics', 'interview'],
        },
      };

      await cacheService.save('complex', complexData);
      final result = await cacheService.get('complex');

      expect(result, isA<Map<String, dynamic>>());
      final resultMap = result as Map<String, dynamic>;
      expect(resultMap['podcasts'], isList);
      expect((resultMap['podcasts'] as List).length, 2);
      expect(resultMap['meta']['total'], 2);
      expect(resultMap['meta']['hasMore'], false);
      expect(resultMap['meta']['tags'], ['news', 'politics', 'interview']);
    });

    test('save and get primitive types', () async {
      await cacheService.save('str', 'hello');
      expect(await cacheService.get('str'), 'hello');

      await cacheService.save('num', 42);
      expect(await cacheService.get('num'), 42);

      await cacheService.save('bool', true);
      expect(await cacheService.get('bool'), true);

      await cacheService.save('null_val', null);
      expect(await cacheService.get('null_val'), isNull);

      await cacheService.save('list', [1, 'two', 3.0]);
      expect(await cacheService.get('list'), [1, 'two', 3.0]);
    });
  });
}
