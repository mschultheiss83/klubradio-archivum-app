import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/episode.provider.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'audio_player_controls.dart';
import 'progress_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final episode = provider.currentEpisode;
        if (episode == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.nowPlayingScreenTitle)),
            body: Center(child: Text(l10n.nowPlayingScreenNoEpisode)),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n.nowPlayingScreenTitle)),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${episode.title} - ${episode.showDate}',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  episode.hosts.join(', '),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 24), // Added more space for readability
                Expanded(
                  child: SingleChildScrollView(
                    // Makes description scrollable if too long
                    child: Text(
                      episode.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Added space before controls
                ProgressSlider(provider: provider),
                const SizedBox(height: 16), // Adjusted spacing
                AudioPlayerControls(provider: provider),
              ],
            ),
          ),
        );
      },
    );
  }
}
