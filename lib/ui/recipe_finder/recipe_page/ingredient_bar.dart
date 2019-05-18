import 'package:cooksmart_v3/model/ingredient.dart';
import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:flutter/material.dart';

class IngredientBar extends StatefulWidget {
  @override
  IngredientBarState createState() {
    return new IngredientBarState();
  }

  String ingredientsToString(BuildContext context){
    final ingredientService = IngredientService.of(context);
    IngredientList<Ingredient> ingredients = ingredientService.ingredients;
    StringBuffer buffer = StringBuffer();
    for(int i = 0; i < ingredients.length; i++){
      buffer.write(ingredients[i].name);
      if(i+1 < ingredients.length){
        buffer.write(", ");
      }
    }
    return buffer.toString();
  }
}

class IngredientBarState extends State<IngredientBar> with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
     
  }
  @override
  Widget build(BuildContext context) {
    final ingredientService = IngredientService.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
      child: GestureDetector(
              child: Text(ingredientService.ingredients.length > 0 ? "Ingredients: ${widget.ingredientsToString(context)}" : "Find Recipes Here!", style: TextStyle(
              fontSize: 25.0, color: Colors.brown[400].withOpacity(0.5),)),
      ),
    );
    
  }
}