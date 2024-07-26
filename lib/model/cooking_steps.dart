import 'package:maa_api/model/ingredients.dart';

class CookingSteps {
  final String step;
  final List<Ingredients> ingredients;

  const CookingSteps({
    required this.step,
    required this.ingredients,
  });

  factory CookingSteps.fromMap(Map foodCookingSteps) {
    return CookingSteps(
      step: foodCookingSteps['step'] ?? '',
      ingredients: List<Ingredients>.from(
        (foodCookingSteps['ingredients'] as List).map<Ingredients>(
          (x) => Ingredients.fromMap(x),
        ),
      ),
    );
  }
}
