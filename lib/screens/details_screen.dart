import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/show_models.dart';
import '../providers/favourites_provider.dart';

class DetailsScreen extends StatefulWidget {
  final int showId;
  const DetailsScreen({super.key, required this.showId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ShowModel? show;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadShow();
  }

  Future<void> _loadShow() async {
    final api = ApiService();
    final data = await api.fetchShowDetails(widget.showId);
    setState(() {
      show = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isFav = favoritesProvider.isFavorite(show!.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFbb4531),

        title: Text(show!.name,style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.black : Colors.black,
            ),
            onPressed: () {
              favoritesProvider.toggleFavorite(show!);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (show!.image != null)
              Hero(
                tag: "show_${show!.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    show!.image!,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Title
            Text(
              show!.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            // Genres
            if (show!.genres.isNotEmpty)
              Wrap(
                spacing: 8,
                children: show!.genres
                    .map((genre) => Chip(label: Text(genre)))
                    .toList(),
              ),

            const SizedBox(height: 8),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  show!.rating != null && show!.rating! > 0
                      ? show!.rating!.toString()
                      : "N/A",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Summary
            Text(
              show!.summary?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                  "No summary available",
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
