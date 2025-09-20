import 'dart:async';
import 'dart:io';

import 'package:just_audio/just_audio.dart';

import '../models/episode.dart';

class AudioPlayerService {
  AudioPlayerService() : _player = AudioPlayer();

  final AudioPlayer _player;
  Episode? _currentEpisode;

  Episode? get currentEpisode => _currentEpisode;

  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Future<void> setEpisode(Episode episode) async {
    if (_currentEpisode?.id == episode.id) {
      return;
    }

    _currentEpisode = episode;

    if (episode.localFilePath != null && episode.localFilePath!.isNotEmpty) {
      final file = File(episode.localFilePath!);
      if (await file.exists()) {
        await _player.setFilePath(episode.localFilePath!);
        return;
      }
    }

    if (episode.audioUrl.isNotEmpty) {
      await _player.setUrl(episode.audioUrl);
    }
  }

  Future<void> play() => _player.play();

  Future<void> pause() => _player.pause();

  Future<void> stop() => _player.stop();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> seekToStart() => _player.seek(Duration.zero);

  Future<void> playEpisode(Episode episode) async {
    await setEpisode(episode);
    await play();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
