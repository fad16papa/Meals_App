import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> dispalyMeals;
  var _loadedInitData = false;

  @override
  //This will load all the objects before rendering the whole widgets in application
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];

      dispalyMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList(); // Get a list of categories where categoryId

      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      dispalyMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: dispalyMeals[index].id,
              title: dispalyMeals[index].title,
              imageUrl: dispalyMeals[index].imageUrl,
              duration: dispalyMeals[index].duration,
              complexity: dispalyMeals[index].complexity,
              affordability: dispalyMeals[index].affordability,
              removeItem: _removeMeal,
            );
          },
          itemCount: dispalyMeals.length,
        ),
      ),
    );
  }
}
