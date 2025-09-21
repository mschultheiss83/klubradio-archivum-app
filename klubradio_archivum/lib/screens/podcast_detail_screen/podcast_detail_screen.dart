import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/podcast.dart';
import '../../providers/episode_provider.dart';
import '../now_playing_screen/now_playing_screen.dart';
import '../widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';

class PodcastDetailArguments {
  const PodcastDetailArguments({required this.podcast});

  final Podcast podcast;
}

class PodcastDetailScreen extends StatefulWidget {
  const PodcastDetailScreen({super.key, required this.podcast});

  static const String routeName = '/podcast-detail';

  final Podcast podcast;

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(() {
      context
          .read<EpisodeProvider>()
          .loadEpisodesForPodcast(widget.podcast.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.podcast.title)),
      body: Consumer<EpisodeProvider>(
        builder: (BuildContext context, EpisodeProvider provider, _) {
          if (provider.isLoading && provider.episodes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              PodcastInfoCard(podcast: widget.podcast),
              const SizedBox(height: 24),
              Text(
                'Epizódok',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              EpisodeList(
                episodes: provider.episodes,
                onEpisodeTap: (episode) {
                  provider.playEpisode(episode);
                  Navigator.of(context).pushNamed(NowPlayingScreen.routeName);
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Kapcsoljuk össze a feliratkozás logikával (Supabase/Hive).
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feliratkozás rögzítése később lesz elérhető.')),
          );
        },
        icon: const Icon(Icons.add_alert),
        label: const Text('Feliratkozás'),
      ),
    );
  }
}
