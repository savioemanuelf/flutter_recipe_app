import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(recipe.image),
            ),

            const SizedBox(height: 16),

            Text(
              recipe.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            Chip(
              label: Text(recipe.category),
            ),

            const SizedBox(height: 24),

            Text(
              "Ingredientes",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            ...recipe.ingredients.map(
              (ingredient) => ListTile(
                dense: true,
                leading: const Icon(Icons.check),
                title: Text(ingredient),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Modo de preparo",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}