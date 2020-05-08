import 'package:flutter/foundation.dart';

// enum Complexity {
//   Simple,
//   Challenging,
//   Hard,
// }

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<dynamic> categories;
  final String title;
  final String imageUrl;
  final List<dynamic> ingredients;
  final List<dynamic> steps;
  final int duration;
  final String complexity;
  final String affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
  });
  factory Meal.fromMap(Map<dynamic, dynamic> doc) {
    return Meal(
      id: doc['id'],
      categories: doc['categories'],
      title: doc['title'],
      imageUrl: doc['imageUrl'],
      ingredients: doc['ingredients'],
      steps: doc['steps'],
      duration: doc['duration'],
      complexity: doc['complexity'],
      affordability: doc['affordability'],
      isGlutenFree: doc['isGlutenFree'],
      isLactoseFree: doc['isLactoseFree'],
      isVegan: doc['isVegan'],
      isVegetarian: doc['isVegetarian'],
    );
  }
  Map<String, dynamic> toMap(Meal meal) {
    return {
      'id': meal.id,
      'categories': meal.categories,
      'title': meal.title,
      'imageUrl': meal.imageUrl,
      'ingredients': meal.ingredients,
      'steps': meal.steps,
      'duration': meal.duration,
      'complexity': meal.complexity.toString(),
      'affordability': meal.affordability.toString(),
      'isGlutenFree': meal.isGlutenFree,
      'isLactoseFree': meal.isLactoseFree,
      'isVegan': meal.isVegan,
      'isVegetarian': meal.isVegetarian,
    };
  }
}
