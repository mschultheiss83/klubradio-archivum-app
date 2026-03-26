import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart'; // Import for kIsWeb and debugPrint
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
  final StreamController<String?> _errorController =
      StreamController<String?>.broadcast();

  Episode? _currentEpisode;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  Episode? get currentEpisode => _currentEpisode;
  Stream<bool> get bufferingStream => _bufferingController.stream;
  Stream<String?> get errorStream => _errorController.stream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  bool get isPlaying => _player.playing;
  Duration? get totalDuration => _player.duration;

  // TODO: Test autoplay functionality across all platforms (web, mobile, desktop)
  // Currently disabled due to issues on web and other platforms
  Future<void> loadEpisode(Episode episode, {bool autoplay = false}) async {
    _currentEpisode = episode;
    try {
      final local = episode.localFilePath;
      bool loadedSuccessfully = false;

      // Try loading local file first, only if not on web
      if (!kIsWeb && local != null && local.isNotEmpty && await File(local).exists()) {
        try {
          await _player.setFilePath(local);
          debugPrint('Successfully loaded local file: $local');
          loadedSuccessfully = true;
        } catch (e, st) {
          debugPrint('Error loading local file $local: $e\n$st');
          // Fallback to remote if local fails
        }
      }

      // If local failed, was not available, or on web, try remote URL
      if (!loadedSuccessfully) {
        try {
          await _player.setUrl(episode.audioUrl);
          debugPrint('Successfully loaded remote URL: ${episode.audioUrl}');
          loadedSuccessfully = true;
        } catch (e, st) {
          debugPrint('Error loading remote URL ${episode.audioUrl}: $e\n$st');
          // All attempts failed
        }
      }

      if (loadedSuccessfully) {
        if (autoplay) {
          await _player.play();
        }
      } else {
        // If neither local nor remote could be loaded, clear current episode and stop
        _currentEpisode = null;
        await _player.stop();
        _errorController.add('Failed to load audio for episode: ${episode.id}');
        debugPrint('Failed to load audio for episode: ${episode.id}');
      }
    } on PlayerException catch (error) {
      debugPrint('PlayerException in loadEpisode: $error');
      _errorController.add(error.message);
      _currentEpisode = null;
      await _player.stop();
    } on PlayerInterruptedException catch (error) {
      debugPrint('PlayerInterruptedException in loadEpisode: $error');
      _errorController.add(error.message);
      _currentEpisode = null;
      await _player.stop();
    } catch (e, st) {
      debugPrint('Unexpected error in loadEpisode: $e\n$st');
      _errorController.add(e.toString());
      _currentEpisode = null;
      await _player.stop();
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
    await _errorController.close();
  }
}
