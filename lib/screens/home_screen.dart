import 'package:api_testing_app/screens/posts_screen.dart';
import 'package:api_testing_app/screens/recipe_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Column(
            children: [
              _buildButton(
                  buttonName: "Posts Data", screenWidget: PostsScreen()),
              _buildButton(
                  buttonName: "Recipes ", screenWidget: RecipeScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String buttonName, required Widget screenWidget}) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screenWidget));
        },
        child: Text(buttonName));
  }
}
