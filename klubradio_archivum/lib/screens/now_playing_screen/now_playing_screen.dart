import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode.provider.dart';
import '../utils/helpers.dart';
import 'audio_player_controls.dart';
import 'progress_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final episode = provider.currentEpisode;
        if (episode == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Most szól')),
            body: const Center(
              child: Text('Jelenleg nincs lejátszott epizód.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Most szól')),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  episode.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  formatDate(episode.publishedAt),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  episode.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                ProgressSlider(provider: provider),
                const SizedBox(height: 24),
                AudioPlayerControls(provider: provider),
              ],
            ),
          ),
        );
      },
    );
  }
}
