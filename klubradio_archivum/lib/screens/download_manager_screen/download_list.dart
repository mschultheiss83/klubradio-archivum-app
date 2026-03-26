import 'dart:io';

import 'package:drift/drift.dart' as d show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/episode_list_item.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';

import 'download_list_entries.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();

    final activeStream =
        (db.select(db.episodes)
              ..where((e) => e.status.isIn(const [1, 2]))
              ..orderBy([(e) => d.OrderingTerm.desc(e.updatedAt)]))
            .watch();

    final completedStream =
        (db.select(db.episodes)
              ..where((e) => e.status.equals(3))
              ..where((e) => e.localPath.isNotNull())
              ..orderBy([(e) => d.OrderingTerm.desc(e.completedAt)]))
            .watch();

    return StreamBuilder<List<Episode>>(
      stream: activeStream,
      builder: (context, activeSnap) {
        return StreamBuilder<List<Episode>>(
          stream: completedStream,
          builder: (context, completedSnap) {
            final activeItems = activeSnap.data ?? const <Episode>[];
            final completedItems = completedSnap.data ?? const <Episode>[];

            final bothWaiting =
                activeSnap.connectionState == ConnectionState.waiting &&
                completedSnap.connectionState == ConnectionState.waiting;
            if (bothWaiting && activeItems.isEmpty && completedItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (activeItems.isEmpty && completedItems.isEmpty) {
              return Center(child: Text(l10n.noDownloads));
            }

            final entries = buildDownloadListEntries(
              activeItems: activeItems,
              completedItems: completedItems,
            );

            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                switch (entry.type) {
                  case DownloadListEntryType.activeHeader:
                    return _SectionHeader(
                      icon: Icons.downloading,
                      title: l10n.downloads_section_active,
                    );
                  case DownloadListEntryType.activeItem:
                    return _ActiveDownloadTile(episode: entry.episode!);
                  case DownloadListEntryType.completedHeader:
                    return _SectionHeader(
                      icon: Icons.check_circle_outline,
                      title: l10n.downloads_section_completed,
                    );
                  case DownloadListEntryType.completedItem:
                    return _CompletedDownloadTile(episode: entry.episode!);
                }
              },
            );
          },
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveDownloadTile extends StatelessWidget {
  const _ActiveDownloadTile({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.read<DownloadProvider>();
    final ep = episode;
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
    return Column(
      children: [
        ListTile(
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
                    value: ep.progress,
                    strokeWidth: 3,
                  ),
                ),
              if (ep.status == 2) const SizedBox(width: 8),
              if (ep.status == 2) Text(percentLabel),
              if (ep.status == 2 && (ep.resumable ?? false))
                IconButton(
                  tooltip: l10n.downloads_action_pause,
                  icon: const Icon(Icons.pause),
                  onPressed: () => provider.pause(ep.id),
                ),
              if (ep.status == 1 && (ep.resumable ?? false))
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
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class _CompletedDownloadTile extends StatelessWidget {
  const _CompletedDownloadTile({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ep = episode;

    return Column(
      children: [
        ListTile(
          leading: ImageUrl(path: ep.cachedImagePath),
          title: Text('${ep.podcastId} • ${ep.title}'),
          subtitle: FutureBuilder<model.Episode?>(
            future: (ep.cachedMetaPath?.isNotEmpty ?? false)
                ? readEpisodeFromCacheJson(ep.cachedMetaPath!)
                : Future.value(null),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snap.hasError) {
                return Text(l10n.downloads_error(snap.error.toString()));
              }
              final showDate = snap.data?.showDate ?? '';
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
                  final m = model.Episode.fromDb(ep);
                  context.read<EpisodeProvider>().playEpisode(
                    m,
                    queue: [m],
                    preferLocal: true,
                  );
                  break;
                case 'queue':
                  final m = model.Episode.fromDb(ep);
                  context.read<EpisodeProvider>().addToQueue(m);
                  break;
                case 'open':
                  if (ep.localPath != null && ep.localPath!.isNotEmpty) {
                    _openInFolder(ep.localPath!);
                  }
                  break;
                case 'delete':
                  context.read<DownloadProvider>().removeLocalFile(ep.id);
                  break;
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'play',
                child: Row(
                  children: [
                    const Icon(Icons.play_arrow, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_play),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'queue',
                child: Row(
                  children: [
                    const Icon(Icons.playlist_add, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_add_to_queue),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'open',
                child: Row(
                  children: [
                    const Icon(Icons.folder_open, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_open_folder),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_delete),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            final m = model.Episode.fromDb(ep);
            context.read<EpisodeProvider>().playEpisode(
              m,
              queue: [m],
              preferLocal: true,
            );
          },
        ),
        const Divider(height: 1),
      ],
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
        final status = row?.status ?? 0;
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
      Process.run('explorer', ['/select,', filePath]);
    } else if (Platform.isMacOS) {
      Process.run('open', ['-R', filePath]);
    } else if (Platform.isLinux) {
      final dir = File(filePath).parent.path;
      Process.run('xdg-open', [dir]);
    }
  } catch (_) {
    // Debug-only no-op.
  }
}
