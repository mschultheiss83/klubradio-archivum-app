import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/services/api_service.dart';

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
  late Future<List<Episode>> _episodesFuture;

  @override
  void initState() {
    super.initState();
    _episodesFuture = context.read<PodcastProvider>().fetchEpisodesForPodcast(
      widget.podcast.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.watch<PodcastProvider>();
    final bool isSubscribed = provider.isSubscribed(widget.podcast.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.podcast.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          PodcastInfoCard(podcast: widget.podcast),
          const SizedBox(height: 24),
          FilledButton(
            style: isSubscribed
                ? FilledButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.errorContainer,
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onErrorContainer,
                  )
                : null,
            onPressed: () {
              final snack = ScaffoldMessenger.of(context);
              if (isSubscribed) {
                provider.unsubscribe(widget.podcast.id);
                snack.showSnackBar(
                  SnackBar(
                    content: Text(l10n.podcastDetailScreenUnsubscribeSuccess),
                  ),
                );
              } else {
                provider.subscribe(widget.podcast.id);
                snack.showSnackBar(
                  SnackBar(
                    content: Text(l10n.podcastDetailScreenSubscribeSuccess),
                  ),
                );
              }
            },
            child: Text(
              isSubscribed
                  ? l10n.podcastDetailScreenUnsubscribeButton
                  : l10n.podcastDetailScreenSubscribeButton,
            ),
          ),
          const SizedBox(height: 24),
          FutureBuilder<List<Episode>>(
            future: _episodesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                String errorDetails = snapshot.error.toString();
                if (snapshot.error is ApiException) {
                  errorDetails = (snapshot.error as ApiException).message;
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      l10n.podcastDetailScreenErrorMessage(errorDetails),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final List<Episode> episodeList =
                  snapshot.data ?? const <Episode>[];
              return EpisodeList(episodes: episodeList);
            },
          ),
        ],
      ),
    );
  }
}
