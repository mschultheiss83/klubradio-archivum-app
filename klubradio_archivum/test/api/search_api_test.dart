import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:klubradio_archivum/api/search_api.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

import 'episode_api_test.mocks.dart'; // Reuse existing MockHttpRequester

void main() {
  group('SearchApi', () {
    late SearchApi searchApi;
    late MockHttpRequester mockRequester;
    const String baseUrl = 'http://localhost:8000';
    const String apiKey = 'test_api_key';

    setUp(() {
      mockRequester = MockHttpRequester();
      searchApi = SearchApi(
        baseUrl: baseUrl,
        apiKey: apiKey,
        requester: mockRequester,
      );
    });

    // ---- podcasts() ----

    group('podcasts()', () {
      test('returns empty list for blank query', () async {
        final result = await searchApi.podcasts('');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns empty list for whitespace-only query', () async {
        final result = await searchApi.podcasts('   ');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns parsed podcast list on valid query', () async {
        final mockResponse = <Map<String, dynamic>>[
          {'id': '3', 'title': 'A lényeg', 'description': 'Hírműsor'},
          {'id': '14', 'title': 'Esti gyors', 'description': 'Napzáró'},
        ];
        when(mockRequester.getJson(any)).thenAnswer((_) async => mockResponse);

        final result = await searchApi.podcasts('lényeg');

        expect(result, hasLength(2));
        expect(result.first['title'], 'A lényeg');
        verify(mockRequester.getJson(
          '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25lényeg%25',
        )).called(1);
      });

      test('escapes single quotes in query (SQL injection prevention)', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        await searchApi.podcasts("O'Connor");

        verify(mockRequester.getJson(
          "$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25O''Connor%25",
        )).called(1);
      });

      test('escapes multiple single quotes', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        await searchApi.podcasts("it's a 'test'");

        verify(mockRequester.getJson(
          "$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25it''s a ''test''%25",
        )).called(1);
      });

      test('handles single-character query', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        final result = await searchApi.podcasts('a');

        expect(result, isEmpty);
        verify(mockRequester.getJson(any)).called(1);
      });

      test('propagates HTTP errors from requester', () async {
        when(mockRequester.getJson(any)).thenThrow(Exception('Network error'));

        expect(
          () => searchApi.podcasts('test'),
          throwsA(isA<Exception>()),
        );
      });
    });

    // ---- episodes() ----

    group('episodes()', () {
      test('returns empty list for blank query', () async {
        final result = await searchApi.episodes('');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns empty list for whitespace-only query', () async {
        final result = await searchApi.episodes('  \t  ');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns parsed episode list on valid query', () async {
        final mockResponse = <Map<String, dynamic>>[
          {'id': '100', 'title': 'A lényeg 2026-03-22', 'podcastId': '3'},
        ];
        when(mockRequester.getJson(any)).thenAnswer((_) async => mockResponse);

        final result = await searchApi.episodes('lényeg');

        expect(result, hasLength(1));
        expect(result.first['id'], '100');
        verify(mockRequester.getJson(
          '$baseUrl/rest/v1/${constants.episodesTable}?select=*&title=ilike.%25lényeg%25',
        )).called(1);
      });

      test('escapes single quotes in episode search', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        await searchApi.episodes("host's show");

        verify(mockRequester.getJson(
          "$baseUrl/rest/v1/${constants.episodesTable}?select=*&title=ilike.%25host''s show%25",
        )).called(1);
      });

      test('propagates HTTP errors from requester', () async {
        when(mockRequester.getJson(any)).thenThrow(Exception('Timeout'));

        expect(
          () => searchApi.episodes('test'),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
