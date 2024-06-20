import 'package:flutter/material.dart';
import 'package:maa_api/food_provider.dart';
import 'package:provider/provider.dart';

class FavouriteFood extends StatelessWidget {
  const FavouriteFood({super.key});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<FoodProvider>();
    final providerRead = context.read<FoodProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: providerWatch.favouriteFood.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(providerWatch.favouriteFood[index].image),
              title: Text(providerWatch.favouriteFood[index].title),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  providerRead.removeFavouriteFoods(index);
                  providerRead.food(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
