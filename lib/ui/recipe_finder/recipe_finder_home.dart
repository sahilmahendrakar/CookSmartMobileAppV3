import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:cooksmart_v3/ui/recipe_finder/ingredient_page.dart/ingredient_page.dart';
import 'package:cooksmart_v3/ui/recipe_finder/recipe_page/recipe_page.dart';
import 'package:cooksmart_v3/ui/recipe_finder/sort/header.dart';
import 'package:cooksmart_v3/ui/recipe_finder/top.dart';
import 'package:flutter/material.dart';

class RecipeFinderHome extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {

    return IngredientService(
        child: Scaffold(
            appBar: AppBar(
              elevation: 3.0,
              title: Text("CookSmart"),
              backgroundColor: Colors.deepOrange[400],
              actions: <Widget>[
                SortHeader(pageController: pageController, child: SortButton()),
              ],
            ),
            body: RecipeFinderPageView(
              pageController: pageController,
              children: <Widget>[
                IngredientPage(),
                const RecipePage(),
              ],
            )
            // IngredientHome(update),
            // RecipePage(),
            ));
  }
  
}

class RecipeFinderPageView extends StatefulWidget {
  final List<Widget> children;
  final PageController pageController;

  RecipeFinderPageView({this.children, this.pageController});

  @override
  _RecipeFinderPageViewState createState() => _RecipeFinderPageViewState();
}

class _RecipeFinderPageViewState extends State<RecipeFinderPageView> {

  @override
  void initState(){
    super.initState();
    widget.pageController.addListener(() => setState((){}));
  }

  @override
  Widget build(BuildContext context) {
    final ingredientService = IngredientService.of(context);
    return Stack(
      children: <Widget>[
        PageView(controller: widget.pageController, children: widget.children),
        Top(ingredientService.controller, ingredientService),
      ],
    );
  }

  @override
  void dispose(){
    widget.pageController.removeListener(() => setState((){}));
    super.dispose();
  }
}
