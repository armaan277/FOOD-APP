import 'package:flutter/material.dart';
import 'package:maa_api/food.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Food food;
  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: Column(
        children: [
          Image.network(food.image),
          Text('Steps'),
        ],
      ),
    );
  }
}
