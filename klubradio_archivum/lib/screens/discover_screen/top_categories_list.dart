import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../utils/constants.dart' as constants;

class TopCategoriesList extends StatelessWidget {
  const TopCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: constants.topCategories.map((String category) {
        return FilterChip(
          label: Text(category.toUpperCase()),
          onSelected: (bool selected) {
            if (!selected) {
              return;
            }
            context.read<PodcastProvider>().addRecentSearch(category);
            // TODO: trigger category specific filtering once API supports it.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('"$category" kategória kiválasztva.'),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
