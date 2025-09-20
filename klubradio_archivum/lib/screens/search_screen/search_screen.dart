import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../utils/constants.dart';
import 'recent_searches.dart';
import 'search_bar.dart';
import 'search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keresés az archívumban'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchInputBar(
              controller: _controller,
              onChanged: (value) {
                context.read<EpisodeProvider>().searchEpisodes(value);
              },
              onClear: () {
                _controller.clear();
                context.read<EpisodeProvider>().clearSearch();
              },
            ),
            const SizedBox(height: kDefaultPadding),
            const RecentSearches(),
            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: Consumer<EpisodeProvider>(
                builder: (context, provider, _) {
                  if (provider.isSearching) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final episodes = provider.searchResults;
                  if (episodes.isEmpty) {
                    return const Center(
                      child: Text('Nincs találat. Próbálj meg másik kulcsszót.'),
                    );
                  }

                  return SearchResultsList(episodes: episodes);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
