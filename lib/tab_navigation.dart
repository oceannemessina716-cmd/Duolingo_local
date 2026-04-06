import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabNavigation extends StatelessWidget {
  const TabNavigation({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('TabNavigation'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed, // Use fixed if you have 4+ items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          navigationShell.goBranch(
            index,
            // Supports navigating to the initial location of the branch
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
