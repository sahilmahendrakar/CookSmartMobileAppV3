import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:cooksmart_v3/ui/recipe_finder/ingredient_page.dart/ingredient_form.dart';
import 'package:cooksmart_v3/ui/recipe_finder/ingredient_page.dart/ingredient_list.dart';
import 'package:flutter/material.dart';

class IngredientPage extends StatelessWidget {
  const IngredientPage();

  @override
  Widget build(BuildContext context) {
    final ingredientService = IngredientService.of(context);
    return Container(
      child: Column(children: <Widget>[
        ingredientService.ingredients.length > 0 ? Container() : Header(),
        Expanded(child: AnimatedIngredientList(context, ingredientService)),
        IngredientForm(
          elevation: 2.0,
        ),
    ]));
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "Add Ingredients",
        style: TextStyle(
            fontSize: 25.0, color: Colors.brown[400].withOpacity(0.5)),
      ),
    );
  }
}
