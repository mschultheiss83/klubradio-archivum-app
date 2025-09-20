import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';

class TopCategoriesList extends StatelessWidget {
  const TopCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(
      builder: (context, provider, _) {
        final categories = provider.topCategories;
        if (categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Témakörök', style: kSectionTitleStyle),
            const SizedBox(height: kSmallPadding),
            Wrap(
              spacing: kSmallPadding,
              runSpacing: kSmallPadding,
              children: List<Widget>.generate(categories.length, (index) {
                final label = categories[index];
                final icon = kCategoryIcons[index % kCategoryIcons.length];
                return FilterChip(
                  label: Text(label, style: kChipTextStyle),
                  avatar: Icon(icon, size: 18),
                  selected: false,
                  onSelected: (_) {},
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
