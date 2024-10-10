import 'package:flutter/material.dart';
import 'package:meals_app/src/data/dummy_data.dart';
import 'package:meals_app/src/models/category.dart';
import 'package:meals_app/src/models/filter.dart';
import 'package:meals_app/src/screens/meals.dart';
import 'package:meals_app/src/states/filters_state.dart';
import 'package:meals_app/src/widgets/category_grid_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  void _selectCategory(
      BuildContext context, Map<Filter, bool> filters, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) =>
            meal.categories.contains(category.id) &&
            (!filters[Filter.glutenFree]! || meal.isGlutenFree) &&
            (!filters[Filter.lactoseFree]! || meal.isLactoseFree) &&
            (!filters[Filter.vegetarian]! || meal.isVegetarian) &&
            (!filters[Filter.vegan]! || meal.isVegan))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: 'Meals',
            meals: filteredMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<Filter, bool> filters =
        Provider.of<FiltersState>(context).selectedFilters;
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: availableCategories
            .map((category) => CategoryGridItem(
                category: category,
                onSelectCategory: () =>
                    _selectCategory(context, filters, category)))
            .toList());
  }
}
