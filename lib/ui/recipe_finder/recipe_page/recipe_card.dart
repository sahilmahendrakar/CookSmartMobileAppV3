import 'package:cooksmart_v3/model/recipe.dart';
import 'package:cooksmart_v3/page_transitions.dart/fade_route.dart';
import 'package:cooksmart_v3/ui/recipe_finder/recipe_detail/recipe_detail_page.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  RecipeCard(this.recipe);

  @override
  RecipeCardState createState() {
    return new RecipeCardState();
  }
}

class RecipeCardState extends State<RecipeCard> with 
TickerProviderStateMixin<RecipeCard>
{
  AnimationController controller;
  AnimationController fadeController;
  Animation<double> elevation;
  Animation<double> size; 
  Animation<double> opacity;
  Image _image;
  bool loading = true;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    _image = new Image.network(widget.recipe.imageUrl);
    _image.image.resolve(ImageConfiguration()).addListener((_, __) {
      if (mounted)
        setState(() {
          loading = false;
        });
    });
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    fadeController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    elevation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    size = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.elasticOut,
    ));
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      fadeController.forward();
    }
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return FadeTransition(
            opacity: opacity,
            child: ScaleTransition(
              scale: size,
              child: GestureDetector(
                onTap: () {
                  if (controller.status == AnimationStatus.completed) {
                    controller.reverse();
                    selected = false;
                  } else {
                    controller.forward();
                    selected = true;
                  }
                },
                onLongPress: () => Navigator.of(context).push(FadeRoute(RecipeDetailPage(widget.recipe))),
                child: Card(
                  elevation: elevation.value * 3.0 + 2.0,
                  child: Column(
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Hero(
                          tag: widget.recipe.imageUrl,
                          child: _image
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0)),
                                  color: Colors.deepOrangeAccent),
                              //color: Colors.deepOrangeAccent,
                              padding: EdgeInsets.all(4.0),
                              //color: Colors.deepOrangeAccent.withOpacity(0.7),
                              child: Text(
                                "Cal: ${widget.recipe.calories}",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ]),
                      // FadeInImage.memoryNetwork(
                      // placeholder: kTransparentImage,
                      // image: widget.recipe.imageUrl),
                      AnimatedCrossFade(
                          duration: Duration(milliseconds: 300),
                          crossFadeState: selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          firstCurve: Curves.fastOutSlowIn,
                          secondCurve: Curves.fastOutSlowIn,
                          sizeCurve: Curves.fastOutSlowIn,
                          firstChild: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 4.0),
                                  child: Text(
                                    widget.recipe.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.subhead
                                  ),
                                )),
                              ]),
                          secondChild: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 0.0),
                                  child: Text(
                                    widget.recipe.name,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subhead,
                                    
                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                                  child: Text(
                                    "Fat: ${widget.recipe.fat}g",
                                    style: Theme.of(context).textTheme.caption
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 8.0),
                                  child: Text(
                                "Prep Time: ${widget.recipe.prepTime == 0.0 ? 'N/A' : widget.recipe.prepTime.toString() + "min"}",
                                  style: Theme.of(context).textTheme.caption
                                  )
                                )
                              ])),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
    void dispose() {
      controller.dispose();
      fadeController.dispose();
      super.dispose();
    }

}