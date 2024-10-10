import 'package:flutter/material.dart';
import 'package:meals_app/src/models/meal.dart';

class FavoritesState with ChangeNotifier {
  final List<Meal> _favoriteMeals = [];

  List<Meal> get favoriteMeals => _favoriteMeals;

  void toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }

    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  void clearFavorites() {
    _favoriteMeals.clear();
    notifyListeners();
  }
}
