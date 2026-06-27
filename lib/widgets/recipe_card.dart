import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {

  final Recipe recipe;

  const RecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(8),

      child: ListTile(

        leading: Image.network(
          recipe.imageUrl,
          width: 60,
          fit: BoxFit.cover,
        ),

        title: Text(recipe.name),

        subtitle: Text(recipe.category),
      ),
    );
  }
}