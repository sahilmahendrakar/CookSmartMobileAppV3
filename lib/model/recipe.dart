class Recipe{
  String name;
  String imageUrl;
  String sourceUrl;
  int calories;
  List<String> ingredients = List();
  int prepTime;
  List<String> dietLabels = List();
  List<String> healthLabels = List();
  int fat;
  int sugar;
  int protein;
  int servings;

  Recipe.fromJson(Map map){
    Map recipe = map['recipe'];
    this.name = recipe['label'];
    print(this.name);
    this.imageUrl = recipe['image'];
    this.sourceUrl = recipe['url'];
    this.dietLabels = List.castFrom(recipe['dietLabels']);
    this.healthLabels = List.castFrom(recipe['healthLabels']);
    this.ingredients = List.castFrom(recipe['ingredientLines']);
    this.servings = recipe['yield'].round();
    this.calories = (recipe['calories']/recipe['yield']).round();
    //print("${recipe['totalTime']}");
    this.prepTime = recipe['totalTime'].round();
    
    
    try{this.fat = recipe['totalNutrients']['FAT']['quantity'].round();} catch(e){this.fat = 0;}
    // //print("${recipe['totalNutrients']['SUGAR']['quantity']}, rounded: ${recipe['totalNutrients']['SUGAR']['quantity'].round()}");
    try{this.sugar = recipe['totalNutrients']['SUGAR']['quantity'].round();} catch(e){this.sugar = 0;}
    try{this.protein = recipe['totalNutrients']['PROCNT']['quantity'].round();} catch(e){this.protein=0;}
  }
}