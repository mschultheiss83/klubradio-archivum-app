import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'api/podcast_api.dart';
import 'l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'repositories/podcast_repository.dart';

import 'providers/download_provider.dart';
import 'providers/episode_provider.dart';
import 'providers/podcast_provider.dart';
import 'providers/latest_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/recommended_provider.dart';
import 'services/api_service.dart';
import 'services/audio_player_service.dart';
import 'screens/app_shell/app_shell.dart';
import 'providers/profile_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'repositories/profile_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const KlubradioArchivumApp());
}

class KlubradioArchivumApp extends StatefulWidget {
  const KlubradioArchivumApp({super.key});
  @override
  State<KlubradioArchivumApp> createState() => _KlubradioArchivumAppState();
}

class _KlubradioArchivumAppState extends State<KlubradioArchivumApp> {
  late final AppDatabase db;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: db),
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
        Provider<SubscriptionsDao>(
          create: (ctx) => SubscriptionsDao(ctx.read<AppDatabase>()),
        ),
        ChangeNotifierProvider<SubscriptionProvider>(
          create: (ctx) =>
              SubscriptionProvider(subscriptionsDao: ctx.read<SubscriptionsDao>()),
        ),
        // Repository layer for podcasts
        Provider<PodcastRepository>(
          create: (ctx) {
            final apiService = ctx.read<ApiService>();
            // Aus ApiService die Konfig übernehmen:
            final api = PodcastApi(
              baseUrl: apiService
                  .supabaseUrl, // <— falls nicht public: expose getter
              apiKey: apiService.supabaseKey, // <— dito
            );
            return PodcastRepository(api: api);
          },
        ),
        // ProfileRepository (SharedPreferences-basiert)
        Provider<ProfileRepository>(create: (_) => ProfileRepository()),

        // ProfileProvider (lädt Profil beim Start)
        ChangeNotifierProvider<ProfileProvider>(
          create: (ctx) =>
              ProfileProvider(repo: ctx.read<ProfileRepository>())..load(),
        ),
        ChangeNotifierProvider<LatestProvider>(
          create: (ctx) => LatestProvider(ctx.read<PodcastRepository>()),
        ),
        ChangeNotifierProvider<RecommendedProvider>(
          create: (ctx) => RecommendedProvider(ctx.read<PodcastRepository>()),
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
        ChangeNotifierProxyProvider3<
          ApiService,
          AudioPlayerService,
          AppDatabase,
          EpisodeProvider
        >(
          create: (context) => EpisodeProvider(
            apiService: context.read<ApiService>(),
            audioPlayerService: context.read<AudioPlayerService>(),
            db: context.read<AppDatabase>(),
          ),
          update: (context, api, audio, db, previous) {
            if (previous != null) {
              previous.updateDependencies(api, audio, db);
              return previous;
            }
            return EpisodeProvider(
              apiService: api,
              audioPlayerService: audio,
              db: db,
            );
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
