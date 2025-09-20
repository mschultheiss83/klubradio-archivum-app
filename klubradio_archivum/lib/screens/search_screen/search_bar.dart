import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SearchInputBar extends StatelessWidget {
  const SearchInputBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Keresés cím, téma vagy műsor alapján',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: onClear,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding),
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceVariant,
          ),
        );
      },
    );
  }
}
