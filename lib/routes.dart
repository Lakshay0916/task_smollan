import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_smollan/screens/favourite_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';

import 'screens/details_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainShell(),
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return DetailsScreen(showId: id);
          },
        ),
      ],
    ),
  ],
);

/// MainShell = bottom navigation with 3 tabs
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final _screens = const [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),
    );
  }
}
