import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  // Recibimos el shell como argumento
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  // Creamos un método para alternar entre vistas
  void onItemTapped(BuildContext context, int index) {
    /// Alternamos entre vistas mediante el método goBranch, este método
    /// garanriza que se restaure el último estado de navegación para la
    /// rama
    navigationShell.goBranch(
      index,
      // Soporte para ir a la ubicación inicial de la rama.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      elevation: 0,
      onTap: (i) => onItemTapped(context, i),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
