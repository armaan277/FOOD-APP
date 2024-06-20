import 'package:flutter/material.dart';
import 'package:maa_api/favourite_food.dart';
import 'package:maa_api/food_details_screen.dart';
import 'package:maa_api/food_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FoodProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Recipe App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool favouriteFood = true;
  @override
  void initState() {
    context.read<FoodProvider>().getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<FoodProvider>();
    final providerRead = context.read<FoodProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FavouriteFood();
              }));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
          final foodWatch = providerWatch.foods[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35),
                  BlendMode.multiply,
                ),
                image: NetworkImage(foodWatch.image),
                fit: BoxFit.cover,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodDetailsScreen(food: foodWatch,);
                }));
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      foodWatch.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: foodWatch.favourite
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              foodWatch.favourite = false;
                              providerRead.favouriteFoods(foodWatch);
                              setState(() {});
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              foodWatch.favourite = true;
                              setState(() {});
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
                            Icon(
                              Icons.alarm,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${foodWatch.readyInMinutes} minutes',
                              style: TextStyle(
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

// Card(
//   child: ListTile(
//     leading: Image.network(providerWatch.foods[index].image),
//     title: Text(
//       providerWatch.foods[index].readyInMinutes.toString(),
//     ),
//   ),
// );
