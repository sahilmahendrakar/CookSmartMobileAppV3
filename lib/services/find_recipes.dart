import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cooksmart_v3/model/recipe.dart';

Future<List<Recipe>> findRecipesFromApi({String ingredients, String diet, String health, int count, int calorieTo, int calorieFrom, String sort}) async{
  List<Recipe> recipes = List();
  count = count ?? 9;
  diet = diet != null && diet != "none" ? "&diet=$diet" : "";
  health = health != null && health != "none" ? "&health=$health" : "";
  print(calorieTo);
  String calories = calorieTo != null ? "&calories=${calorieFrom != null ? calorieFrom : 0}-$calorieTo" : ""; 
  String url = "https://api.edamam.com/search?q=$ingredients&app_id=79cd177e&app_key=3f934490cec833b0a1d482e7390a279f&from=0&to=$count$diet$health$calories";
  print("request: $url");
  http.Response response = await http.get(url);
  List hits = json.decode(response.body)['hits'];
  hits.forEach((recipe) => recipes.add(Recipe.fromJson(recipe)));
  recipes = _sortRecipes(recipes, sort);
  return recipes;
}

List<Recipe> _sortRecipes(List<Recipe> recipes, String sort){
  if(sort == "cal"){
    recipes.sort((a, b) => a.calories.compareTo(b.calories));
  }
  else if(sort == "fat"){
    recipes.sort((a, b) => a.fat.compareTo(b.fat));
  }

  return recipes;
}