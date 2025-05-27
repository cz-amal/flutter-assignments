import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';
import 'meals.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals =
        widget.availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder:
          (context, child) => SlideTransition(
            position: Tween(begin: Offset(0, 0.0), end: Offset(0, 0)).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.bounceIn,
              ),
            ),
            child: child,
          ),
    );
  }
}
