class Food {
  final String title;
  final String image;
  final int readyInMinutes;

  bool favourite = true;

  Food({
    required this.title,
    required this.image,
    required this.readyInMinutes,
  });

  factory Food.fromMap(Map foodMap) {
    return Food(
      title: foodMap['title'] ?? '',
      image: foodMap['image'],
      readyInMinutes: foodMap['readyInMinutes'],
    );
  }
}
