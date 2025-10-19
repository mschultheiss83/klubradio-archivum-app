import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpRequester {
  HttpRequester({
    http.Client? client,
    required this.defaultHeaders,
    this.connectTimeout = const Duration(seconds: 5),
    this.requestTimeout = const Duration(seconds: 12),
    this.maxRetries = 2,
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final Map<String, String> defaultHeaders;
  final Duration connectTimeout;
  final Duration requestTimeout;
  final int maxRetries;

  Future<dynamic> getJson(String url, {Map<String, String>? headers}) async {
    int attempt = 0;
    while (true) {
      attempt++;
      try {
        final fut = _client.get(
          Uri.parse(url),
          headers: {...defaultHeaders, ...?headers},
        );
        final resp = await fut.timeout(requestTimeout);

        if (resp.statusCode >= 200 && resp.statusCode < 300) {
          return jsonDecode(utf8.decode(resp.bodyBytes));
        }
        throw HttpException('HTTP ${resp.statusCode} for $url');
      } on TimeoutException catch (e) {
        if (attempt > maxRetries) rethrow;
        await _backoff(attempt);
        _log('Timeout for \'$url\' attempt $attempt: $e');
      } on SocketException catch (e) {
        if (attempt > maxRetries) rethrow;
        await _backoff(attempt);
        _log('Socket for \'$url\' attempt $attempt: $e');
      } on HttpException catch (e) {
        // retry nur bei 5xx
        if (attempt > maxRetries || !e.message.contains('HTTP 5')) rethrow;
        await _backoff(attempt);
        _log('HTTP for \'$url\' attempt $attempt: ${e.message}');
      }
    }
  }

  Future<void> dispose() async => _client.close();

  Future<void> _backoff(int attempt) =>
      Future.delayed(Duration(milliseconds: 300 * (1 << (attempt - 1))));

  void _log(Object o) {
    // ignore: avoid_print
    print('[HttpRequester] $o');
  }
}
