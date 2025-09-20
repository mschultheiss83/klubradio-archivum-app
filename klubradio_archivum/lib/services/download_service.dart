import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/episode.dart';

class DownloadTask {
  DownloadTask({
    required this.episode,
    this.progress = 0,
    this.status = DownloadStatus.notDownloaded,
    this.filePath,
    this.error,
  });

  final Episode episode;
  double progress;
  DownloadStatus status;
  String? filePath;
  Object? error;

  DownloadTask copyWith({
    double? progress,
    DownloadStatus? status,
    String? filePath,
    Object? error,
  }) {
    return DownloadTask(
      episode: episode,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      error: error ?? this.error,
    );
  }
}

class DownloadService {
  DownloadService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final Map<String, DownloadTask> _tasks = <String, DownloadTask>{};
  final StreamController<DownloadTask> _downloadController =
      StreamController<DownloadTask>.broadcast();

  Stream<DownloadTask> get downloadStream => _downloadController.stream;
  List<DownloadTask> get activeDownloads => _tasks.values.toList();

  Future<DownloadTask> downloadEpisode(Episode episode) async {
    final DownloadTask existing = _tasks[episode.id] ??
        DownloadTask(episode: episode, status: DownloadStatus.queued);
    _tasks[episode.id] = existing;
    _downloadController.add(existing.copyWith());

    final Directory directory = await _ensureDownloadDirectory();
    final File file = File('${directory.path}/${episode.id}.mp3');
    existing
      ..filePath = file.path
      ..status = DownloadStatus.downloading
      ..progress = 0;
    _downloadController.add(existing.copyWith());

    try {
      final http.Request request =
          http.Request('GET', Uri.parse(episode.audioUrl));
      final http.StreamedResponse response = await _httpClient.send(request);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException('Unexpected status ${response.statusCode}');
      }

      final IOSink sink = file.openWrite();
      int received = 0;
      final int? total = response.contentLength;

      await for (final List<int> chunk in response.stream) {
        received += chunk.length;
        sink.add(chunk);
        if (total != null && total > 0) {
          existing.progress = received / total;
          _downloadController.add(existing.copyWith());
        }
      }

      await sink.close();
      existing
        ..status = DownloadStatus.downloaded
        ..progress = 1;
      _downloadController.add(existing.copyWith());
    } catch (error) {
      existing
        ..status = DownloadStatus.failed
        ..progress = 0
        ..error = error;
      _downloadController.add(existing.copyWith(error: error));
      rethrow;
    }

    return existing;
  }

  Future<void> removeDownload(String episodeId) async {
    final DownloadTask? task = _tasks.remove(episodeId);
    if (task?.filePath != null) {
      final File file = File(task!.filePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    if (task != null) {
      _downloadController.add(task.copyWith(status: DownloadStatus.notDownloaded));
    }
  }

  Future<Directory> _ensureDownloadDirectory() async {
    final Directory baseDirectory = await getApplicationDocumentsDirectory();
    final Directory downloadDirectory =
        Directory('${baseDirectory.path}/downloads');
    if (!await downloadDirectory.exists()) {
      await downloadDirectory.create(recursive: true);
    }
    return downloadDirectory;
  }

  Future<void> dispose() async {
    await _downloadController.close();
    _httpClient.close();
  }
}
