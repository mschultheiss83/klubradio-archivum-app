import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../widgets/stateless/podcast_list_item.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key, required this.results});

  final List<Podcast> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          'Nincs találat a megadott keresésre.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = results[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
