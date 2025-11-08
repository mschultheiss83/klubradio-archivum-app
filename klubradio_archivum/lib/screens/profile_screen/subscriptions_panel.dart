import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';

class SubscriptionsPanel extends StatelessWidget {
  const SubscriptionsPanel({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (podcasts.isEmpty) {
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

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final p = podcasts[i];
        return _PodcastTile(podcast: p);
      },
    );
  }
}

class _PodcastTile extends StatelessWidget {
  const _PodcastTile({required this.podcast});
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          podcast.coverImageUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              Container(width: 56, height: 56, color: cs.surfaceContainerHighest),
        ),
      ),
      title: Text(podcast.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        podcast.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: cs.outline),
      ),

      // Abbestellen
      trailing: OutlinedButton.icon(
        icon: const Icon(Icons.notifications_off, size: 18),
        label: Text(l10n.podcastListItem_unsubscribe),
        onPressed: () async {
          await context.read<SubscriptionsDao>().toggleSubscribe(
            podcastId: podcast.id,
            active: false,
          );
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.commonDone)));
        },
      ),

      // Details öffnen
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PodcastDetailScreen(podcast: podcast),
          ),
        );
      },
    );
  }
}
