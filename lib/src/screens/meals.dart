import 'package:flutter/material.dart';
import 'package:meals_app/src/models/meal.dart';
import 'package:meals_app/src/screens/meal_details.dart';
import 'package:meals_app/src/widgets/meal_item.dart';

/// The screen that displays the list of meals.
/// Can be used to display meals in favorites or meals filtered by category.
/// Displays a message if there are no meals to display.
class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  static const routeName = '/meals';

  /// Navigates to the [MealDetailsScreen] when a meal is selected.
  void onMealSelected(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemBuilder: (context, index) => MealItem(
              meal: meals[index],
              onMealSelected: (meal) => onMealSelected(context, meal),
            ),
        itemCount: meals.length);

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text('Uh oh... Nothing here!',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 16),
            Text('Try selecting a different category!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
      ),
      body: content,
    );
  }
}
