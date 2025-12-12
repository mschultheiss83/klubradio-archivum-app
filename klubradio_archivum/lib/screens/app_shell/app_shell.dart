import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/foundation.dart'; // Import for kIsWeb -- Removed

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

import 'package:klubradio_archivum/screens/home_screen/home_screen.dart';
import 'package:klubradio_archivum/screens/discover_screen/discover_screen.dart';
import 'package:klubradio_archivum/screens/search_screen/search_screen.dart';
import 'package:klubradio_archivum/screens/download_manager_screen/download_manager_screen.dart';
import 'package:klubradio_archivum/screens/profile_screen/profile_screen.dart';
import 'package:klubradio_archivum/screens/settings_screen/settings_screen.dart';

import 'package:klubradio_archivum/screens/widgets/stateful/now_playing_bar.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/bottom_navigation_bar.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  List<GlobalKey<NavigatorState>> _navKeys = [];
  List<Widget> _screens = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initializeNavigation();
      _initialized = true;
    }
  }

  void _initializeNavigation() {
    _navKeys = [];
    _screens = [];

    // Always include these
    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const HomeScreen()),
    );

    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const DiscoverScreen()),
    );

    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const SearchScreen()),
    );

    // Conditionally add Downloads tab
    if (PlatformUtils.supportsDownloads) {
      _navKeys.add(GlobalKey<NavigatorState>());
      _screens.add(
        _TabNav(
          key: _navKeys.last,
          builder: (_) => const DownloadManagerScreen(),
        ),
      );
    }

    // Always include these
    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const ProfileScreen()),
    );

    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const SettingsScreen()),
    );

    // Ensure _index is valid if tabs were removed
    if (_index >= _screens.length) {
      _index = 0;
    }
  }

  void onPopInvokedWithResult(bool didPop, result) {
    if (didPop) return; // If system already popped, do nothing
    final nav = _navKeys[_index].currentState!;
    if (nav.canPop()) {
      nav.pop();
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasCurrent = context.watch<EpisodeProvider>().currentEpisode != null;

    // Build destinations list fresh each time
    final destinations = <NavigationDestination>[
      AppBottomNavigationBar.buildDestination(
        Icons.home_outlined,
        Icons.home,
        l10n.bottomNavHome,
      ),
      AppBottomNavigationBar.buildDestination(
        Icons.explore_outlined,
        Icons.explore,
        l10n.bottomNavDiscover,
      ),
      AppBottomNavigationBar.buildDestination(
        Icons.search_outlined,
        Icons.search,
        l10n.bottomNavSearch,
      ),
      if (PlatformUtils.supportsDownloads)
        AppBottomNavigationBar.buildDestination(
          Icons.download_outlined,
          Icons.download,
          l10n.bottomNavDownloads,
        ),
      AppBottomNavigationBar.buildDestination(
        Icons.person_outline,
        Icons.person,
        l10n.bottomNavProfile,
      ),
      AppBottomNavigationBar.buildDestination(
        Icons.settings_outlined,
        Icons.settings,
        l10n.bottomNavSettings,
      ),
    ];

    return PopScope(
      canPop: false, // We handle popping manually
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.appName)),
        body: IndexedStack(
          index: _index,
          children: _screens, // Use filtered screens
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: hasCurrent
                    ? const NowPlayingBar(key: ValueKey('npb'))
                    : const SizedBox.shrink(key: ValueKey('npb-empty')),
              ),
              AppBottomNavigationBar(
                currentIndex: _index,
                onTap: (i) async {
                  if (i == _index) {
                    // Re-tap auf denselben Tab
                    if (i == 0) {
                      final nav = _navKeys[0].currentState;
                      nav?.popUntil((route) => route.isFirst);
                      await context.read<PodcastProvider>().loadInitialData(
                        forceRefresh: true,
                      );
                    }
                    return;
                  }
                  setState(() => _index = i);
                },
                destinations: destinations,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabNav extends StatelessWidget {
  const _TabNav({super.key, required this.builder});
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: builder, settings: settings),
    );
  }
}
