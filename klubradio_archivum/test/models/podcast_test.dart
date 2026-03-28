import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_host.dart';

void main() {
  group('Podcast.fromJson', () {
    test('parses minimal fields with defaults', () {
      final p = Podcast.fromJson({'id': '1', 'title': 'Test'});

      expect(p.id, '1');
      expect(p.title, 'Test');
      expect(p.description, '');
      expect(p.coverImageUrl, 'assets/app_icon/app_icon.png');
      expect(p.episodeCount, 0);
      expect(p.hosts, isEmpty);
      expect(p.latestEpisode, isNull);
      expect(p.lastUpdated, isNull);
      expect(p.isSubscribed, isFalse);
      expect(p.isTrending, isFalse);
      expect(p.isRecommended, isFalse);
    });

    test('uses default title when missing', () {
      final p = Podcast.fromJson({'id': '1'});
      expect(p.title, 'Ismeretlen műsor');
    });

    test('parses snake_case fields from Supabase', () {
      final p = Podcast.fromJson({
        'id': '3',
        'title': 'A lényeg',
        'description': 'Napi összefoglaló',
        'cover_image_url': 'https://img.jpg',
        'episode_count': 100,
        'hosts': [{'name': 'Bolgár György'}],
        'last_updated': '2024-01-15T10:00:00Z',
      });

      expect(p.id, '3');
      expect(p.title, 'A lényeg');
      expect(p.description, 'Napi összefoglaló');
      expect(p.coverImageUrl, 'https://img.jpg');
      expect(p.episodeCount, 100);
      expect(p.hosts.length, 1);
      expect(p.hosts.first.name, 'Bolgár György');
      expect(p.lastUpdated, isNotNull);
    });

    test('handles episode_count as string', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T', 'episode_count': '42',
      });
      expect(p.episodeCount, 42);
    });

    test('handles numeric id', () {
      final p = Podcast.fromJson({'id': 7, 'title': 'T'});
      expect(p.id, '7');
    });

    test('handles null id', () {
      final p = Podcast.fromJson({'title': 'T'});
      expect(p.id, '');
    });

    test('parses boolean flags', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T',
        'is_subscribed': true,
        'is_trending': true,
        'is_recommended': true,
      });
      expect(p.isSubscribed, isTrue);
      expect(p.isTrending, isTrue);
      expect(p.isRecommended, isTrue);
    });

    test('parses latest_episode when present', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T',
        'latest_episode': {
          'id': 'ep1', 'podcastId': '1', 'title': 'Latest', 'audioUrl': 'u',
        },
      });
      expect(p.latestEpisode, isNotNull);
      expect(p.latestEpisode!.title, 'Latest');
    });

    test('skips invalid hosts gracefully', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T',
        'hosts': ['not a map', 42, {'name': 'Valid'}],
      });
      expect(p.hosts.length, 1);
      expect(p.hosts.first.name, 'Valid');
    });
  });

  group('Podcast.toJson', () {
    test('serializes all fields', () {
      final p = Podcast(
        id: '5',
        title: 'Podcast Title',
        description: 'Desc',
        coverImageUrl: 'https://cover.jpg',
        episodeCount: 50,
        hosts: [const ShowHost(name: 'Host')],
        lastUpdated: DateTime.utc(2024, 6, 15),
        isSubscribed: true,
        isTrending: false,
        isRecommended: true,
      );
      final json = p.toJson();

      expect(json['id'], '5');
      expect(json['title'], 'Podcast Title');
      expect(json['description'], 'Desc');
      expect(json['coverImageUrl'], 'https://cover.jpg');
      expect(json['episodeCount'], 50);
      expect(json['hosts'], isA<List>());
      expect((json['hosts'] as List).first, {'name': 'Host'});
      expect(json['lastUpdated'], '2024-06-15T00:00:00.000Z');
      expect(json['isSubscribed'], isTrue);
      expect(json['isTrending'], isFalse);
      expect(json['isRecommended'], isTrue);
    });

    test('handles null optional fields', () {
      final p = Podcast(
        id: '1', title: 'T', description: '', coverImageUrl: '',
        episodeCount: 0, hosts: [],
      );
      final json = p.toJson();
      expect(json['latestEpisode'], isNull);
      expect(json['lastUpdated'], isNull);
    });
  });

  group('Podcast.copyWith', () {
    test('overrides specified fields only', () {
      final original = Podcast(
        id: '1', title: 'Original', description: 'D',
        coverImageUrl: '', episodeCount: 10, hosts: [],
      );
      final copy = original.copyWith(title: 'Changed', episodeCount: 20);

      expect(copy.title, 'Changed');
      expect(copy.episodeCount, 20);
      expect(copy.id, '1');
      expect(copy.description, 'D');
    });

    test('preserves all fields when no overrides given', () {
      final original = Podcast(
        id: '1', title: 'T', description: 'D', coverImageUrl: 'c',
        episodeCount: 5, hosts: [const ShowHost(name: 'H')],
        isSubscribed: true,
      );
      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.title, original.title);
      expect(copy.hosts.length, original.hosts.length);
      expect(copy.isSubscribed, original.isSubscribed);
    });
  });

  group('Podcast.toString', () {
    test('returns valid JSON', () {
      final p = Podcast(
        id: '1', title: 'T', description: '', coverImageUrl: '',
        episodeCount: 0, hosts: [],
      );
      expect(p.toString(), contains('"id"'));
    });
  });
}
