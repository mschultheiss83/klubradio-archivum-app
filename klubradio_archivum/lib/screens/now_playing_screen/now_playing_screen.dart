import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../utils/helpers.dart';
import 'audio_player_controls.dart';
import 'progress_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  static const String routeName = '/now-playing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Most szól')),
      body: Consumer<EpisodeProvider>(
        builder: (BuildContext context, EpisodeProvider provider, _) {
          final Episode? episode = provider.nowPlaying;
          if (episode == null) {
            return const Center(
              child: Text('Jelenleg nem szól műsor.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  episode.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  formatEpisodeDate(episode.publishedAt),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      episode.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ProgressSlider(
                  position: provider.playbackPosition,
                  duration: provider.playbackDuration,
                  onChanged: provider.seek,
                ),
                const SizedBox(height: 24),
                AudioPlayerControls(
                  isPlaying: provider.isPlaying,
                  onTogglePlayPause: provider.togglePlayback,
                  onRewind: () => provider.seek(
                    provider.playbackPosition - const Duration(seconds: 15),
                  ),
                  onForward: () => provider.seek(
                    provider.playbackPosition + const Duration(seconds: 30),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
