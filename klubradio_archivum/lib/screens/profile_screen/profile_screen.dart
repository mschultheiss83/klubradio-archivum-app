// lib/screens/profile_screen/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/screens/profile_screen/subscriptions_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profileProv = context.watch<ProfileProvider>();
    final profile = profileProv.profileOrNull; // <- nullable getter benutzen

    // Warten nur auf das lokale Profil – NICHT mehr auf PodcastProvider.userProfile
    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        // App-ID Karte
        Card(
          child: ListTile(
            title: Text(l10n.profileScreenAppIdTitle),
            subtitle: Text(
              profile.id,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: profile.id));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.profileScreenIdCopied)),
                );
              },
            ),
          ),
        ),

        // Auto-Downloads
        ListTile(
          title: Text(l10n.profileScreenDownloadSettingsTitle),
          subtitle: Text(
            l10n.profileScreenAutoDownloadsSubtitle(profile.maxAutoDownload),
          ),
          onTap: () async {
            final n = await _pickNumber(context, profile.maxAutoDownload);
            if (n != null && context.mounted) {
              await context.read<ProfileProvider>().setMaxAutoDownload(n);
            }
          },
        ),

        // Playback Speed
        ListTile(
          title: Text(l10n.profileScreenPlaybackSpeedTitle),
          subtitle: Text('${profile.playbackSpeed.toStringAsFixed(2)}×'),
          onTap: () async {
            final v = await _pickSpeed(context, profile.playbackSpeed);
            if (v != null && context.mounted) {
              await context.read<ProfileProvider>().setPlaybackSpeed(v);
            }
          },
        ),

        const SizedBox(height: 24),
        Text(
          l10n.homeScreenSubscribedPodcastsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        // Subscriptions: direkt aus lokaler DB, kein Warten auf userProfile
        StreamBuilder<List<db.Subscription>>(
          stream: context.read<SubscriptionsDao>().watchAllActive(),
          builder: (context, subsSnap) {
            if (subsSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final subs = subsSnap.data ?? const <db.Subscription>[];
            if (subs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l10n.homeScreenSubscribedPodcastsEmptyHint,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              );
            }

            // Lade die zugehörigen Podcasts, aber blockiere das UI nicht:
            final ids = subs.map((s) => s.podcastId).toList();
            return FutureBuilder<List<Podcast?>>(
              future: Future.wait(
                ids.map(
                  (id) => context.read<PodcastProvider>().fetchPodcastById(id),
                ),
              ),
              builder: (context, podSnap) {
                if (podSnap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (podSnap.hasError) {
                  return Center(child: Text('Error: ${podSnap.error}'));
                }
                final pods = (podSnap.data ?? const <Podcast?>[])
                    .whereType<Podcast>()
                    .toList();
                if (pods.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SubscriptionsPanel(podcasts: pods);
              },
            );
          },
        ),
      ],
    );
  }
}

/// Dialog: Zahl (0–50) per Slider wählen
Future<int?> _pickNumber(BuildContext context, int current) async {
  int temp = current.clamp(0, 50);
  return showDialog<int>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(ctx)!.profileScreenAutoDownloadsTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: temp.toDouble(),
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: '$temp',
                  onChanged: (v) => setState(() => temp = v.round()),
                ),
                Text('${AppLocalizations.of(ctx)!.commonCount}: $temp'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(AppLocalizations.of(ctx)!.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(temp),
                child: Text(AppLocalizations.of(ctx)!.commonOk),
              ),
            ],
          );
        },
      );
    },
  );
}

/// Dialog: Speed (0.5–2.0) per Slider wählen
Future<double?> _pickSpeed(BuildContext context, double current) async {
  double temp = current.clamp(0.5, 2.0);
  return showDialog<double>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(ctx)!.profileScreenPlaybackSpeedTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: temp,
                  min: 0.5,
                  max: 2.0,
                  divisions: 30,
                  label: '${temp.toStringAsFixed(2)}×',
                  onChanged: (v) => setState(() => temp = v),
                ),
                Text(
                  '${AppLocalizations.of(ctx)!.profileScreenPlaybackSpeedValue(temp.toStringAsFixed(2))}×',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(AppLocalizations.of(ctx)!.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(temp),
                child: Text(AppLocalizations.of(ctx)!.commonOk),
              ),
            ],
          );
        },
      );
    },
  );
}
