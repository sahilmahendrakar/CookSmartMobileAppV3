import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:cooksmart_v3/ui/recipe_finder/sort/sort_alert.dart';
import 'package:flutter/material.dart';

class SortHeader extends StatefulWidget {
  final Widget child;
  final PageController pageController;
  SortHeader({this.child, this.pageController});
  @override
  _SortHeaderState createState() => _SortHeaderState();
}

class _SortHeaderState extends State<SortHeader> with TickerProviderStateMixin{
  AnimationController controller;
  Animation<double> opacity;

  @override
  void initState(){
    super.initState();
    widget.pageController.addListener(updateOnPage);
    controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    opacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ),
  );
  }

  void update(){
    setState(() {
      if(widget.pageController.page == 0){
        controller.reverse();
      }
      if(widget.pageController.page == 1){
        controller.forward();
      }
    });
  }

  void updateOnPage(){
    double page;
    try{
      page = widget.pageController.page;
     }
    catch(e){
       page = 0.0;
    }
    if(page == 0 || page == 1){
      update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: AnimatedSwitcher(
        switchInCurve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
        switchOutCurve: Interval(0.0, 0.4, curve:Curves.easeOut),
        duration: Duration(milliseconds: 800),
        child: widget.child,
      )
    );
  }

  void dispose(){
    controller.dispose();
    widget.pageController.removeListener(updateOnPage);
    super.dispose();
  }
}

class SortButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IngredientServiceState inherited = IngredientService.of(context);
    return FlatButton(
      color: Colors.deepOrangeAccent[100],
      shape: StadiumBorder(),
      padding: EdgeInsets.all(10.0),
      onPressed: () => _sortDialog(context, inherited),
      child: Text("Sort Recipes", 
      style: TextStyle(color: Colors.white, fontSize: 17.0),
      ),
    );
  }

  void _sortDialog(BuildContext context, IngredientServiceState inherited){
    showDialog(
      context: context,
      builder: (_) => SortAlert(inherited)
      );
  }
}
