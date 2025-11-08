import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as d show OrderingTerm;

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/episode_list_item.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';

/// ---------------------------------------------------------------------------
/// DownloadList (Tab-Ansicht für Download-Manager-Screen)
/// ---------------------------------------------------------------------------
class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();

    final activeStream =
        (db.select(db.episodes)
              ..where((e) => e.status.isIn(const [1, 2])) // queued, downloading
              ..orderBy([(e) => d.OrderingTerm.desc(e.updatedAt)]))
            .watch();

    final completedStream =
        (db.select(db.episodes)
              ..where((e) => e.status.equals(3))
              ..where((e) => e.localPath.isNotNull())
              ..orderBy([(e) => d.OrderingTerm.desc(e.completedAt)]))
            .watch();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.downloading),
                text: l10n.downloads_tab_active,
              ),
              Tab(
                icon: const Icon(Icons.check_circle_outline),
                text: l10n.downloads_tab_done,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _ActiveDownloads(stream: activeStream),
                _CompletedDownloads(stream: completedStream),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveDownloads extends StatelessWidget {
  const _ActiveDownloads({required this.stream});

  final Stream<List<Episode>> stream;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.read<DownloadProvider>();

    return StreamBuilder<List<Episode>>(
      stream: stream,
      builder: (context, snap) {
        final items = snap.data ?? const [];
        if (snap.connectionState == ConnectionState.waiting && items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (items.isEmpty) {
          return Center(child: Text(l10n.downloads_empty_active));
        }
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final ep = items[i];
            final status = _statusLabel(context, ep.status);
            final percentLabel = formatProgress(ep.progress);

            final bytesMB = (ep.bytesDownloaded != null)
                ? (ep.bytesDownloaded! / (1024 * 1024)).toStringAsFixed(1)
                : null;
            final totalMB = (ep.totalBytes != null)
                ? (ep.totalBytes! / (1024 * 1024)).toStringAsFixed(1)
                : null;
            final detail = (bytesMB != null && totalMB != null)
                ? ' ($bytesMB / $totalMB MB)'
                : '';

            final activeSubtitle = '$status · $percentLabel$detail';
            return ListTile(
              leading: _statusIcon(ep.status),
              title: Text(ep.title),
              subtitle: Text(activeSubtitle),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (ep.status == 2)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: (ep.progress),
                        strokeWidth: 3,
                      ),
                    ),
                  if (ep.status == 2) const SizedBox(width: 8),
                  if (ep.status == 2) Text(percentLabel),

                  if (ep.status == 2 &&
                      (ep.resumable ?? false)) // downloading & resumable
                    IconButton(
                      tooltip: l10n.downloads_action_pause,
                      icon: const Icon(Icons.pause),
                      onPressed: () => provider.pause(ep.id),
                    ),

                  if (ep.status == 1 &&
                      (ep.resumable ?? false)) // queued & resumable
                    IconButton(
                      tooltip: l10n.downloads_action_resume,
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () => provider.resume(ep.id),
                    ),
                  IconButton(
                    tooltip: l10n.downloads_action_cancel,
                    icon: const Icon(Icons.stop),
                    onPressed: () => provider.cancel(ep.id),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _CompletedDownloads extends StatelessWidget {
  const _CompletedDownloads({required this.stream});

  final Stream<List<Episode>> stream;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<Episode>>(
      stream: stream,
      builder: (context, snap) {
        final items = snap.data ?? const [];
        if (snap.connectionState == ConnectionState.waiting && items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (items.isEmpty) {
          return Center(child: Text(l10n.downloads_empty_done));
        }
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final ep = items[i];

            return ListTile(
              leading: ImageUrl(path: ep.cachedImagePath),
              title: Text('${ep.podcastId} • ${ep.title}'),
              subtitle: FutureBuilder<model.Episode?>(
                future:
                    // (ep.cachedMetaPath != null && ep.cachedMetaPath!.isNotEmpty)
                    (ep.cachedMetaPath?.isNotEmpty ?? false)
                    ? readEpisodeFromCacheJson(ep.cachedMetaPath!)
                    : Future.value(null),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Or any other loading indicator
                  }
                  if (snap.hasError) {
                    return Text('Error: ${snap.error}'); // Show error message
                  }
                  final l10n = AppLocalizations.of(context)!;
                  final showDate =
                      snap.data?.showDate ?? ''; // bereits formatiert
                  final base =
                      '${l10n.downloads_status_done} • ${ep.id} - ${ep.localPath}';
                  final text = showDate.isNotEmpty ? '$base · $showDate' : base;
                  return Text(text);
                },
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'play':
                      final m = model.Episode(
                        id: ep.id,
                        podcastId: ep.podcastId,
                        title: ep.title,
                        description: '',
                        audioUrl: ep.audioUrl,
                        publishedAt: ep.publishedAt ?? DateTime.now(),
                        duration: Duration.zero,
                        hosts: const [],
                        showDate: '',
                      );
                      // bevorzugt lokal (Provider liest cachedMetaPath bei Step 1)
                      // ignore: use_build_context_synchronously
                      context.read<EpisodeProvider>().playEpisode(
                        m,
                        queue: [m],
                        preferLocal: true,
                      );
                      break;
                    case 'open':
                      if (ep.localPath != null && ep.localPath!.isNotEmpty) {
                        _openInFolder(ep.localPath!);
                      }
                      break;
                    case 'delete':
                      // ignore: use_build_context_synchronously
                      context.read<DownloadProvider>().removeLocalFile(ep.id);
                      break;
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'play',
                    child: Row(
                      children: const [
                        Icon(Icons.play_arrow, size: 18),
                        SizedBox(width: 8),
                        Text('Abspielen'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'open',
                    child: Row(
                      children: const [
                        Icon(Icons.folder_open, size: 18),
                        SizedBox(width: 8),
                        Text('Im Ordner öffnen'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: const [
                        Icon(Icons.delete_outline, size: 18),
                        SizedBox(width: 8),
                        Text('Löschen'),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                final m = model.Episode(
                  id: ep.id,
                  podcastId: ep.podcastId,
                  title: ep.title,
                  description: '',
                  audioUrl: ep.audioUrl,
                  publishedAt: ep.publishedAt ?? DateTime.now(),
                  duration: Duration.zero,
                  hosts: const [],
                  showDate: '',
                );

                // bevorzugt lokalen Pfad verwenden (EpisodeProvider prüft DB & localPath)
                context.read<EpisodeProvider>().playEpisode(
                  m,
                  queue: [m], // optional: Queue nur diese eine
                  preferLocal: true, // explizit
                );
              },
            );
          },
        );
      },
    );
  }
}

String _statusLabel(BuildContext context, int status) {
  final l10n = AppLocalizations.of(context)!;
  switch (status) {
    case 1:
      return l10n.downloads_status_waiting;
    case 2:
      return l10n.downloads_status_running;
    case 3:
      return l10n.downloads_status_done;
    case 4:
      return l10n.downloads_status_failed;
    case 5:
      return l10n.downloads_status_canceled;
    default:
      return l10n.downloads_status_unknown;
  }
}

Widget _statusIcon(int status) {
  switch (status) {
    case 1:
      return const Icon(Icons.schedule);
    case 2:
      return const Icon(Icons.downloading);
    case 3:
      return const Icon(Icons.check_circle_outline);
    case 4:
      return const Icon(Icons.error_outline);
    case 5:
      return const Icon(Icons.block);
    default:
      return const Icon(Icons.help_outline);
  }
}

/// ---------------------------------------------------------------------------
/// EpisodeList (lokalisiert, mit Download-Buttons) – weiterhin hier verfügbar
/// ---------------------------------------------------------------------------
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
      builder: (context, episodeProvider, podcastProvider, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.episodes.length,
          itemBuilder: (context, index) {
            final ep = widget.episodes[index];
            return EpisodeListItem(
              episode: ep,
              onTap: () async {
                await episodeProvider.playEpisode(ep, queue: widget.episodes);
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
    final l10n = AppLocalizations.of(context)!;

    final stream = (db.select(
      db.episodes,
    )..where((e) => e.id.equals(episode.id))).watchSingleOrNull();

    return StreamBuilder<Episode?>(
      stream: stream,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        final row = snap.data;
        final status =
            row?.status ??
            0; // 0 none, 1 queued, 2 downloading, 3 completed, 4 failed, 5 canceled
        final progress = row?.progress ?? 0.0;

        switch (status) {
          case 2:
            return SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: (progress > 0 && progress <= 1) ? progress : null,
              ),
            );
          case 1:
            return IconButton(
              tooltip: l10n.ep_action_resume,
              icon: const Icon(Icons.play_arrow),
              onPressed: () => dl.resume(episode.id),
            );
          case 3:
            return IconButton(
              tooltip: l10n.ep_action_downloaded,
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {},
            );
          case 4:
            return IconButton(
              tooltip: l10n.ep_action_retry,
              icon: const Icon(Icons.refresh),
              onPressed: () => dl.enqueue(episode),
            );
          case 5:
          case 0:
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

void _openInFolder(String filePath) {
  try {
    if (Platform.isWindows) {
      // zeigt die Datei im Explorer
      Process.run('explorer', ['/select,', filePath]);
    } else if (Platform.isMacOS) {
      // zeigt die Datei im Finder
      Process.run('open', ['-R', filePath]);
    } else if (Platform.isLinux) {
      // öffnet den Ordner (Datei wird ggf. nicht ausgewählt)
      final dir = File(filePath).parent.path;
      Process.run('xdg-open', [dir]);
    }
  } catch (_) {
    // still – Debug-Only
  }
}
