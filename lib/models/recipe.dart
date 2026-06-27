class Recipe {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["idMeal"],
      name: json["strMeal"],
      category: json["strCategory"],
      imageUrl: json["strMealThumb"],
      instructions: json["strInstructions"],
    );
  }
}
