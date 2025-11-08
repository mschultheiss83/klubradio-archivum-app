import 'dart:async';
import 'dart:io';

import 'package:just_audio/just_audio.dart';

import '../models/episode.dart';

class AudioPlayerService {
  AudioPlayerService() {
    _playerStateSubscription = _player.playerStateStream.listen(
      _handlePlayerStateChange,
    );
  }

  final AudioPlayer _player = AudioPlayer();
  final StreamController<bool> _bufferingController =
      StreamController<bool>.broadcast();

  Episode? _currentEpisode;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  Episode? get currentEpisode => _currentEpisode;
  Stream<bool> get bufferingStream => _bufferingController.stream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  bool get isPlaying => _player.playing;
  Duration? get totalDuration => _player.duration;

  Future<void> loadEpisode(Episode episode, {bool autoplay = true}) async {
    _currentEpisode = episode;
    try {
      final local = episode.localFilePath;
      if (local != null && local.isNotEmpty && await File(local).exists()) {
        await _player.setFilePath(local);
      } else {
        await _player.setUrl(episode.audioUrl);
      }

      if (autoplay) {
        await _player.play();
      }
    } on PlayerException catch (error) {
      _bufferingController.addError(error);
    } on PlayerInterruptedException catch (error) {
      _bufferingController.addError(error);
    }
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> stop() => _player.stop();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  void _handlePlayerStateChange(PlayerState state) {
    _bufferingController.add(
      state.processingState == ProcessingState.buffering,
    );
  }

  Future<void> dispose() async {
    await _playerStateSubscription?.cancel();
    await _player.dispose();
    await _bufferingController.close();
  }
}
