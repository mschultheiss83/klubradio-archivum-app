import 'package:flutter/foundation.dart';

import '../models/episode.dart';

class AudioPlayerService extends ChangeNotifier {
  AudioPlayerService();

  // TODO: Replace this in-memory implementation with just_audio integration
  // to provide real playback, background controls, and buffering updates.

  Episode? _currentEpisode;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  Episode? get currentEpisode => _currentEpisode;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration =>
      _duration == Duration.zero && _currentEpisode != null
          ? _currentEpisode!.duration
          : _duration;

  void play(Episode episode) {
    _currentEpisode = episode;
    _duration = episode.duration;
    _position = Duration.zero;
    _isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_currentEpisode == null) {
      return;
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void pause() {
    if (!_isPlaying) {
      return;
    }
    _isPlaying = false;
    notifyListeners();
  }

  void resume() {
    if (_currentEpisode == null) {
      return;
    }
    _isPlaying = true;
    notifyListeners();
  }

  void seek(Duration newPosition) {
    if (_currentEpisode == null) {
      return;
    }
    _position = newPosition;
    if (_position.isNegative) {
      _position = Duration.zero;
    }
    if (_position > duration) {
      _position = duration;
    }
    notifyListeners();
  }

  void updateDuration(Duration newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  void stop() {
    _isPlaying = false;
    _position = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    _currentEpisode = null;
    super.dispose();
  }
}
