// test/screens/widgets/queue_sheet_test.dart
//
// Critical widget tests for the QueueSheet delete feature.
//
// TDD flow:
//   1. Run these tests → they FAIL (QueueSheet doesn't exist yet)
//   2. Extract _QueueSheet → public QueueSheet with a delete button
//   3. Run again → all green
//
// These tests CAN run under `flutter test` because:
//   - AudioPlayerService is fully mocked (no native just_audio.AudioPlayer created)
//   - QueueSheet has no background_downloader dependency
//   - Localization is configured via AppLocalizations.delegate

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/queue_sheet.dart';

import '../../providers/episode_provider_queue_test.mocks.dart';

void main() {
  Episode ep(String id) => Episode(
        id: id,
        podcastId: 'pod-1',
        title: 'Episode $id',
        description: 'Desc',
        audioUrl: 'https://example.com/$id.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '2024-01-01',
        duration: const Duration(minutes: 30),
      );

  late MockAudioPlayerService mockAudio;
  late MockApiService mockApi;
  late MockAppDatabase mockDb;
  late StreamController<Duration> positionCtrl;
  late StreamController<PlayerState> playerStateCtrl;
  late StreamController<bool> bufferingCtrl;
  late EpisodeProvider provider;

  setUp(() {
    positionCtrl = StreamController<Duration>.broadcast();
    playerStateCtrl = StreamController<PlayerState>.broadcast();
    bufferingCtrl = StreamController<bool>.broadcast();

    mockAudio = MockAudioPlayerService();
    mockApi = MockApiService();
    mockDb = MockAppDatabase();

    when(mockAudio.positionStream).thenAnswer((_) => positionCtrl.stream);
    when(mockAudio.playerStateStream)
        .thenAnswer((_) => playerStateCtrl.stream);
    when(mockAudio.bufferingStream).thenAnswer((_) => bufferingCtrl.stream);
    when(mockAudio.isPlaying).thenReturn(false);
    when(mockAudio.totalDuration).thenReturn(null);
    when(mockAudio.loadEpisode(any)).thenAnswer((_) async {});

    provider = EpisodeProvider(
      apiService: mockApi,
      audioPlayerService: mockAudio,
      db: mockDb,
    );
  });

  tearDown(() async {
    await positionCtrl.close();
    await playerStateCtrl.close();
    await bufferingCtrl.close();
    await provider.dispose();
  });

  Widget buildSheet() => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: QueueSheet(provider: provider)),
      );

  group('QueueSheet — remove button', () {
    testWidgets('shows one delete button per episode', (tester) async {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await tester.pumpWidget(buildSheet());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.delete_outline), findsNWidgets(3));
    });

    testWidgets('tapping delete removes the correct episode from provider',
        (tester) async {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await tester.pumpWidget(buildSheet());
      await tester.pumpAndSettle();

      // Delete the first item ('a')
      await tester.tap(find.byIcon(Icons.delete_outline).first);
      await tester.pump();

      expect(provider.queue.map((e) => e.id), ['b', 'c']);
    });

    testWidgets('delete button is absent for the currently playing episode',
        (tester) async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);

      await tester.pumpWidget(buildSheet());
      await tester.pumpAndSettle();

      // 'a' is playing → no delete; 'b' and 'c' have delete buttons
      expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));
    });
  });
}
