import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({
    super.key,
    required this.searches,
    required this.onSelected,
  });

  final List<String> searches;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (searches.isEmpty) {
      return Text(
        'Még nincs keresési előzmény.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: searches.map((String term) {
        return ActionChip(
          label: Text(term),
          onPressed: () => onSelected(term),
        );
      }).toList(),
    );
  }
}
