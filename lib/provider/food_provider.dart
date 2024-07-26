import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:maa_api/model/food.dart';

class FoodProvider extends ChangeNotifier {
  
  List<Food> foods = [];

  List<Food> favouriteFood = [];

  void getFoods() async {
    Response response = await get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/random?limitLicense=true&number=20&apiKey=7a85ed4814064a2a90fb0429a049930d',
      ),
    );

    final mapResponse = jsonDecode(response.body);

    final mapResponseLists = mapResponse['recipes'];

    for (int i = 0; i < mapResponseLists.length; i++) {
      foods.add(Food.fromMap(mapResponseLists[i]));
    }

    notifyListeners();
  }

  void removeFavouriteFoods(int index) {
    favouriteFood.removeAt(index);
    notifyListeners();
  }

  void addHeart(Food food) {
    favouriteFood.add(food);
    notifyListeners();
  }

  void removeHeart(Food food) {
    favouriteFood.remove(food);
    notifyListeners();
  }
}
