import 'package:flutter/material.dart';
import 'package:meals_app/src/data/dummy_data.dart';
import 'package:meals_app/src/models/filter.dart';
import 'package:meals_app/src/models/meal.dart';
import 'package:meals_app/src/models/tab_screens.dart';
import 'package:meals_app/src/screens/categories.dart';
import 'package:meals_app/src/screens/filters.dart';
import 'package:meals_app/src/screens/meal_details.dart';
import 'package:meals_app/src/screens/meals.dart';
import 'package:meals_app/src/states/favorites_state.dart';
import 'package:meals_app/src/states/filters_state.dart';
import 'package:meals_app/src/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

/// Enum representing the tabs in the app.
enum Tabs { categories, favorites }

/// Extension on [Tabs] to get the index of the tab.
extension TabsExtension on Tabs {
  int get index {
    switch (this) {
      case Tabs.categories:
        return 0;
      case Tabs.favorites:
        return 1;
    }
  }
}

/// The screen that displays the main tabs in the app.
/// Allows the user to switch between the categories and favorites tabs.
/// Also allows the user to open the filters screen and select a random meal.
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

/// The state for the [TabsScreen].
class _TabsScreenState extends State<TabsScreen> {
  Tabs _selectedTab = Tabs.categories;

  /// Sets the selected tab based on the index.
  void _setTab(int tabIndex) {
    setState(() {
      _selectedTab = Tabs.values[tabIndex];
    });
  }

  /// Sets the screen based on the selected screen.
  void _setScreen(Screens screen) {
    Navigator.of(context).pop();
    if (screen == Screens.filters) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const FiltersScreen()));
    }
  }

  /// Opens a random meal based on the selected filters.
  void _openRandomMeal(BuildContext context, Map<Filter, bool> filters) {
    List<Meal> filteredMeals = dummyMeals
        .where((meal) =>
            (!filters[Filter.glutenFree]! || meal.isGlutenFree) &&
            (!filters[Filter.lactoseFree]! || meal.isLactoseFree) &&
            (!filters[Filter.vegetarian]! || meal.isVegetarian) &&
            (!filters[Filter.vegan]! || meal.isVegan))
        .toList();
    filteredMeals.shuffle();

    if (filteredMeals.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No meals available with the current filters.'),
        ),
      );
      return;
    }

    Meal randomMeal = filteredMeals.first;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(meal: randomMeal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals =
        Provider.of<FavoritesState>(context).favoriteMeals;
    Map<Filter, bool> filters = Provider.of<FiltersState>(context).filters;

    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Categories';

    if (_selectedTab == Tabs.favorites) {
      activePage = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () => _openRandomMeal(context, filters),
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setTab,
        currentIndex: _selectedTab.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
