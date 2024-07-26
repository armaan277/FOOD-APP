import 'package:maa_api/model/cooking_steps.dart';

class Food {
  final String title;
  final String image;
  final int readyInMinutes;
  final List<CookingSteps> analyzedInstructions;

  bool favourite = true;

  Food({
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.analyzedInstructions,
  });

  factory Food.fromMap(Map foodMap) {
    return Food(
      title: foodMap['title'] ?? '',
      image: foodMap['image'] ?? '',
      readyInMinutes: foodMap['readyInMinutes'] ?? 0,
      analyzedInstructions:
          (foodMap["analyzedInstructions"][0]["steps"] as List)
              .map((e) => CookingSteps.fromMap(e))
              .toList(),
    );
  }
}