import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'audio_player_controls.dart';
import 'progress_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  static const String routeName = '/now-playing';

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final Episode? episode = provider.nowPlaying;
        if (episode == null) {
          return const Scaffold(
            body: Center(child: Text('Jelenleg nincs lejátszott epizód.')),
          );
        }

        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Most szól'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  episode.isDownloaded ? Icons.download_done : Icons.download,
                ),
                tooltip: episode.isDownloaded
                    ? 'Letöltés törlése'
                    : 'Letöltés offline meghallgatáshoz',
                onPressed: episode.isDownloaded
                    ? () => provider.removeDownload(episode)
                    : () => provider.downloadEpisode(episode),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (episode.imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      episode.imageUrl,
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(Icons.podcasts, size: 96, color: colorScheme.primary),
                  ),
                const SizedBox(height: kDefaultPadding),
                Text(
                  episode.title,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kSmallPadding),
                Text(
                  formatDateTime(episode.publishedAt),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: kDefaultPadding),
                const ProgressSlider(),
                const SizedBox(height: kDefaultPadding),
                const AudioPlayerControls(),
                const SizedBox(height: kDefaultPadding),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      episode.description.isEmpty
                          ? 'Ehhez az epizódhoz nem tartozik leírás.'
                          : episode.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
