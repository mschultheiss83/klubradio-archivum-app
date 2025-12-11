import 'package:flutter/material.dart';
// import 'package:klubradio_archivum/l10n/app_localizations.dart'; // Removed

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!; // Removed
    final cs = Theme.of(context).colorScheme;

    final double w = MediaQuery.of(context).size.width;
    final bool isSmall = w < 600;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant.withAlpha((255 * 0.5).round()),
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
                    text: destinations[currentIndex].tooltip ?? '', // Use tooltip for label
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
                indicatorColor: cs.primary.withAlpha((255 * 0.12).round()),
                labelBehavior: NavigationDestinationLabelBehavior
                    .alwaysHide, // we show label above
                destinations: destinations, // Use passed destinations
              ),
            ],
          ),
        ),
      ),
    );
  }

  static NavigationDestination buildDestination(
    IconData icon,
    IconData selectedIcon,
    String tooltip) {
    return NavigationDestination(
      tooltip: tooltip, // accessibility + long-press hint
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon),
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

