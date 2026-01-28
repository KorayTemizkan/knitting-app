import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
       
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
        ),

        child: NavigationBar(
          
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,

          destinations: [
            _menuItem(
              context,

              index: 0,
              currentIndex: navigationShell.currentIndex,
              label: 'Ana Sayfa',
              icon: Icons.home,
            ),

            _menuItem(
              context,

              index: 1,
              currentIndex: navigationShell.currentIndex,
              label: 'Eğitim',
              icon: Icons.school,
            ),

            _menuItem(
              context,

              index: 2,
              currentIndex: navigationShell.currentIndex,
              label: 'Topluluk',
              icon: Icons.groups,
            ),

            _menuItem(
              context,

              index: 3,
              currentIndex: navigationShell.currentIndex,
              label: 'Profil',
              icon: Icons.account_circle,
            ),
            
          ]
        ),
      ),
    );
  }


  Widget _menuItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon,
      ),
      label: label,
    );
  }
}
