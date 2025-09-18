import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/show_models.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box _box = Hive.box('favorites');

  List<ShowModel> get favorites {
    return _box.values.map((e) {
      final map = Map<String, dynamic>.from(e);
      return ShowModel(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        summary: map['summary'],
        rating: map['rating']?.toDouble(),
      );
    }).toList();
  }

  void toggleFavorite(ShowModel show) {
    if (_box.containsKey(show.id)) {
      _box.delete(show.id);
    } else {
      _box.put(show.id, {
        'id': show.id,
        'name': show.name,
        'image': show.image,
        'summary': show.summary,
        'rating': show.rating,
      });
    }
    notifyListeners();
  }

  bool isFavorite(int id) => _box.containsKey(id);
}
