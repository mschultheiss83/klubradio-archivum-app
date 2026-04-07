import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:klubradio_archivum/services/http_requester.dart';

void main() {
  const testUrl = 'https://example.com/api/data';
  const defaultHeaders = {'Authorization': 'Bearer test-token'};

  // Short durations to keep tests fast.
  const fastTimeout = Duration(milliseconds: 100);

  /// Create an HttpRequester with sensible test defaults.
  HttpRequester makeRequester(
    http.Client client, {
    int maxRetries = 1,
    Duration requestTimeout = fastTimeout,
    Duration connectTimeout = fastTimeout,
    Map<String, String> headers = defaultHeaders,
  }) {
    return HttpRequester(
      client: client,
      defaultHeaders: headers,
      maxRetries: maxRetries,
      requestTimeout: requestTimeout,
      connectTimeout: connectTimeout,
    );
  }

  group('HttpRequester.getJson', () {
    test('returns parsed JSON on 200 response', () async {
      final client = MockClient((request) async {
        return http.Response('{"status": "ok"}', 200);
      });
      final requester = makeRequester(client);

      final result = await requester.getJson(testUrl);

      expect(result, isA<Map>());
      expect(result['status'], 'ok');
      await requester.dispose();
    });

    test('returns parsed JSON on 201 response', () async {
      final client = MockClient((request) async {
        return http.Response('{"created": true}', 201);
      });
      final requester = makeRequester(client);

      final result = await requester.getJson(testUrl);

      expect(result['created'], true);
      await requester.dispose();
    });

    test('sends defaultHeaders', () async {
      Map<String, String>? capturedHeaders;
      final client = MockClient((request) async {
        capturedHeaders = request.headers;
        return http.Response('{}', 200);
      });
      final requester = makeRequester(client);

      await requester.getJson(testUrl);

      expect(capturedHeaders, isNotNull);
      expect(capturedHeaders!['Authorization'], 'Bearer test-token');
      await requester.dispose();
    });

    test('merges extra headers', () async {
      Map<String, String>? capturedHeaders;
      final client = MockClient((request) async {
        capturedHeaders = request.headers;
        return http.Response('{}', 200);
      });
      final requester = makeRequester(client);

      await requester.getJson(testUrl, headers: {'X-Custom': 'value'});

      expect(capturedHeaders!['Authorization'], 'Bearer test-token');
      expect(capturedHeaders!['X-Custom'], 'value');
      await requester.dispose();
    });

    test('throws HttpException on 400 response (no retry for 4xx)', () async {
      int callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        return http.Response('Bad Request', 400);
      });
      final requester = makeRequester(client);

      expect(() => requester.getJson(testUrl), throwsA(isA<HttpException>()));

      // Allow the future to complete before checking call count.
      try {
        await requester.getJson(testUrl);
      } catch (_) {}

      // 4xx errors should NOT be retried, so only 1 call per invocation.
      // We called getJson twice above; the first is expected via the expect().
      // Reset and test cleanly:
      callCount = 0;
      final client2 = MockClient((request) async {
        callCount++;
        return http.Response('Not Found', 404);
      });
      final requester2 = makeRequester(client2);

      try {
        await requester2.getJson(testUrl);
      } on HttpException {
        // expected
      }
      expect(callCount, 1); // no retries for 4xx
      await requester.dispose();
      await requester2.dispose();
    });

    test('retries on 500 response then throws after maxRetries', () async {
      int callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        return http.Response('Internal Server Error', 500);
      });
      // maxRetries=1 means: attempt 1 fails, attempt 2 (retry) fails, then throw.
      final requester = makeRequester(client, maxRetries: 1);

      expect(() => requester.getJson(testUrl), throwsA(isA<HttpException>()));
      await expectLater(
        requester.getJson(testUrl),
        throwsA(isA<HttpException>()),
      );
      // 1 initial + 1 retry = 2 calls per invocation.
      // We invoked getJson twice in the expect calls above.
      // Test a clean invocation:
      callCount = 0;
      final client2 = MockClient((request) async {
        callCount++;
        return http.Response('Server Error', 500);
      });
      final requester2 = makeRequester(client2, maxRetries: 1);
      try {
        await requester2.getJson(testUrl);
      } on HttpException {
        // expected
      }
      expect(callCount, 2); // initial attempt + 1 retry
      await requester.dispose();
      await requester2.dispose();
    });

    test('retries on TimeoutException then throws after maxRetries', () async {
      int callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        // Return a future that never completes within the timeout.
        await Future.delayed(const Duration(seconds: 10));
        return http.Response('{}', 200);
      });
      final requester = makeRequester(
        client,
        maxRetries: 1,
        requestTimeout: const Duration(milliseconds: 50),
      );

      try {
        await requester.getJson(testUrl);
      } on TimeoutException {
        // expected
      }
      expect(callCount, 2); // initial + 1 retry
      await requester.dispose();
    });

    test('retries on SocketException then throws after maxRetries', () async {
      int callCount = 0;
      final client = MockClient((request) {
        callCount++;
        throw const SocketException('Connection refused');
      });
      final requester = makeRequester(client, maxRetries: 1);

      try {
        await requester.getJson(testUrl);
      } on SocketException {
        // expected
      }
      expect(callCount, 2); // initial + 1 retry
      await requester.dispose();
    });

    test('succeeds on retry (first call fails, second succeeds)', () async {
      int callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        if (callCount == 1) {
          return http.Response('Server Error', 500);
        }
        return http.Response('{"recovered": true}', 200);
      });
      final requester = makeRequester(client, maxRetries: 2);

      final result = await requester.getJson(testUrl);

      expect(result['recovered'], true);
      expect(callCount, 2);
      await requester.dispose();
    });
  });

  group('HttpRequester.dispose', () {
    test('closes the client', () async {
      bool closed = false;
      // Use a real Client wrapper to detect close.
      final client = _CloseTrackingClient(onClose: () => closed = true);
      final requester = makeRequester(client);

      await requester.dispose();

      expect(closed, true);
    });
  });
}

/// A simple Client wrapper that tracks whether close() was called.
class _CloseTrackingClient extends http.BaseClient {
  _CloseTrackingClient({required this.onClose});

  final void Function() onClose;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return http.StreamedResponse(Stream.value([]), 200);
  }

  @override
  void close() {
    onClose();
    super.close();
  }
}
