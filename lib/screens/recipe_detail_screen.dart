import 'package:api_testing_app/model/recipe_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Recipes recipe;

  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name ?? 'Recipe Detail'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe.image!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              recipe.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _infoChip('Cuisine: ${recipe.cuisine}'),
                _infoChip('Difficulty: ${recipe.difficulty}'),
                _infoChip('Calories: ${recipe.caloriesPerServing} kcal'),
                _infoChip('Prep: ${recipe.prepTimeMinutes} min'),
                _infoChip('Cook: ${recipe.cookTimeMinutes} min'),
                _infoChip('Servings: ${recipe.servings}'),
              ],
            ),
            SizedBox(height: 16),
            _sectionTitle('Ingredients'),
            ...?recipe.ingredients.map((i) => _bulletItem(i)),
            SizedBox(height: 16),
            _sectionTitle('Instructions'),
            ...recipe.instructions.asMap().entries.map((entry) {
              final stepNum = entry.key + 1;
              final text = entry.value;
              return _numberedStep(stepNum, text);
            }),
            if (recipe.tags.isNotEmpty) ...[
              SizedBox(height: 16),
              _sectionTitle('Tags'),
              Wrap(
                spacing: 8,
                children:
                    recipe.tags.map((tag) => Chip(label: Text(tag))).toList(),
              )
            ],
            if (recipe.mealType.isNotEmpty) ...[
              SizedBox(height: 16),
              _sectionTitle('Meal Type'),
              Wrap(
                spacing: 8,
                children: recipe.mealType!
                    .map((type) => Chip(label: Text(type)))
                    .toList(),
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String label) => Chip(
        label: Text(label, style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.green.shade50,
      );

  Widget _sectionTitle(String title) => Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      );

  Widget _bulletItem(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• "),
            Expanded(child: Text(text)),
          ],
        ),
      );

  Widget _numberedStep(int step, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$step. ', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(child: Text(text)),
          ],
        ),
      );
}
