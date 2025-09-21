import 'package:flutter/material.dart';

typedef RecentSearchTap = void Function(String query);

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key, required this.searches, required this.onTap});

  final List<String> searches;
  final RecentSearchTap onTap;

  @override
  Widget build(BuildContext context) {
    if (searches.isEmpty) {
      return const Center(child: Text('Még nincs korábbi keresés.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searches.length,
      itemBuilder: (BuildContext context, int index) {
        final String query = searches[index];
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(query),
          onTap: () => onTap(query),
        );
      },
    );
  }
}
