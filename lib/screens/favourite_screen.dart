import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favourites_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/show_card.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites ❤️",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xFFbb4531),

        centerTitle: true,
      actions: [
        IconButton(
        icon: Icon(
          Provider.of<ThemeProvider>(context).isDark
              ? Icons.dark_mode
              : Icons.light_mode,
        ),
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
      ),],),

      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final show = favorites[index];
          return ShowCard(
            show: show,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(showId: show.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
