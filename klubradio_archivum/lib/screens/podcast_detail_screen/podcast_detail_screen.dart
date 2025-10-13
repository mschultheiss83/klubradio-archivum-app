import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/services/api_service.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';

class PodcastDetailScreen extends StatefulWidget {
  const PodcastDetailScreen({super.key, required this.podcast});

  final Podcast podcast;

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  late Future<List<Episode>> _episodesFuture;

  bool _subscribeBusy = false; // Loading-Guard für den AppBar-Button

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
    final subsDao = context.read<SubscriptionsDao>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.podcast.title),
        actions: [
          StreamBuilder<db.Subscription?>(
            stream: subsDao.watchOne(widget.podcast.id),
            builder: (context, snapshot) {
              final isSubscribed =
                  snapshot.data?.active ??
                  provider.isSubscribed(widget.podcast.id);

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton.icon(
                  onPressed: _subscribeBusy
                      ? null
                      : () async {
                          setState(() => _subscribeBusy = true);
                          final snack = ScaffoldMessenger.of(context);
                          try {
                            if (isSubscribed) {
                              await provider.unsubscribe(widget.podcast.id);
                              snack.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    l10n.podcastDetailScreenUnsubscribeSuccess,
                                  ),
                                ),
                              );
                            } else {
                              await provider.subscribe(widget.podcast.id);
                              snack.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    l10n.podcastDetailScreenSubscribeSuccess,
                                  ),
                                ),
                              );
                            }
                          } finally {
                            if (mounted) setState(() => _subscribeBusy = false);
                          }
                        },
                  icon: _subscribeBusy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(isSubscribed ? Icons.check : Icons.add),
                  label: Text(
                    isSubscribed
                        ? l10n.podcastDetailScreenUnsubscribeButton
                        : l10n.podcastDetailScreenSubscribeButton,
                  ),
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          PodcastInfoCard(podcast: widget.podcast),
          const SizedBox(height: 12),
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
