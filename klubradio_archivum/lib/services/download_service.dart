import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/episode.dart';

typedef DownloadProgressCallback = void Function(
    int receivedBytes, int totalBytes);

class DownloadException implements Exception {
  DownloadException(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  String toString() => 'DownloadException($message, statusCode: $statusCode)';
}

class DownloadService {
  DownloadService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  Future<String> downloadEpisode(
    Episode episode, {
    DownloadProgressCallback? onProgress,
  }) async {
    if (episode.audioUrl.isEmpty) {
      throw DownloadException('Missing audio URL for ${episode.title}');
    }

    final uri = Uri.parse(episode.audioUrl);
    final request = http.Request('GET', uri);
    final response = await _client.send(request);

    if (response.statusCode != 200) {
      throw DownloadException(
        'Failed to download episode ${episode.id}',
        response.statusCode,
      );
    }

    final directory = await getApplicationDocumentsDirectory();
    final downloadDirectory = Directory('${directory.path}/downloads');
    if (!await downloadDirectory.exists()) {
      await downloadDirectory.create(recursive: true);
    }

    final sanitizedId = episode.id.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
    final filePath = '${downloadDirectory.path}/$sanitizedId.mp3';
    final file = File(filePath);
    final sink = file.openWrite();

    int receivedBytes = 0;
    final totalBytes = response.contentLength ?? 0;

    await for (final chunk in response.stream) {
      receivedBytes += chunk.length;
      sink.add(chunk);
      onProgress?.call(receivedBytes, totalBytes);
    }

    await sink.flush();
    await sink.close();

    return filePath;
  }

  Future<void> deleteDownloadedFile(String filePath) async {
    if (filePath.isEmpty) {
      return;
    }

    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> dispose() async {
    _client.close();
  }
}
