import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

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
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;

    if (searches.isEmpty) {
      return Text(
        l10n.recentSearchesNoHistory, // Use localized string
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center, // Optional: for better display
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: searches.map((String term) {
        return ActionChip(
          label: Text(
            term,
          ), // Search terms themselves are usually not localized
          onPressed: () => onSelected(term),
        );
      }).toList(),
    );
  }
}
