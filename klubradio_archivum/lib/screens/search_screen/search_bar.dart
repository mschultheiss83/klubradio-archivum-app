import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, required this.onSubmitted});

  final ValueChanged<String> onSubmitted;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: l10n.searchBarHintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                // Tooltip for the clear button (accessibility and discoverability)
                tooltip: MaterialLocalizations.of(
                  context,
                ).deleteButtonTooltip, // Using built-in Material localization
                onPressed: () {
                  _controller.clear();
                  widget.onSubmitted(
                    '',
                  ); // Optionally submit an empty string to clear results
                  setState(() {});
                },
              ),
      ),
      textInputAction: TextInputAction.search,
      onChanged: (_) =>
          setState(() {}), // To rebuild and show/hide the clear icon
      onSubmitted: widget.onSubmitted,
    );
  }
}
