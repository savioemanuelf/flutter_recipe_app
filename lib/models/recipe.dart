class Recipe {
  final String id;
  final String name;
  final String category;
  final String image;
  final String instructions;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.instructions,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json["strIngredient$i"];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient);
      }
    }

    return Recipe(
      id: json["idMeal"],
      name: json["strMeal"],
      category: json["strCategory"],
      image: json["strMealThumb"],
      instructions: json["strInstructions"],
      ingredients: ingredients,
    );
  }
}