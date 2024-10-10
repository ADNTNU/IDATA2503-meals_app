import 'package:flutter/material.dart';
import 'package:meals_app/src/models/filter.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class FiltersState with ChangeNotifier {
  final Map<Filter, bool> filters = Map.from(kInitialFilters);

  void updateFilter(Filter filter, bool value) {
    filters[filter] = value;
    notifyListeners();
  }

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
