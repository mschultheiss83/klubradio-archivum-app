import 'dart:async';
import 'package:drift/drift.dart'
    as d
    show Constant, OrderingTerm, OrderingMode;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  @override
  Widget build(BuildContext context) {
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

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.downloading), text: 'Aktiv'),
              Tab(icon: Icon(Icons.check_circle_outline), text: 'Fertig'),
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
    final provider = context.read<DownloadProvider>();

    return StreamBuilder<List<Episode>>(
      stream: stream,
      builder: (context, snap) {
        final items = snap.data ?? const [];
        if (snap.connectionState == ConnectionState.waiting && items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (items.isEmpty) {
          return const Center(child: Text('Keine aktiven Downloads'));
        }
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final ep = items[i];
            final status = _statusLabel(ep.status);
            final percent = ((ep.progress ?? 0) * 100)
                .clamp(0, 100)
                .toStringAsFixed(0);

            return ListTile(
              leading: _statusIcon(ep.status),
              title: Text(ep.title),
              subtitle: Text('$status • ${ep.podcastId}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (ep.status == 2) // downloading
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: (ep.progress ?? 0),
                        strokeWidth: 3,
                      ),
                    ),
                  if (ep.status == 2) const SizedBox(width: 8),
                  if (ep.status == 2) Text('$percent%'),

                  // Pause / Fortsetzen (wir mappen paused -> queued)
                  if (ep.status == 2) // downloading -> Pause
                    IconButton(
                      tooltip: 'Pause',
                      icon: const Icon(Icons.pause),
                      onPressed: () => provider.pause(ep.id),
                    ),
                  if (ep.status == 1) // queued (als „pausiert“ interpretierbar)
                    IconButton(
                      tooltip: 'Fortsetzen',
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () => provider.resume(ep.id),
                    ),

                  // Abbrechen
                  IconButton(
                    tooltip: 'Abbrechen',
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
    final provider = context.read<DownloadProvider>();

    return StreamBuilder<List<Episode>>(
      stream: stream,
      builder: (context, snap) {
        final items = snap.data ?? const [];
        if (snap.connectionState == ConnectionState.waiting && items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (items.isEmpty) {
          return const Center(child: Text('Keine fertigen Downloads'));
        }
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final ep = items[i];
            return ListTile(
              leading: const Icon(Icons.audio_file_outlined),
              title: Text(ep.title),
              subtitle: Text('Fertig • ${ep.podcastId}'),
              trailing: IconButton(
                tooltip: 'Löschen',
                icon: const Icon(Icons.delete_outline),
                onPressed: () => provider.removeLocalFile(ep.id),
              ),
              onTap: () {
                // Optional: direkt abspielen (dein Player mit localPath)
                // z.B. openPlayer(ep.localPath)
              },
            );
          },
        );
      },
    );
  }
}

String _statusLabel(int status) {
  switch (status) {
    case 1:
      return 'Wartet';
    case 2:
      return 'Lädt';
    case 3:
      return 'Fertig';
    case 4:
      return 'Fehler';
    case 5:
      return 'Abgebrochen';
    default:
      return 'Unbekannt';
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
