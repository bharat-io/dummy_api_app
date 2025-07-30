class RecipeModel {
  int limit;
  List<Recipes> recipes;
  int skip;
  int total;
  RecipeModel(
      {required this.limit,
      required this.recipes,
      required this.skip,
      required this.total});

  factory RecipeModel.fromjson(Map<String, dynamic> json) {
    List<Recipes> recipesList = [];
    // alternate approch
    // json["recipes"].map((r) => Recipes.fromJson(r)).toList();
    List recipeJsonList = json["recipes"];
    for (int i = 0; i < recipeJsonList.length; i++) {
      Recipes eachRecipe = Recipes.fromJson(recipeJsonList[i]);
      recipesList.add(eachRecipe);
    }

    return RecipeModel(
        limit: json["limit"],
        recipes: recipesList,
        skip: json["skip"],
        total: json["total"]);
  }
}

class Recipes {
  int? id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  String difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> tags;
  int userId;
  String image;
  num rating;
  int reviewCount;
  List<String> mealType;
  Recipes({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.mealType,
    required this.reviewCount,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return Recipes(
      id: json["id"] ?? 0,
      name: json["name"] ?? "No Name",
      ingredients: List<String>.from(json["ingredients"] ?? []),
      instructions: List<String>.from(json["instructions"] ?? []),
      prepTimeMinutes: json["prepTimeMinutes"] ?? 0,
      cookTimeMinutes: json["cookTimeMinutes"] ?? 0,
      servings: json["servings"] ?? 0,
      difficulty: json["difficulty"] ?? "Unknown",
      cuisine: json["cuisine"] ?? "Unknown",
      caloriesPerServing: json["caloriesPerServing"] ?? 0,
      tags: List<String>.from(json["tags"] ?? []),
      userId: json["userId"] ?? 0,
      image: json["image"] ?? "",
      rating: json["rating"] ?? 0,
      mealType: List<String>.from(json["mealType"] ?? []),
      reviewCount: json["reviewCount"] ?? 0,
    );
  }
}
