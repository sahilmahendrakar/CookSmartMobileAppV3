import 'package:cooksmart_v3/custom/left_expansion_tile.dart';
import 'package:cooksmart_v3/model/recipe.dart';
import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  RecipeDetailPage(this.recipe);
  //TODO: called on null because the build context needs to be brought over frwhen the detail page is pushed
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: ListView(
          children: <Widget>[
            Stack(
        children: <Widget>[
          Background(recipe),
          _getTitle(context),
          _getToolbar(context),
        ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Material(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.white,
                    child: Column(
                        children: <Widget>[
                          InfoBar(recipe),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Serves ${recipe.servings == null ? "1 person" : recipe.servings.toString() + " people"}", style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.black54, fontSize: 18.0))
                            ],),
                          Labels(recipe),
                          //Favorite(recipe),
                        ],
                      ))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      //color: Colors.deepOrange[900].withOpacity(0.8),
                      onPressed: () => _launchUrl(),
                      shape: StadiumBorder(),
                  child: Text("Go To Recipe", style: TextStyle(color: Colors.white),),
                )],
                )
              )
          ],
        ),
    );
  }

  _launchUrl() async{
    String url = recipe.sourceUrl;
    if(await canLaunch(url)){
      await launch(url);
    } else {
      print("Could not launch url");
    }
  }

  Widget _getTitle(BuildContext context) {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Material(
              color: Colors.deepOrangeAccent,
              shape: StadiumBorder(),
              // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20.0)),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0 ,6.0, 8.0, 6.0),
                child: Text(recipe.name,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1
                        .copyWith(color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getToolbar(context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        //margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new BackButton(color: Colors.white),
      ),
    );
  }
}

class InfoBar extends StatelessWidget {
  final Recipe recipe;
  InfoBar(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _getSugar(context),
          _getFat(context),
          _getProtein(context),
        ],
      ),
    );
  }

  Widget _getSugar(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Sugar:",
          style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(" ${recipe.sugar == 0.0 ? 'N/A' : recipe.sugar.toString() + "g"}",
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.black54, fontSize: 18.0))
      ],
    );
  }

  Widget _getFat(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Fat:",
          style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.red, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(" ${recipe.fat}g",
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.black54, fontSize: 18.0))
      ],
    );
  }

  Widget _getProtein(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Protein:",
          style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
            " ${recipe.protein == 0.0 ? 'N/A' : recipe.protein.toString() + "g"}",
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.black54, fontSize: 18.0))
      ],
    );
  }
}

class Background extends StatelessWidget {
  final Recipe recipe;

  Background(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 230.0),
              child: Image.network(
                  recipe.imageUrl,
                  fit: BoxFit.cover,
                ),
              // child: Hero(
              //   tag: recipe.imageUrl,
              //   child: Image.network(
              //     recipe.imageUrl,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _getCalories(context),
              SizedBox(height: 16.0),
              _getTime(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getCalories(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+20.0),
      child: Material(
        //elevation: 8.0,
        color: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              topLeft: Radius.circular(15.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "${recipe.calories} Cal",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _getTime() {
    return Material(
      //elevation: 8.0,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.access_time),
            Text(
              " ${recipe.protein == 0.0 ? 'N/A' : recipe.protein.toString() + " min"}",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class Labels extends StatelessWidget {
  final Recipe recipe;
  Labels(this.recipe);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text("Diet", style: TextStyle(fontSize: 20.0)),
          children: _getDietLabels(),
        ),
        ExpansionTile(
          title: Text("Health Restrictions", style: TextStyle(fontSize: 20.0)),
          children: _getHealthLabels(),
        ),
        LeftExpansionTile(
          title: Text("Ingredients", style: TextStyle(fontSize: 20.0)),
          children: _getIngredients(),
        ),
      ],
    );
  }

  List<Widget> _getDietLabels() => recipe.dietLabels.map((diet) => _buildLabel(diet)).toList();

  List<Widget> _getHealthLabels() => recipe.healthLabels.map((health) => _buildLabel(health)).toList();

  List<Widget> _getIngredients() => recipe.ingredients.map((ingredient) => _buildIngredients(ingredient)).toList();

  Widget _buildLabel(String label) {
    return Container(
        margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 16.0),
        alignment: Alignment.centerLeft,
        //color: Colors.blue,
        child: Row(children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          )
        ]));
  }

  Widget _buildIngredients(String ingredient,){
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 16.0),
      alignment: Alignment.centerLeft,
      //color: Colors.blue,
      child: Row(children: <Widget>[
        Expanded(
                  child: Text(
      ingredient,
      style: TextStyle(fontSize: 16.0),
    ),
        )
      ]));
  }
}


class Favorite extends StatelessWidget {
  final Recipe recipe;
  Favorite(this.recipe);

  @override
  Widget build(BuildContext context) {
    final ingredientService = IngredientService.of(context);
    return GestureDetector(
      onTap: () => ingredientService.savedRecipes.add(recipe),
          child: Padding(
        padding: EdgeInsets.all(8.0),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(ingredientService.savedRecipes.contains(recipe) ? Icons.star : Icons.star_border, color: Colors.orange,),
            Text('SAVE',
              style: TextStyle(fontSize: 18.0, color: Colors.deepOrangeAccent),
            ),
          ],
        ),
      ),
    );
  }
}