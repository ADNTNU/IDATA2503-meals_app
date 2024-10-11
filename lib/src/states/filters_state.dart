import 'package:flutter/material.dart';
import 'package:meals_app/src/models/filter.dart';

/// The initial state for the filters.
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

/// The state for the filters.
class FiltersState with ChangeNotifier {
  final Map<Filter, bool> filters = Map.from(kInitialFilters);

  /// Updates the given filter with the given value.
  void updateFilter(Filter filter, bool value) {
    filters[filter] = value;
    notifyListeners();
  }

  /// Resets the filters to the initial state.
  void resetFilters() {
    filters.clear();
    filters.addAll(kInitialFilters);
    notifyListeners();
  }

  Map<Filter, bool> get selectedFilters => filters;

  bool get glutenFree => filters[Filter.glutenFree]!;
  bool get lactoseFree => filters[Filter.lactoseFree]!;
  bool get vegetarian => filters[Filter.vegetarian]!;
  bool get vegan => filters[Filter.vegan]!;
}
