import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../now_playing_screen/now_playing_screen.dart';
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
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keresés az archívumban')),
      body: Consumer<EpisodeProvider>(
        builder: (BuildContext context, EpisodeProvider provider, _) {
          return Column(
            children: <Widget>[
              SearchField(
                controller: _controller,
                onSearch: provider.search,
                onClear: provider.clearSearch,
              ),
              Expanded(
                child: provider.searchResults.isEmpty
                    ? RecentSearches(
                        searches: provider.recentSearches,
                        onTap: (String query) {
                          _controller.text = query;
                          provider.search(query);
                        },
                      )
                    : SearchResultsList(
                        episodes: provider.searchResults,
                        onEpisodeTap: (episode) {
                          provider.playEpisode(episode);
                          Navigator.of(context)
                              .pushNamed(NowPlayingScreen.routeName);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
