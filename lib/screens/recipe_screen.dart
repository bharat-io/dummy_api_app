import 'package:api_testing_app/api_service.dart';
import 'package:api_testing_app/model/recipe_model.dart';
import 'package:api_testing_app/screens/recipe_detail_screen.dart';
import 'package:api_testing_app/util/app_contant.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text("Recipe Data")),
      body: Column(
        children: [
          FutureBuilder(
              future: apiService.getData<RecipeModel>(
                url: "${AppContant.baseUrl}/recipes",
                fromjson: (json) => RecipeModel.fromjson(json),
              ),
              builder: (context, AsyncSnapshot<RecipeModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.hasError}"),
                  );
                } else if (snapshot.hasData) {
                  final recipesList = snapshot.data!.recipes;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: recipesList.length,
                      itemBuilder: (context, index) {
                        final recipe = recipesList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      recipe: recipe,
                                    )));
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    recipe.image!,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    errorBuilder: (_, __, ___) => Container(
                                      height: 180,
                                      color: Colors.grey[300],
                                      alignment: Alignment.center,
                                      child: Icon(Icons.broken_image, size: 50),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipe.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.orange, size: 18),
                                          Text(
                                              '${recipe.rating} (${recipe.reviewCount} reviews)'),
                                          Spacer(),
                                          Text(
                                              '${recipe.cuisine} • ${recipe.difficulty}'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                          'Calories: ${recipe.caloriesPerServing} kcal'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              })
        ],
      ),
    );
  }
}
