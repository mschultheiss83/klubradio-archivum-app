import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';

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
      // Clear previous search future immediately for better UX if query is empty
      if (query.trim().isEmpty) {
        _searchFuture = null;
        // Optionally, also clear recent searches if that's the desired behavior for empty submit
        // provider.clearLastSearch(); // You'd need to implement this in provider
        return;
      }
      _searchFuture = provider.searchPodcasts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;
    final PodcastProvider provider = context.watch<PodcastProvider>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchBarWidget(onSubmitted: _onSearch),
          const SizedBox(height: 16),
          // Conditionally show RecentSearches only if no search is active
          if (_searchFuture == null) ...[
            // You might want a title for recent searches too, e.g., l10n.recentSearchesTitle
            // Text(l10n.recentSearchesTitle, style: Theme.of(context).textTheme.titleMedium),
            // const SizedBox(height: 8),
            RecentSearches(
              searches: provider.recentSearches,
              onSelected: _onSearch,
            ),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: _searchFuture == null
                ? Center(
                    child: Text(
                      l10n.searchScreenInitialPrompt, // Use localized string
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                : FutureBuilder<List<Podcast>>(
                    future: _searchFuture,
                    builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        // Extracting a user-friendly part of the error
                        // For API errors, you might have a custom error class with a localized message
                        String errorDetails = snapshot.error.toString();
                        if (snapshot.error is ApiException) {
                          // Assuming ApiException from your ApiService
                          // TODO: Map ApiException type to a localized string (as discussed for ApiService)
                          // For now, just using the raw message, but ideally, this would be more structured.
                          errorDetails =
                              (snapshot.error as ApiException).message;
                        } else if (snapshot.error is FormatException) {
                          errorDetails = l10n
                              .errorParsingData; // Example: Create a specific l10n key
                        }
                        // else if ... other common error types

                        return Center(
                          child: Text(
                            l10n.searchScreenErrorMessage(
                              errorDetails,
                            ), // Use localized string
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        );
                      }
                      final List<Podcast> results =
                          snapshot.data ?? const <Podcast>[];
                      // SearchResultsList already handles its own "no results" message
                      return SearchResultsList(results: results);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
