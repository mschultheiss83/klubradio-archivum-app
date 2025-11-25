// lib/screens/now_playing/now_playing_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'audio_player_controls.dart';
import 'progress_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

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

    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final episode = provider.currentEpisode;
        if (episode == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.nowPlayingScreenTitle)),
            body: Center(child: Text(l10n.nowPlayingScreenNoEpisode)),
          );
        }

        // Responsive cover size (max 240, ~40% of screen width)
        final double screenW = MediaQuery.sizeOf(context).width;
        final double coverSize = math.min(240, screenW * 0.4);

        return Scaffold(
          appBar: AppBar(title: Text(l10n.nowPlayingScreenTitle)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Scrollable top section prevents bottom overflow on small screens
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.viewPaddingOf(context).bottom,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 24,
                        runSpacing: 16,
                        children: [
                          // Left: cover art
                          ImageUrl(
                            url: episode.imageUrl ?? "",
                            path: episode.cachedImagePath ?? "",
                            width: coverSize,
                            height: coverSize,
                          ),

                          // Right: info
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${episode.displayTitle} - ${episode.showDate}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 12),

                                if (episode.hosts.isNotEmpty) ...[
                                  Text(
                                    episode.hosts.join('\n'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                Text(
                                  episode.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12),
                                Consumer<SubscriptionProvider>(
                                  builder: (context, subscriptionProvider, child) {
                                    return StreamBuilder<Subscription?>(
                                      stream: subscriptionProvider
                                          .watchSubscription(episode.podcastId),
                                      builder: (context, snapshot) {
                                        final isSubscribed = snapshot.data != null;
                                        return ElevatedButton(
                                          onPressed: subscriptionProvider.busy
                                              ? null
                                              : () {
                                                  if (isSubscribed) {
                                                    _showUnsubscribeDialog(
                                                        context, episode.podcastId);
                                                  } else {
                                                    subscriptionProvider
                                                        .toggleSubscription(
                                                      episode.podcastId,
                                                      isSubscribed,
                                                    );
                                                  }
                                                },
                                          child: Text(isSubscribed
                                              ? l10n.podcastDetailScreenUnsubscribeButton
                                              : l10n.podcastDetailScreenSubscribeButton),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Progress + controls stay visible without overflow
                  ProgressSlider(
                    positionNotifier: provider.positionNotifier,
                    totalDuration: provider.totalDuration ?? Duration.zero,
                    onSeek: provider.seek,
                  ),
                  const SizedBox(height: 12),
                  AudioPlayerControls(provider: provider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
