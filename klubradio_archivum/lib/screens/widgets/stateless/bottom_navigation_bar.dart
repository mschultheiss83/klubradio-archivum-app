import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    // Localized labels in index order
    final labels = <String>[
      l10n.bottomNavHome,
      l10n.bottomNavDiscover,
      l10n.bottomNavSearch,
      l10n.bottomNavDownloads,
      l10n.bottomNavProfile,
      l10n.bottomNavSettings,
    ];

    final double w = MediaQuery.of(context).size.width;
    final bool isSmall = w < 600;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant.withOpacity(0.5),
            width: 0.6,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top title strip (selected destination label)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  isSmall ? 8 : 10,
                  16,
                  isSmall ? 4 : 6,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SizeTransition(
                      sizeFactor: anim,
                      axisAlignment: -1,
                      child: child,
                    ),
                  ),
                  child: _TitleLabel(
                    key: ValueKey<int>(currentIndex),
                    text: labels[currentIndex],
                    color: cs.onSurface,
                    isSmall: isSmall,
                  ),
                ),
              ),

              // Icon-only NavigationBar
              NavigationBar(
                selectedIndex: currentIndex,
                onDestinationSelected: onTap,
                height: isSmall ? 60 : 68,
                backgroundColor: cs.surface,
                indicatorColor: cs.primary.withOpacity(0.12),
                labelBehavior: NavigationDestinationLabelBehavior
                    .alwaysHide, // we show label above
                destinations: <NavigationDestination>[
                  _dest(
                    Icons.home_outlined,
                    Icons.home,
                    labels[0],
                    selected: currentIndex == 0,
                    cs: cs,
                  ),
                  _dest(
                    Icons.explore_outlined,
                    Icons.explore,
                    labels[1],
                    selected: currentIndex == 1,
                    cs: cs,
                  ),
                  _dest(
                    Icons.search_outlined,
                    Icons.search,
                    labels[2],
                    selected: currentIndex == 2,
                    cs: cs,
                  ),
                  _dest(
                    Icons.download_outlined,
                    Icons.download,
                    labels[3],
                    selected: currentIndex == 3,
                    cs: cs,
                  ),
                  _dest(
                    Icons.person_outline,
                    Icons.person,
                    labels[4],
                    selected: currentIndex == 4,
                    cs: cs,
                  ),
                  _dest(
                    Icons.settings_outlined,
                    Icons.settings,
                    labels[5],
                    selected: currentIndex == 5,
                    cs: cs,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static NavigationDestination _dest(
    IconData icon,
    IconData selectedIcon,
    String tooltip, {
    required bool selected,
    required ColorScheme cs,
  }) {
    return NavigationDestination(
      tooltip: tooltip, // accessibility + long-press hint
      icon: _AnimatedNavIcon(
        iconData: icon,
        selected: false,
        color: cs.onSurfaceVariant,
      ),
      selectedIcon: _AnimatedNavIcon(
        iconData: selectedIcon,
        selected: true,
        color: cs.primary,
      ),
      label: '', // hidden (we render title above)
    );
  }
}

class _TitleLabel extends StatelessWidget {
  const _TitleLabel({
    super.key,
    required this.text,
    required this.color,
    required this.isSmall,
  });
  final String text;
  final Color color;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    // Single line, ellipsis for very long HU labels
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _AnimatedNavIcon extends StatelessWidget {
  const _AnimatedNavIcon({
    required this.iconData,
    required this.selected,
    required this.color,
  });

  final IconData iconData;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Slight scale + opacity lift when selected
    return AnimatedScale(
      scale: selected ? 1.14 : 1.0,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: selected ? 1.0 : 0.85,
        duration: const Duration(milliseconds: 160),
        child: Icon(iconData, size: selected ? 28 : 24, color: color),
      ),
    );
  }
}
