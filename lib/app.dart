import 'package:flutter/material.dart';
import 'package:maa_api/provider/food_provider.dart';
import 'package:maa_api/screen/home_screen.dart';
import 'package:provider/provider.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoodProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomeScreen(title: 'Recipe App'),
      ),
    );
  }
}
