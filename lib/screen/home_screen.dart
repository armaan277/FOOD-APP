import 'package:flutter/material.dart';
import 'package:maa_api/provider/food_provider.dart';
import 'package:maa_api/screen/favourite_food_screen.dart';
import 'package:maa_api/screen/food_details_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<FoodProvider>().getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<FoodProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const FavouriteFood();
                  },
                ),
              );
            },
          ),
        const  Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Recipes',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: providerWatch.foods.length,
        itemBuilder: (context, index) {
          final food = providerWatch.foods[index];
          final answer = providerWatch.favouriteFood.contains(food);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.40),
                  BlendMode.multiply,
                ),
                image: NetworkImage(food.image),
                fit: BoxFit.cover,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FoodDetailsScreen(
                        food: food,
                      );
                    },
                  ),
                );
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        food.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        answer ? Icons.favorite : Icons.favorite_border,
                        size: 30,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        answer
                            ? context.read<FoodProvider>().removeHeart(food)
                            : context.read<FoodProvider>().addHeart(food);
                      },
                    ),
                  ),
                  Positioned(
                    left: 212,
                    top: 148,
                    child: Container(
                      height: 45,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.black.withOpacity(0.40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                           const Icon(
                              Icons.alarm,
                              color: Colors.amber,
                            ),
                           const SizedBox(width: 10),
                            Text(
                              '${food.readyInMinutes} minutes',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
