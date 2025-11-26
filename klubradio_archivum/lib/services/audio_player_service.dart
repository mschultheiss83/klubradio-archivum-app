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
        // Potentially add an error message to a stream/notifier for UI to display
        debugPrint('Failed to load audio for episode: ${episode.id}');
      }
    } on PlayerException catch (error) {
      debugPrint('PlayerException in loadEpisode: $error');
      _bufferingController.addError(error);
      _currentEpisode = null; // Clear on player-specific errors too
      await _player.stop();
    } on PlayerInterruptedException catch (error) {
      debugPrint('PlayerInterruptedException in loadEpisode: $error');
      _bufferingController.addError(error);
      _currentEpisode = null; // Clear on player-specific errors too
      await _player.stop();
    } catch (e, st) { // Catch any other unexpected exceptions
      debugPrint('Unexpected error in loadEpisode: $e\n$st');
      _bufferingController.addError(e);
      _currentEpisode = null; // Clear on any unexpected errors
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
  }
}
