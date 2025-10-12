// lib/screens/download_manager_screen/download_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/episode.provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/providers/download_provider.dart'
    show DownloadProvider;
import 'package:klubradio_archivum/screens/widgets/stateless/episode_list_item.dart';

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
                  trailing: widget.enableDownloads
                      ? _DownloadButton(episode: ep)
                      : null,
                );
              },
            );
          },
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({required this.episode});
  final model.Episode episode;

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    final dl = context.read<DownloadProvider>();

    // Reaktiver Status aus SQLite (Drift)
    final stream = (db.select(
      db.episodes,
    )..where((e) => e.id.equals(episode.id))).watchSingleOrNull();

    return StreamBuilder<Episode?>(
      stream: stream,
      builder: (context, snap) {
        final row = snap.data;

        // Mappe DB-Status (int) -> UI
        final status =
            row?.status ??
            0; // 0=none,1=queued,2=downloading,3=completed,4=failed,5=canceled
        final progress = row?.progress ?? 0.0;

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
            return IconButton(
              tooltip: 'Fortsetzen',
              icon: const Icon(Icons.play_arrow),
              onPressed: () => dl.resume(episode.id),
            );

          case 3: // completed
            return IconButton(
              tooltip: 'Heruntergeladen',
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {
                // Optional: lokalen Player mit row?.localPath öffnen
                // openLocalPlayer(row?.localPath);
              },
            );

          case 4: // failed
            return IconButton(
              tooltip: 'Erneut versuchen',
              icon: const Icon(Icons.refresh),
              onPressed: () => dl.enqueue(episode),
            );

          case 5: // canceled
          case 0: // none / unbekannt
          default:
            return IconButton(
              tooltip: 'Download',
              icon: const Icon(Icons.download_for_offline_outlined),
              onPressed: () => dl.enqueue(episode),
            );
        }
      },
    );
  }
}
