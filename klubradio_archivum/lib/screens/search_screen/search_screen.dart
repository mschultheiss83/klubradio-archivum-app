import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/podcast.dart';
import '../../providers/podcast_provider.dart';
import 'recent_searches.dart';
import 'search_bar.dart';
import 'search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Podcast>>? _searchFuture;

  void _onSearch(String query) {
    final PodcastProvider provider = context.read<PodcastProvider>();
    setState(() {
      _searchFuture = provider.searchPodcasts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PodcastProvider provider = context.watch<PodcastProvider>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchBarWidget(onSubmitted: _onSearch),
          const SizedBox(height: 16),
          RecentSearches(
            searches: provider.recentSearches,
            onSelected: _onSearch,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _searchFuture == null
                ? Center(
                    child: Text(
                      'Keresd meg kedvenc műsoraidat vagy műsorvezetőidet.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                : FutureBuilder<List<Podcast>>(
                    future: _searchFuture,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Podcast>> snapshot,
                    ) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Hiba történt: ${snapshot.error}'),
                        );
                      }
                      final List<Podcast> results =
                          snapshot.data ?? const <Podcast>[];
                      return SearchResultsList(results: results);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
