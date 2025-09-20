import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../models/podcast.dart';
import '../../providers/podcast_provider.dart';
import '../widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';

class PodcastDetailScreen extends StatefulWidget {
  const PodcastDetailScreen({super.key, required this.podcast});

  final Podcast podcast;

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadEpisodes();
  }

  Future<void> _loadEpisodes() async {
    final PodcastProvider provider = context.read<PodcastProvider>();
    await provider.fetchEpisodesForPodcast(widget.podcast.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.podcast.title)),
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Hiba történt: ${snapshot.error}'),
              ),
            );
          }

          final PodcastProvider provider = context.watch<PodcastProvider>();
          final Future<List<Episode>> episodes =
              provider.fetchEpisodesForPodcast(widget.podcast.id);

          return FutureBuilder<List<Episode>>(
            future: episodes,
            builder:
                (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final List<Episode> episodeList = snapshot.data ?? const <Episode>[];
              return ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  PodcastInfoCard(podcast: widget.podcast),
                  const SizedBox(height: 24),
                  EpisodeList(episodes: List<Episode>.from(episodeList)),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      provider.subscribe(widget.podcast.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Feliratkozás sikeres!')),
                      );
                    },
                    child: const Text('Feliratkozás'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
