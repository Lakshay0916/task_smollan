import 'package:flutter/material.dart';
import '../models/show_models.dart';
import '../services/api_service.dart';
import '../utils/enums.dart';

class ShowProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  // Home shows
  List<ShowModel> homeShows = [];
  UIState homeState = UIState.loading;
  FilterCategory currentFilter = FilterCategory.trending;

  // Pagination
  int _currentPage = 0;
  bool isLoadingMore = false;
  bool hasMore = true;

  // Search
  List<ShowModel> searchResults = [];
  UIState searchState = UIState.success;

  /// Load home shows
  Future<void> loadHomeShows([FilterCategory filter = FilterCategory.trending]) async {
    try {
      homeState = UIState.loading;
      notifyListeners();

      switch (filter) {
        case FilterCategory.trending:
          homeShows = await _api.fetchTrendingShows();
          break;
        case FilterCategory.popular:
          homeShows = await _api.fetchPopularShows();
          break;
        case FilterCategory.upcoming:
          homeShows = await _api.fetchUpcomingShows();
          break;
      }

      currentFilter = filter;
      homeState = UIState.success;

      // Reset pagination only for trending (all shows)
      if (filter == FilterCategory.trending) {
        _currentPage = 1;
        hasMore = true;
      }
    } catch (_) {
      homeState = UIState.error;
    }
    notifyListeners();
  }

  /// Infinite scrolling for trending shows
  Future<void> loadNextPage() async {
    if (isLoadingMore || !hasMore || currentFilter != FilterCategory.trending) {
      return;
    }

    try {
      isLoadingMore = true;
      notifyListeners();

      final newShows = await _api.fetchShowsPage(_currentPage);

      if (newShows.isEmpty) {
        hasMore = false;
      } else {
        homeShows.addAll(newShows);
        _currentPage++;
      }
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  /// Search shows
  Future<void> searchShows(String query) async {
    try {
      searchState = UIState.loading;
      notifyListeners();

      searchResults = await _api.searchShows(query);

      searchState = UIState.success;
    } catch (_) {
      searchState = UIState.error;
    }
    notifyListeners();
  }
}
