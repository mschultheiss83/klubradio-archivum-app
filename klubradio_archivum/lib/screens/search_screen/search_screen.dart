import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;
import 'package:klubradio_archivum/services/api_service.dart';

import 'recent_searches.dart';
import 'search_bar.dart';
import 'search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Podcast>>? _podcastFuture;
  Future<List<model.Episode>>? _episodeFuture;
  Timer? _debounce;
  String _lastQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  bool get _hasSearch => _podcastFuture != null || _episodeFuture != null;

  void _onSearch(String query) {
    _debounce?.cancel();
    _lastQuery = query;
    final PodcastProvider provider = context.read<PodcastProvider>();
    setState(() {
      if (query.trim().isEmpty) {
        _podcastFuture = null;
        _episodeFuture = null;
        return;
      }
      _podcastFuture = provider.searchPodcasts(query);
      _episodeFuture = provider.searchEpisodes(query);
    });
  }

  void _onChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      if (_hasSearch) {
        setState(() {
          _podcastFuture = null;
          _episodeFuture = null;
          _lastQuery = '';
        });
      }
      return;
    }
    if (query.trim().length < constants.minSearchLength) return;
    if (query.trim() == _lastQuery.trim()) return;

    _debounce = Timer(constants.searchDebounce, () {
      _onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final PodcastProvider provider = context.watch<PodcastProvider>();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SearchBarWidget(
            onSubmitted: _onSearch,
            onChanged: _onChanged,
          ),
        ),
        if (!_hasSearch) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: RecentSearches(
              searches: provider.recentSearches,
              onSelected: _onSearch,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                l10n.searchScreenInitialPrompt,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        if (_hasSearch) ...[
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.searchTabShows),
              Tab(text: l10n.searchTabEpisodes),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPodcastResults(l10n),
                _buildEpisodeResults(l10n),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPodcastResults(AppLocalizations l10n) {
    return FutureBuilder<List<Podcast>>(
      future: _podcastFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _buildError(l10n, snapshot.error!);
        }
        final results = snapshot.data ?? const <Podcast>[];
        return SearchResultsList(results: results);
      },
    );
  }

  Widget _buildEpisodeResults(AppLocalizations l10n) {
    return FutureBuilder<List<model.Episode>>(
      future: _episodeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _buildError(l10n, snapshot.error!);
        }
        final results = snapshot.data ?? const <model.Episode>[];
        if (results.isEmpty) {
          return Center(
            child: Text(
              l10n.searchResultsNoResults,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          );
        }
        return _EpisodeResultsList(episodes: results);
      },
    );
  }

  Widget _buildError(AppLocalizations l10n, Object error) {
    String errorDetails = error.toString();
    if (error is ApiException) {
      errorDetails = error.message;
    } else if (error is FormatException) {
      errorDetails = l10n.errorParsingData;
    }
    return Center(
      child: Text(
        l10n.searchScreenErrorMessage(errorDetails),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}

class _EpisodeResultsList extends StatelessWidget {
  const _EpisodeResultsList({required this.episodes});

  final List<model.Episode> episodes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: episodes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final episode = episodes[index];
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.audiotrack),
            title: Text(
              episode.displayTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(episode.showDate),
            trailing: Text(
              _formatDuration(episode.duration),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }
}
