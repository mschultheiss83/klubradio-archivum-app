import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/episode_provider.dart';
import 'providers/podcast_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/about_screen/about_screen.dart';
import 'screens/discover_screen/discover_screen.dart';
import 'screens/download_manager_screen/download_manager_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/now_playing_screen/now_playing_screen.dart';
import 'screens/podcast_detail_screen/podcast_detail_screen.dart';
import 'screens/profile_screen/profile_screen.dart';
import 'screens/search_screen/search_screen.dart';
import 'screens/settings_screen/settings_screen.dart';
import 'screens/widgets/stateful/now_playing_bar.dart';
import 'screens/widgets/stateless/app_bottom_navigation_bar.dart';
import 'services/api_service.dart';
import 'services/audio_player_service.dart';
import 'services/download_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KlubradioArchivumApp());
}

class KlubradioArchivumApp extends StatefulWidget {
  const KlubradioArchivumApp({super.key});

  @override
  State<KlubradioArchivumApp> createState() => _KlubradioArchivumAppState();
}

class _KlubradioArchivumAppState extends State<KlubradioArchivumApp> {
  late final ApiService _apiService;
  late final AudioPlayerService _audioPlayerService;
  late final DownloadService _downloadService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _audioPlayerService = AudioPlayerService();
    _downloadService = DownloadService();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>.value(value: _apiService),
        Provider<AudioPlayerService>.value(value: _audioPlayerService),
        Provider<DownloadService>.value(value: _downloadService),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProxyProvider<ApiService, PodcastProvider>(
          create: (context) => PodcastProvider(apiService: _apiService),
          update: (context, apiService, previous) =>
              (previous ?? PodcastProvider(apiService: apiService))
                ..updateApiService(apiService),
        ),
        ChangeNotifierProxyProvider3<ApiService, AudioPlayerService,
            DownloadService, EpisodeProvider>(
          create: (context) => EpisodeProvider(
            apiService: _apiService,
            audioPlayerService: _audioPlayerService,
            downloadService: _downloadService,
          ),
          update:
              (context, apiService, audioPlayerService, downloadService, previous) =>
                  (previous ??
                          EpisodeProvider(
                            apiService: apiService,
                            audioPlayerService: audioPlayerService,
                            downloadService: downloadService,
                          ))
                    ..updateDependencies(
                      apiService: apiService,
                      audioPlayerService: audioPlayerService,
                      downloadService: downloadService,
                    ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Klubrádió Archívum',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            routes: {
              AboutScreen.routeName: (_) => const AboutScreen(),
              SearchScreen.routeName: (_) => const SearchScreen(),
              NowPlayingScreen.routeName: (_) => const NowPlayingScreen(),
              SettingsScreen.routeName: (_) => const SettingsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == PodcastDetailScreen.routeName &&
                  settings.arguments is PodcastDetailArguments) {
                final args = settings.arguments! as PodcastDetailArguments;
                return MaterialPageRoute<void>(
                  builder: (_) => PodcastDetailScreen(podcast: args.podcast),
                );
              }
              return null;
            },
            home: const _RootNavigationScaffold(),
          );
        },
      ),
    );
  }
}

class _RootNavigationScaffold extends StatefulWidget {
  const _RootNavigationScaffold();

  @override
  State<_RootNavigationScaffold> createState() => _RootNavigationScaffoldState();
}

class _RootNavigationScaffoldState extends State<_RootNavigationScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const <Widget>[
    HomeScreen(),
    DiscoverScreen(),
    DownloadManagerScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PodcastProvider>().loadHomeContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
          const NowPlayingBar(),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
