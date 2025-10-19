import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/repositories/podcast_repository.dart';

class RecommendedProvider extends ChangeNotifier {
  RecommendedProvider(this.repo);
  final PodcastRepository repo;

  List<Podcast> items = const [];
  String? error;
  bool loading = false;

  Future<void> load({bool useCacheFirst = true}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      items = await repo.recommended(useCacheFirst: useCacheFirst);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
