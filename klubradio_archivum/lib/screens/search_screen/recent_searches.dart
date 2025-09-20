import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../utils/constants.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final searches = provider.recentSearches;
        if (searches.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Legutóbbi keresések', style: kSectionTitleStyle),
            const SizedBox(height: kSmallPadding),
            Wrap(
              spacing: kSmallPadding,
              runSpacing: kSmallPadding,
              children: searches
                  .map(
                    (query) => ActionChip(
                      label: Text(query),
                      onPressed: () =>
                          context.read<EpisodeProvider>().searchEpisodes(query),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
