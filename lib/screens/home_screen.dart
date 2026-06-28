import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/exceptions/base_exception.dart';
import 'package:flutter_recipe_app/models/recipe.dart';
import 'package:flutter_recipe_app/screens/recipe_details_screen.dart';
import 'package:flutter_recipe_app/services/recipe_service.dart';
import 'package:flutter_recipe_app/widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeService recipeService = RecipeService();
  late Future<List<Recipe>> recipes;

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    recipes = recipeService.fetchRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _executarBusca() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      recipes = recipeService.searchRecipes(
        _searchController.text.trim(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Pesquisar receita",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _executarBusca,
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Informe uma receita";
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _executarBusca(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: recipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Center(
                    child: Text(
                      error is BaseException
                          ? error.message
                          : "Erro ao carregar receitas",
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Nenhuma receita encontrada."),
                  );
                }

                final recipesList = snapshot.data!;

                return ListView.builder(
                  itemCount: recipesList.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      recipe: recipesList[index],
                      onTap: () => {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => (
                            RecipeDetailsScreen(recipe: recipesList[index],
                          )))
                        )},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}