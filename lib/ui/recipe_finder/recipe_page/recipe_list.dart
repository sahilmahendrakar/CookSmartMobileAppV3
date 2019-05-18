import 'package:cooksmart_v3/services/find_recipes.dart';
import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:cooksmart_v3/ui/recipe_finder/recipe_page/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecipeList extends StatefulWidget {
  final context;
  const RecipeList({this.context});
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList>
    with AutomaticKeepAliveClientMixin {
  int count = 9;

  @override
  void didChangeDependencies() {
    count = 9;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final ingredientService = IngredientService.of(context);
    if (ingredientService.ingredients.length > 0) {
      return FutureBuilder(
        future: findRecipesFromApi(
            ingredients: ingredientService.toUrlForm(), 
            diet: ingredientService.diet,
            health: ingredientService.health,
            count: count,
            calorieFrom: ingredientService.calorieFrom,
            calorieTo: ingredientService.calorieTo,
            sort: ingredientService.sort,
            ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("No Connection");
            case ConnectionState.waiting:
              return Center(
                  child: Container(child: CircularProgressIndicator()));
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text("Oops! Something's Wrong!");
              }
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 4.0,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        RecipeCard(snapshot.data[index]),
                    staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                  ),
                  SliverAppBar(
                    backgroundColor: Colors.white.withOpacity(0.0),
                    title: FlatButton(
                       //shape: StadiumBorder(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () => setState(() {
                            count += 6;
                          }),
                      color: Colors.green[600].withOpacity(0.8),
                      child: Text("See More",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    centerTitle: true,
                  ),
                ],
              );
          }
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.arrow_back,
            color: Colors.brown[400].withOpacity(0.5),
          ),
          Text("Add Ingredients",
              style: TextStyle(
                  fontSize: 25.0, color: Colors.brown[400].withOpacity(0.5)))
        ],
      );
    }
  }


  @override
  bool get wantKeepAlive => true;
}


