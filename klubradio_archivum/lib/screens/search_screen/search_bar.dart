import 'package:flutter/material.dart';

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
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Műsorok, műsorvezetők, kulcsszavak...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                },
              ),
      ),
      textInputAction: TextInputAction.search,
      onChanged: (_) => setState(() {}),
      onSubmitted: widget.onSubmitted,
    );
  }
}
