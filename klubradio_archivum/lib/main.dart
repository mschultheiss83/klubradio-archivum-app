import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
import 'screens/widgets/stateless/bottom_navigation_bar.dart';
import 'services/api_service.dart';
import 'services/audio_player_service.dart';
import 'services/download_service.dart';

void main() {
  runApp(const KlubradioArchivumApp());
}

class KlubradioArchivumApp extends StatelessWidget {
  const KlubradioArchivumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<ApiService>(
          create: (_) => ApiService(),
          dispose: (_, ApiService service) => service.dispose(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AudioPlayerService>(
          create: (_) => AudioPlayerService(),
        ),
        ChangeNotifierProvider<DownloadService>(
          create: (_) => DownloadService(),
        ),
        ChangeNotifierProxyProvider<ApiService, PodcastProvider>(
          create: (BuildContext context) => PodcastProvider(
            apiService: context.read<ApiService>(),
          ),
          update: (
            BuildContext context,
            ApiService apiService,
            PodcastProvider? previous,
          ) {
            return (previous ?? PodcastProvider(apiService: apiService))
              ..updateApiService(apiService);
          },
        ),
        ChangeNotifierProxyProvider3<ApiService, AudioPlayerService,
            DownloadService, EpisodeProvider>(
          create: (BuildContext context) => EpisodeProvider(
            apiService: context.read<ApiService>(),
            audioPlayerService: context.read<AudioPlayerService>(),
            downloadService: context.read<DownloadService>(),
          ),
          update: (
            BuildContext context,
            ApiService apiService,
            AudioPlayerService audioService,
            DownloadService downloadService,
            EpisodeProvider? previous,
          ) {
            return (previous ??
                    EpisodeProvider(
                      apiService: apiService,
                      audioPlayerService: audioService,
                      downloadService: downloadService,
                    ))
              ..updateDependencies(
                apiService: apiService,
                audioPlayerService: audioService,
                downloadService: downloadService,
              );
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider themeProvider, _) {
          return MaterialApp(
            title: 'Klubrádió Archívum',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            onGenerateRoute: (RouteSettings settings) {
              if (settings.name == PodcastDetailScreen.routeName &&
                  settings.arguments is PodcastDetailArguments) {
                final PodcastDetailArguments args =
                    settings.arguments! as PodcastDetailArguments;
                return MaterialPageRoute<void>(
                  builder: (_) => PodcastDetailScreen(podcast: args.podcast),
                );
              }
              return null;
            },
            routes: <String, WidgetBuilder>{
              AboutScreen.routeName: (_) => const AboutScreen(),
              DiscoverScreen.routeName: (_) => const DiscoverScreen(),
              DownloadManagerScreen.routeName: (_) => const DownloadManagerScreen(),
              HomeScreen.routeName: (_) => const HomeScreen(),
              NowPlayingScreen.routeName: (_) => const NowPlayingScreen(),
              ProfileScreen.routeName: (_) => const ProfileScreen(),
              SearchScreen.routeName: (_) => const SearchScreen(),
              SettingsScreen.routeName: (_) => const SettingsScreen(),
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
  State<_RootNavigationScaffold> createState() =>
      _RootNavigationScaffoldState();
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
    Future<void>.microtask(() {
      context.read<PodcastProvider>().loadHomeContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
          const NowPlayingBar(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
