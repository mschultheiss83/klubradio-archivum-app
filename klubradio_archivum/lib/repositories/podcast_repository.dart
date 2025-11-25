import 'package:klubradio_archivum/api/podcast_api.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/services/cache_store.dart';

class PodcastRepository {
  PodcastRepository({required this.api, CacheStore? cache})
    : _cache = cache ?? CacheStore();

  final PodcastApi api;
  final CacheStore _cache;

  Future<List<Podcast>> latest({bool useCacheFirst = true}) async {
    return _cachedList(
      cacheName: 'latest_podcasts.json',
      fetch: () async =>
          (await api.latest()).map((e) => Podcast.fromJson(e)).toList(),
      useCacheFirst: useCacheFirst,
    );
  }

  Future<List<Podcast>> recommended({bool useCacheFirst = true}) async {
    return _cachedList(
      cacheName: 'recommended_podcasts.json',
      fetch: () async =>
          (await api.recommended()).map((e) => Podcast.fromJson(e)).toList(),
      useCacheFirst: useCacheFirst,
    );
  }

  Future<List<Podcast>> trending() async =>
      (await api.trending()).map(Podcast.fromJson).toList();

  Future<List<Episode>> recentEpisodes() async {
    final allP = await allPodcasts();
    final podcastCoverImageUrls = {
      for (var p in allP) p.id: p.coverImageUrl
    };

    return (await api.recentEpisodes())
        .map((e) => Episode.fromJson(
              e,
              podcastCoverImageUrl:
                  podcastCoverImageUrls[e['podcastId'].toString()],
            ))
        .toList();
  }

  // ---- helpers ----
  Future<List<Podcast>> allPodcasts() async {
    return _cachedList(
      cacheName: 'all_podcasts.json',
      fetch: () async =>
          (await api.latest(limit: 999999)).map((e) => Podcast.fromJson(e)).toList(),
      useCacheFirst: true,
    );
  }

  Future<List<T>> _cachedList<T>({
    required String cacheName,
    required Future<List<T>> Function() fetch,
    required bool useCacheFirst,
  }) async {
    if (useCacheFirst) {
      final cached = await _cache.read(cacheName);
      final items = cached?['items'];
      if (items is List && items.isNotEmpty) {
        // SWR: sofort liefern und im Hintergrund erneuern
        _refresh(cacheName, fetch);
        return items
            .cast<Map<String, dynamic>>()
            .map<T>((e) => _mapFactory<T>(e))
            .toList();
      }
    }

    final fresh = await fetch();
    // persist
    if (fresh.isNotEmpty) {
      final serializable = fresh.map<Map<String, dynamic>>((e) {
        if (e is Podcast) return e.toJson();
        if (e is Episode) return e.toJson();
        throw StateError('Unknown type $T');
      }).toList();
      await _cache.write(cacheName, serializable);
    }
    return fresh;
  }

  void _refresh<T>(String cacheName, Future<List<T>> Function() fetch) async {
    try {
      final fresh = await fetch();
      if (fresh.isNotEmpty) {
        final serializable = fresh.map<Map<String, dynamic>>((e) {
          if (e is Podcast) return e.toJson();
          if (e is Episode) return e.toJson();
          throw StateError('Unknown type $T');
        }).toList();
        await _cache.write(cacheName, serializable);
      }
    } catch (_) {
      /* silently */
    }
  }

  T _mapFactory<T>(Map<String, dynamic> json) {
    if (T == Podcast) return Podcast.fromJson(json) as T;
    if (T == Episode) return Episode.fromJson(json) as T;
    throw StateError('No mapper for type $T');
  }
}
