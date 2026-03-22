import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.onSubmitted,
    this.onChanged,
  });

  final ValueChanged<String> onSubmitted;
  final ValueChanged<String>? onChanged;

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
                tooltip: MaterialLocalizations.of(
                  context,
                ).deleteButtonTooltip,
                onPressed: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                  widget.onSubmitted('');
                  setState(() {});
                },
              ),
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        setState(() {}); // rebuild clear icon
        widget.onChanged?.call(value);
      },
      onSubmitted: widget.onSubmitted,
    );
  }
}
