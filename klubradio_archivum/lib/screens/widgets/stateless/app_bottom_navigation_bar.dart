import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Főoldal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Felfedezés',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download_outlined),
          activeIcon: Icon(Icons.download),
          label: 'Letöltések',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Beállítások',
        ),
      ],
    );
  }
}
