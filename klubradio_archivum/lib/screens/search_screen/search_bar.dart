import 'package:flutter/material.dart';

typedef SearchCallback = void Function(String query);

typedef VoidSearchCallback = void Function();

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  final TextEditingController controller;
  final SearchCallback onSearch;
  final VoidSearchCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Keress cím, dátum vagy műsor szerint',
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: onSearch,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              onClear();
            },
          ),
          ElevatedButton(
            onPressed: () => onSearch(controller.text),
            child: const Text('Keresés'),
          ),
        ],
      ),
    );
  }
}
