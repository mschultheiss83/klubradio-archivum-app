import 'package:flutter/material.dart';

class TopCategoriesList extends StatelessWidget {
  const TopCategoriesList({super.key, required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Text('Nincs elérhető kategória.');
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories
          .map(
            (String category) => ActionChip(
              label: Text(category),
              onPressed: () {
                // TODO: Navigáljunk egy kategória alapú szűrő oldalra.
              },
            ),
          )
          .toList(),
    );
  }
}
