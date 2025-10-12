import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'db/app_database.dart';
import 'providers/download_provider.dart';
import 'providers/episode.provider.dart';
import 'providers/podcast_provider.dart';
import 'providers/theme_provider.dart';
import 'services/api_service.dart';
import 'services/audio_player_service.dart';
import 'services/download_service.dart';
import 'screens/app_shell/app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const KlubradioArchivumApp());
}

class KlubradioArchivumApp extends StatelessWidget {
  const KlubradioArchivumApp({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();

    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(),
          dispose: (_, ApiService service) => service.dispose(),
        ),
        ChangeNotifierProvider<DownloadProvider>(
          create: (_) => DownloadProvider(db: db),
        ),
        Provider<AudioPlayerService>(
          create: (_) => AudioPlayerService(),
          dispose: (_, AudioPlayerService service) => service.dispose(),
        ),

        // Theme provider (consumed by the single MaterialApp below)
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),

        // PodcastProvider depends on ApiService + DownloadService
        ChangeNotifierProxyProvider2<
          ApiService,
          DownloadProvider,
          PodcastProvider
        >(
          create: (context) => PodcastProvider(
            apiService: context.read<ApiService>(),
            downloadProvider: context
                .read<DownloadProvider>(), // NEU: Param-Name anpassen
          ),
          update: (context, api, dlProv, previous) {
            if (previous != null) {
              previous.updateDependencies(
                api,
                dlProv, // NEU
              );
              return previous;
            }
            return PodcastProvider(
              apiService: api,
              downloadProvider: dlProv, // NEU
            );
          },
        ),

        // EpisodeProvider depends on ApiService + AudioPlayerService
        ChangeNotifierProxyProvider2<
          ApiService,
          AudioPlayerService,
          EpisodeProvider
        >(
          create: (context) => EpisodeProvider(
            apiService: context.read<ApiService>(),
            audioPlayerService: context.read<AudioPlayerService>(),
          ),
          update: (context, api, audio, previous) {
            if (previous != null) {
              previous.updateDependencies(api, audio);
              return previous;
            }
            return EpisodeProvider(apiService: api, audioPlayerService: audio);
          },
        ),
      ],

      // Single MaterialApp (removes the duplicate from before)
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
            theme: theme.lightTheme,
            darkTheme: theme.darkTheme,
            themeMode: theme.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            // Keep the shell mounted so bottom nav + player persist across tabs/stacks
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
