import 'package:flutter/material.dart';
import 'package:meals_app/src/models/meal.dart';
import 'package:meals_app/src/models/tab_screens.dart';
import 'package:meals_app/src/screens/categories.dart';
import 'package:meals_app/src/screens/filters.dart';
import 'package:meals_app/src/screens/meals.dart';
import 'package:meals_app/src/states/favorites_state.dart';
import 'package:meals_app/src/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

enum Tabs { categories, favorites }

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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  Tabs _selectedTab = Tabs.categories;

  void _setTab(int tabIndex) {
    setState(() {
      _selectedTab = Tabs.values[tabIndex];
    });
  }

  void _setScreen(Screens screen) {
    Navigator.of(context).pop();
    if (screen == Screens.filters) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals =
        Provider.of<FavoritesState>(context).favoriteMeals;

    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Categories';

    if (_selectedTab == Tabs.favorites) {
      activePage = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
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
