import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/episode.dart';

enum DownloadStatus {
  pending,
  inProgress,
  completed,
  failed,
}

class DownloadTask {
  const DownloadTask({
    required this.episode,
    required this.status,
    required this.progress,
    this.localPath,
    this.errorMessage,
  });

  final Episode episode;
  final DownloadStatus status;
  final double progress;
  final String? localPath;
  final String? errorMessage;

  DownloadTask copyWith({
    DownloadStatus? status,
    double? progress,
    String? localPath,
    String? errorMessage,
  }) {
    return DownloadTask(
      episode: episode,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      localPath: localPath ?? this.localPath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DownloadService extends ChangeNotifier {
  DownloadService();

  // TODO: Replace with real download logic using http and path_provider to
  // persist files for offline playback.
  final Map<String, DownloadTask> _tasks = <String, DownloadTask>{};

  List<DownloadTask> get tasks => _tasks.values.toList()
    ..sort((a, b) =>
        b.episode.publishedAt.compareTo(a.episode.publishedAt));

  DownloadTask? taskForEpisode(String episodeId) => _tasks[episodeId];

  Future<void> enqueueDownload(Episode episode) async {
    if (_tasks.containsKey(episode.id)) {
      return;
    }

    _tasks[episode.id] = DownloadTask(
      episode: episode,
      status: DownloadStatus.pending,
      progress: 0,
    );
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 250));
    _tasks[episode.id] = _tasks[episode.id]!.copyWith(
      status: DownloadStatus.inProgress,
      progress: 0.25,
    );
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 250));
    _tasks[episode.id] = _tasks[episode.id]!.copyWith(
      status: DownloadStatus.inProgress,
      progress: 0.65,
    );
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 250));
    _tasks[episode.id] = _tasks[episode.id]!.copyWith(
      status: DownloadStatus.completed,
      progress: 1,
      localPath: 'downloads/${episode.id}.mp3',
    );
    notifyListeners();
  }

  void removeDownload(String episodeId) {
    if (_tasks.remove(episodeId) != null) {
      notifyListeners();
    }
  }

  void clear() {
    if (_tasks.isEmpty) {
      return;
    }
    _tasks.clear();
    notifyListeners();
  }
}
