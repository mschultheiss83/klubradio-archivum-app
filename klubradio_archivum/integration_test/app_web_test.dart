// integration_test/app_web_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:klubradio_archivum/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Klubrádió Archivum Web UI Tests', () {
    testWidgets('Verify main screens and player functionality', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      // Ensure the app is loaded and stable
      await tester.pumpAndSettle();

      // --- Test Main Screens ---

      // Take screenshot of the initial screen (e.g., Home or Discover)
      await binding.takeScreenshot('initial_screen');

      // Attempt to find and tap navigation items.
      // Assuming a BottomNavigationBar with at least 'Discover' and 'My Shows' and 'Downloads' and 'Settings'
      // You might need to adjust these Finders based on actual app implementation (e.g., byKey, byTooltip, bySemanticsLabel)

      // Discover Screen
      final discoverTabFinder = find.byIcon(Icons.explore); // Assuming an explore icon for discover
      if (tester.any(discoverTabFinder)) {
        await tester.tap(discoverTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('discover_screen');
      } else {
        // Fallback if icon not found, try text if available
        final discoverTextFinder = find.text('Discover');
        if (tester.any(discoverTextFinder)) {
          await tester.tap(discoverTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('discover_screen');
        } else {
          // Log a warning if no discover tab found
          debugPrint('Warning: Discover tab (icon/text) not found.');
        }
      }

      // My Shows (Subscriptions) Screen
      final myShowsTabFinder = find.byIcon(Icons.subscriptions); // Assuming subscriptions icon
      if (tester.any(myShowsTabFinder)) {
        await tester.tap(myShowsTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('my_shows_screen');
      } else {
        final myShowsTextFinder = find.text('My Shows');
        if (tester.any(myShowsTextFinder)) {
          await tester.tap(myShowsTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('my_shows_screen');
        } else {
          debugPrint('Warning: My Shows tab (icon/text) not found.');
        }
      }
      
      // Downloads Screen
      final downloadsTabFinder = find.byIcon(Icons.download); 
      if (tester.any(downloadsTabFinder)) {
        await tester.tap(downloadsTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('downloads_screen');
      } else {
        final downloadsTextFinder = find.text('Downloads');
        if (tester.any(downloadsTextFinder)) {
          await tester.tap(downloadsTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('downloads_screen');
        } else {
          debugPrint('Warning: Downloads tab (icon/text) not found.');
        }
      }

      // Settings Screen
      final settingsTabFinder = find.byIcon(Icons.settings); 
      if (tester.any(settingsTabFinder)) {
        await tester.tap(settingsTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('settings_screen');
      } else {
        final settingsTextFinder = find.text('Settings');
        if (tester.any(settingsTextFinder)) {
          await tester.tap(settingsTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('settings_screen');
        } else {
          debugPrint('Warning: Settings tab (icon/text) not found.');
        }
      }

      // --- Test Player Functionality ---
      // This part is more complex as it requires an episode to be available and playable.
      // For a basic test, we can try to find a playable item on the Discover screen
      // and tap it to open the player.

      // Navigate back to Discover to find an episode
      if (tester.any(discoverTabFinder)) {
        await tester.tap(discoverTabFinder);
        await tester.pumpAndSettle();
      } else if (tester.any(find.text('Discover'))) {
        await tester.tap(find.text('Discover'));
        await tester.pumpAndSettle();
      }

      // Find the first list item (assuming it's an episode or podcast)
      // This is a very generic finder, might need to be more specific based on your app's list item widget.
      // For example, you might use find.byType(EpisodeListItem) or find.byKey(Key('episode_1'))
      final firstListItemFinder = find.byType(ListTile).first; 

      if (tester.any(firstListItemFinder)) {
        await tester.tap(firstListItemFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('player_screen_opened');

        // Verify player controls exist (play/pause button)
        final playPauseButtonFinder = find.byIcon(Icons.play_arrow); // Or Icons.pause
        if (tester.any(playPauseButtonFinder)) {
          await tester.tap(playPauseButtonFinder);
          await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for a moment to let playback start
          await binding.takeScreenshot('player_playing');
        } else {
          debugPrint('Warning: Play/Pause button not found on player screen.');
        }

        // You can add more player interactions here, like seeking, changing speed, etc.
      } else {
        debugPrint('Warning: No list item found on Discover screen to play.');
      }
    });
  });
}
