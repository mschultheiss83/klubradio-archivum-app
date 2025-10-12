import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/episode.provider.dart';

// tabs
import 'package:klubradio_archivum/screens/home_screen/home_screen.dart';
import 'package:klubradio_archivum/screens/discover_screen/discover_screen.dart';
import 'package:klubradio_archivum/screens/search_screen/search_screen.dart';
import 'package:klubradio_archivum/screens/download_manager_screen/download_manager_screen.dart';
import 'package:klubradio_archivum/screens/profile_screen/profile_screen.dart';
import 'package:klubradio_archivum/screens/settings_screen/settings_screen.dart';

// chrome
import 'package:klubradio_archivum/screens/widgets/stateful/now_playing_bar.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/bottom_navigation_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // one nested navigator per tab
  final List<GlobalKey<NavigatorState>> _navKeys = List.generate(
    6,
    (_) => GlobalKey<NavigatorState>(),
  );

  Future<bool> _onWillPop() async {
    final nav = _navKeys[_index].currentState!;
    if (nav.canPop()) {
      nav.pop();
      return false; // handled here
    }
    return true; // allow system back to leave app
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasCurrent = context.watch<EpisodeProvider>().currentEpisode != null;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.appName)),
        body: IndexedStack(
          index: _index,
          children: [
            _TabNav(key: _navKeys[0], builder: (_) => const HomeScreen()),
            _TabNav(key: _navKeys[1], builder: (_) => const DiscoverScreen()),
            _TabNav(key: _navKeys[2], builder: (_) => const SearchScreen()),
            _TabNav(
              key: _navKeys[3],
              builder: (_) => const DownloadManagerScreen(),
            ),
            _TabNav(key: _navKeys[4], builder: (_) => const ProfileScreen()),
            _TabNav(key: _navKeys[5], builder: (_) => const SettingsScreen()),
          ],
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
                onTap: (i) => setState(() => _index = i),
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
