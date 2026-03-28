// lib/providers/profile_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/episode.dart';
import '../repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({ProfileRepository? repo})
    : _repo = repo ?? ProfileRepository();

  final ProfileRepository _repo;

  UserProfile? _profile;
  UserProfile? get profileOrNull => _profile;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _profile = await _repo.load();
    _loading = false;
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    final p = _profile;
    if (p == null) return;
    _profile = p.copyWith(languageCode: code);
    await _repo.save(_profile!);
    notifyListeners();
  }

  Future<void> setPlaybackSpeed(double v) async {
    final p = _profile;
    if (p == null) return;
    _profile = p.copyWith(playbackSpeed: v);
    await _repo.save(_profile!);
    notifyListeners();
  }

  Future<void> setAutoDownloadEpisodeCount(int n) async {
    final p = _profile;
    if (p == null) return;
    _profile = p.copyWith(autoDownloadEpisodeCount: n);
    await _repo.save(_profile!);
    notifyListeners();
  }

  Future<void> toggleFavouriteEpisode(String episodeId) async {
    final p = _profile;
    if (p == null) return;
    final fav = Set<String>.from(p.favouriteEpisodeIds);
    if (fav.contains(episodeId)) {
      fav.remove(episodeId);
    } else {
      fav.add(episodeId);
    }
    _profile = p.copyWith(favouriteEpisodeIds: fav);
    await _repo.save(_profile!);
    notifyListeners();
  }

  Future<void> setSubscriptions(Set<String> ids) async {
    final p = _profile;
    if (p == null) return;
    _profile = p.copyWith(subscribedPodcastIds: ids);
    await _repo.save(_profile!);
    notifyListeners();
  }

  Future<void> addRecentlyPlayed(Episode episode) async {
    final p = _profile;
    if (p == null) return;
    final updated = List<Episode>.from(p.recentlyPlayed);
    updated.removeWhere((e) => e.id == episode.id);
    updated.insert(0, episode);
    if (updated.length > 10) {
      updated.removeLast();
    }
    _profile = p.copyWith(recentlyPlayed: updated);
    await _repo.save(_profile!);
    notifyListeners();
  }
}
