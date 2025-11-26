import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/services/api_service.dart';
// import 'package:klubradio_archivum/providers/podcast_provider.dart'; // Removed
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/models/episode.dart' as model; // Alias for model.Episode
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db; // Alias for db.Episode
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils

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
  }

  Future<void> _showUnsubscribeDialog(
      BuildContext context,
      String podcastId,
      ) async {
    final l10n = AppLocalizations.of(context)!;
    final subscriptionProvider =
    context.read<SubscriptionProvider>();
    final downloadProvider = context.read<DownloadProvider>();

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(l10n.unsubscribeDialogTitle),
        content: Text(l10n.unsubscribeDialogContent),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.unsubscribeDialogKeepButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.unsubscribeDialogDeleteButton),
          ),
        ],
      ),
    );

    if (result != null) {
      if (result) {
        await downloadProvider.deleteEpisodesForPodcast(podcastId);
      }
      await subscriptionProvider.toggleSubscription(podcastId, true);
    }
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
                if (subscriptionProvider.currentSubscription == null && !subscriptionProvider.busy) {
                  // Initial loading state or no subscription found yet
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
                        await _showUnsubscribeDialog(
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
                            !isSubscribed
                                ? l10n.podcastDetailScreenSubscribeSuccess
                                : l10n.podcastDetailScreenUnsubscribeSuccess,
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
          StreamBuilder<List<db.Episode>>( // Specify db.Episode here
            stream: context.read<EpisodesDao>().watchByPodcast(widget.podcast.id),
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
          ),
        ],
      ),
    );
  }
}
