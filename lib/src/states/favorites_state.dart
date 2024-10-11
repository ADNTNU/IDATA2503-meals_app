import 'package:flutter/material.dart';
import 'package:meals_app/src/models/meal.dart';

/// The state for the favorited meals.
class FavoritesState with ChangeNotifier {
  final List<Meal> _favoriteMeals = [];

  List<Meal> get favoriteMeals => _favoriteMeals;

  /// Toggles the favorite status of a meal.
  void toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }

    notifyListeners();
  }

  /// Checks if a meal is favorited.
  bool isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  /// Clears all the favorited meals.
  void clearFavorites() {
    _favoriteMeals.clear();
    notifyListeners();
  }
}
