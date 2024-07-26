class Ingredients {
  final int id;
  final String name;
  final String image;

  const Ingredients({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Ingredients.fromMap(Map foodIngredients) {
    return Ingredients(
      id: foodIngredients['id'] ?? 0,
      name: foodIngredients['name'] ?? '',
      image: foodIngredients['image'] ?? '',
    );
  }
}
