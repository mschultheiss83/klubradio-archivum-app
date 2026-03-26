import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/models/episode.dart' as model; // Alias for model.Episode
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db; // Alias for db.Episode
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils
import 'package:klubradio_archivum/screens/widgets/unsubscribe_dialog.dart';

class PodcastDetailScreen extends StatefulWidget {
  const PodcastDetailScreen({super.key, required this.podcast});

  final Podcast podcast;

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionProvider>().loadSubscription(widget.podcast.id);
    context.read<EpisodeProvider>().loadEpisodesIntoDb(widget.podcast.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.podcast.title),
        actions: [
          if (PlatformUtils.supportsSubscriptions)
            Consumer<SubscriptionProvider>(
              builder: (context, subscriptionProvider, child) {
                if (!subscriptionProvider.loaded) {
                  // Still loading subscription state
                  return const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }
                final bool isSubscribed = subscriptionProvider.currentSubscription?.active ?? false;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton.icon(
                  onPressed: subscriptionProvider.busy
                      ? null
                      : () async {
                    final snack = ScaffoldMessenger.of(context);
                    try {
                      if (isSubscribed) {
                        await showUnsubscribeDialog(
                            context, widget.podcast.id);
                      } else {
                        await subscriptionProvider.toggleSubscription(
                          widget.podcast.id,
                          isSubscribed,
                        );
                      }
                      if (!context.mounted) return;

                      snack.showSnackBar(
                        SnackBar(
                          content: Text(
                            isSubscribed
                                ? l10n.podcastDetailScreenUnsubscribeSuccess
                                : l10n.podcastDetailScreenSubscribeSuccess,
                          ),
                        ),
                      );
                    } catch (e) {
                      snack.showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.podcastDetailScreenErrorMessage(
                              e.toString(),
                            ),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.error,
                        ),
                      );
                    }
                  },
                  icon: subscriptionProvider.busy
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
          StreamBuilder<db.Setting?>(
            stream: (context.read<db.AppDatabase>().select(
              context.read<db.AppDatabase>().settings,
            )..where((s) => s.id.equals(1))).watchSingleOrNull(),
            builder: (context, settingsSnap) {
              final ascending = settingsSnap.data?.playOrder == 'oldest';
              return StreamBuilder<List<db.Episode>>(
            stream: context.read<EpisodesDao>().watchByPodcast(
              widget.podcast.id,
              ascending: ascending,
            ),
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

              final List<model.Episode> episodeList =
                  snapshot.data?.map((e) => model.Episode.fromDb(e)).toList() ?? const <model.Episode>[];
              return EpisodeList(episodes: episodeList);
            },
          );
            },
          ),
        ],
      ),
    );
  }
}
