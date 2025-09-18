import 'package:dio/dio.dart';
import '../models/show_models.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.tvmaze.com"));

  // Get all shows
  Future<List<ShowModel>> fetchAllShows() async {
    final response = await _dio.get("/shows");
    return (response.data as List)
        .map((json) => ShowModel.fromJson(json))
        .toList();
  }

  // Trending = top rated
  Future<List<ShowModel>> fetchTrendingShows() async {
    final shows = await fetchAllShows();
    shows.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    return shows.take(20).toList();
  }

  // Popular = shows with more complete data
  Future<List<ShowModel>> fetchPopularShows() async {
    final shows = await fetchAllShows();
    return shows.where((s) => s.image != null && s.summary != null).take(20).toList();
  }

  // Upcoming = shows with future premier date
  Future<List<ShowModel>> fetchUpcomingShows() async {
    final now = DateTime.now();
    final futureDate = now.add(const Duration(days: 7)); // 1 week ahead
    final dateString = futureDate.toIso8601String().split('T').first;

    final response = await _dio.get("/schedule", queryParameters: {
      "country": "US",
      "date": dateString,
    });

    return (response.data as List)
        .map((json) => ShowModel.fromJson(json['show']))
        .toList();
  }

  Future<List<ShowModel>> fetchShowsPage(int page) async {
    final response = await _dio.get("/shows", queryParameters: {"page": page});
    return (response.data as List)
        .map((json) => ShowModel.fromJson(json))
        .toList();
  }



  // 🔹 Search shows by query
  Future<List<ShowModel>> searchShows(String query) async {
    final response = await _dio.get("/search/shows?q=$query");
    return (response.data as List)
        .map((json) => ShowModel.fromJson(json['show']))
        .toList();
  }

  // 🔹 Fetch details of one show
  Future<ShowModel> fetchShowDetails(int id) async {
    final response = await _dio.get("/shows/$id");
    return ShowModel.fromJson(response.data);
  }

}
