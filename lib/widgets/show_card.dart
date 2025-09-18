import 'package:flutter/material.dart';
import '../models/show_models.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  final VoidCallback onTap;

  const ShowCard({super.key, required this.show, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, // 3% of screen width
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (show.image != null)
              Hero(
                tag: "show_${show.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(screenWidth * 0.03)),
                  child: Image.network(
                    show.image!,
                    width: double.infinity,
                    height: screenWidth * 0.5, // responsive height
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Text(
                show.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045, // responsive font
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
