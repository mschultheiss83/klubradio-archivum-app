// lib/screens/download_manager_screen/download_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // For supportsDownloads
import 'package:klubradio_archivum/screens/widgets/stateless/episode_list_item.dart'; // Missing import

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    super.key,
    required this.episodes,
    this.enableDownloads = true,
  });

  final List<model.Episode> episodes;
  final bool enableDownloads;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<EpisodeProvider, PodcastProvider>(
      builder:
          (
            BuildContext context,
            EpisodeProvider episodeProvider,
            PodcastProvider podcastProvider,
            Widget? child,
          ) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.episodes.length,
              itemBuilder: (BuildContext context, int index) {
                final model.Episode ep = widget.episodes[index];

                return EpisodeListItem(
                  episode: ep,
                  onTap: () async {
                    await episodeProvider.playEpisode(
                      ep,
                      queue: widget.episodes,
                    );
                    podcastProvider.addRecentlyPlayed(ep);
                  },
                  trailing: widget.enableDownloads && PlatformUtils.supportsDownloads
                      ? _DownloadButton(episode: ep, queue: widget.episodes)
                      : null,
                );
              },
            );
          },
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({required this.episode, this.queue});
  final model.Episode episode;
  final List<model.Episode>? queue;

  @override
  Widget build(BuildContext context) {
    final appDb = context.read<db.AppDatabase>(); // Corrected local variable name
    final dl = context.read<DownloadProvider>();

    // Reaktiver Status aus SQLite (Drift)
    final stream = (appDb.select( // Use appDb alias
      appDb.episodes, // Use appDb alias
    )..where((e) => e.id.equals(episode.id))).watchSingleOrNull();
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<db.Episode?>( // Corrected type argument
      stream: stream,
      builder: (context, snap) {
        final row = snap.data;

        // Mappe DB-Status (int) -> UI
        final status =
            row?.status ??
            0; // 0=none,1=queued,2=downloading,3=completed,4=failed,5=canceled
        final progress = row?.progress ?? 0.0;
        final canPause = row?.resumable ?? false;

        switch (status) {
          case 2: // downloading
            return SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: (progress > 0 && progress <= 1) ? progress : null,
              ),
            );

          case 1: // queued (als "wartet/pausiert")
            return canPause
                ? IconButton(
                    tooltip: l10n.ep_action_resume,
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => dl.resume(episode.id),
                  )
                : IconButton(
                    tooltip: l10n
                        .ep_action_download, // kein Resume → normaler Download-Button
                    icon: const Icon(Icons.download_for_offline_outlined),
                    onPressed: () => dl.enqueue(episode),
                  );

          case 3: // completed
            return IconButton(
              tooltip: l10n.ep_action_downloaded,
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {
                context.read<EpisodeProvider>().playEpisode(
                  episode,
                  queue: queue,
                );
              },
            );

          case 4: // failed
            return IconButton(
              tooltip: l10n.ep_action_retry,
              icon: const Icon(Icons.refresh),
              onPressed: () => dl.enqueue(episode),
            );

          case 5: // canceled
          case 0: // none / unbekannt
          default:
            return IconButton(
              tooltip: l10n.ep_action_download,
              icon: const Icon(Icons.download_for_offline_outlined),
              onPressed: () => dl.enqueue(episode),
            );
        }
      },
    );
  }
}
