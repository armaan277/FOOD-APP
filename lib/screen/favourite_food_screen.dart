import 'package:flutter/material.dart';
import 'package:maa_api/provider/food_provider.dart';
import 'package:provider/provider.dart';

class FavouriteFood extends StatelessWidget {
  const FavouriteFood({super.key});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<FoodProvider>();
    final providerRead = context.read<FoodProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: providerWatch.favouriteFood.length,
        itemBuilder: (context, index) {
          final product = providerWatch.favouriteFood[index];
          return Card(
            child: ListTile(
              leading: Image.network(product.image),
              title: Text(product.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  providerRead.removeFavouriteFoods(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
