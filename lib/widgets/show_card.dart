import 'package:flutter/material.dart';
import '../models/show_models.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  final VoidCallback onTap;

  const ShowCard({super.key, required this.show, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            if (show.image != null)
              Hero(
                tag: "show_${show.id}",
                child: Image.network(
                  show.image!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                show.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
