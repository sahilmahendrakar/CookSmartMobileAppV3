import 'package:cooksmart_v3/ui/recipe_finder/recipe_page/ingredient_bar.dart';
import 'package:cooksmart_v3/ui/recipe_finder/recipe_page/recipe_list.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {

  const RecipePage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IngredientBar(),
        Expanded(child: RecipeList()),
      ],
    );
  }
}