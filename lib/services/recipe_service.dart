import 'dart:convert';
import 'package:flutter_recipe_app/exceptions/base_exception.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService {
  final String baseUrl =
    "https://www.themealdb.com/api/json/v1/1";

  Future<List<Recipe>> fetchRecipes() async {

    final response = await http.get(
      Uri.parse("$baseUrl/search.php?s="),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final meals = json["meals"] as List;

      return meals
          .map((meal) => Recipe.fromJson(meal))
          .toList();
    }

    throw Exception("Erro ao carregar receitas");
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search.php?s=$query")
    );

    if(response.statusCode == 200) { 

        final json = jsonDecode(response.body);

        final meals = json["meals"];
        if(meals == null) {
          return [];
        }

        return (meals as List)
            .map((meal) => Recipe.fromJson(meal))
            .toList();
    }

    throw BaseException(
      message: "Erro ao pesquisar receitas",
      statusCode: response.statusCode,
    );
  }
}