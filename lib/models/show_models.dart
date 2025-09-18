class ShowModel {
  final int id;
  final String name;
  final String? image;
  final String? summary;
  final double? rating;
  final List<String> genres;

  ShowModel({
    required this.id,
    required this.name,
    this.image,
    this.summary,
    this.rating,
    this.genres = const [],
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image']?['medium'],
      summary: json['summary'],
      rating: (json['rating']?['average'] ?? 0).toDouble(),
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}
