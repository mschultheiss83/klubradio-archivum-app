import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/episode.provider.dart';
import 'providers/podcast_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen/home_screen.dart';
import 'services/api_service.dart';
import 'services/audio_player_service.dart';
import 'services/download_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const KlubradioArchivumApp());
}

class KlubradioArchivumApp extends StatelessWidget {
  const KlubradioArchivumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(),
          dispose: (_, ApiService service) => service.dispose(),
        ),
        Provider<DownloadService>(
          create: (_) => DownloadService(),
          dispose: (_, DownloadService service) => service.dispose(),
        ),
        Provider<AudioPlayerService>(
          create: (_) => AudioPlayerService(),
          dispose: (_, AudioPlayerService service) => service.dispose(),
        ),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProxyProvider2<
          ApiService,
          DownloadService,
          PodcastProvider
        >(
          create: (BuildContext context) => PodcastProvider(
            apiService: context.read<ApiService>(),
            downloadService: context.read<DownloadService>(),
          ),
          update:
              (
                BuildContext context,
                ApiService apiService,
                DownloadService downloadService,
                PodcastProvider? previous,
              ) {
                if (previous != null) {
                  previous.updateDependencies(apiService, downloadService);
                  return previous;
                }
                return PodcastProvider(
                  apiService: apiService,
                  downloadService: downloadService,
                );
              },
        ),
        ChangeNotifierProxyProvider2<
          ApiService,
          AudioPlayerService,
          EpisodeProvider
        >(
          create: (BuildContext context) => EpisodeProvider(
            apiService: context.read<ApiService>(),
            audioPlayerService: context.read<AudioPlayerService>(),
          ),
          update:
              (
                BuildContext context,
                ApiService apiService,
                AudioPlayerService audioPlayerService,
                EpisodeProvider? previous,
              ) {
                if (previous != null) {
                  previous.updateDependencies(apiService, audioPlayerService);
                  return previous;
                }
                return EpisodeProvider(
                  apiService: apiService,
                  audioPlayerService: audioPlayerService,
                );
              },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder:
            (BuildContext context, ThemeProvider themeProvider, Widget? child) {
              return MaterialApp(
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appName,
                theme: themeProvider.lightTheme,
                darkTheme: themeProvider.darkTheme,
                themeMode: themeProvider.themeMode,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                localeResolutionCallback: (locale, supportedLocales) {
                  return locale;
                },
                home: const HomeScreen(),
              );
            },
      ),
    );
  }
}
