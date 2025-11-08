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
  UserProfile get profile => _profile!;
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
    _profile = profile.copyWith(languageCode: code);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> setPlaybackSpeed(double v) async {
    _profile = profile.copyWith(playbackSpeed: v);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> setMaxAutoDownload(int n) async {
    _profile = profile.copyWith(maxAutoDownload: n);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> toggleFavouriteEpisode(String episodeId) async {
    final fav = Set<String>.from(profile.favouriteEpisodeIds);
    if (fav.contains(episodeId)) {
      fav.remove(episodeId);
    } else {
      fav.add(episodeId);
    }
    _profile = profile.copyWith(favouriteEpisodeIds: fav);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> setSubscriptions(Set<String> ids) async {
    _profile = profile.copyWith(subscribedPodcastIds: ids);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> addRecentlyPlayed(Episode episode) async {
    final updated = List<Episode>.from(profile.recentlyPlayed);
    updated.removeWhere((e) => e.id == episode.id);
    updated.insert(0, episode);
    if (updated.length > 10) { // Assuming a max of 10 recently played episodes
      updated.removeLast();
    }
    _profile = profile.copyWith(recentlyPlayed: updated);
    await _repo.save(profile);
    notifyListeners();
  }
}
