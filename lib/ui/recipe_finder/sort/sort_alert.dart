import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:cooksmart_v3/ui/recipe_finder/sort/sort_menu.dart';
import 'package:flutter/material.dart';

class SortAlert extends StatefulWidget {
  final IngredientServiceState inherited; 
  SortAlert(this.inherited);

  @override
  _SortAlertState createState() => _SortAlertState();
}

class _SortAlertState extends State<SortAlert> {
  String diet;
  String health;
  String sort;
  int calorieFrom;
  int calorieTo;

  void initState(){
    super.initState();
    diet = widget.inherited.diet;
    health = widget.inherited.health;
    sort = widget.inherited.sort;
    calorieFrom = widget.inherited.calorieFrom;
    calorieTo = widget.inherited.calorieTo;
  }

  @override
  Widget build(BuildContext context) {
    print(sort);
    return AlertDialog(
      title: Text("Recipe Restrictions",
        style: TextStyle(color: Colors.deepOrange[700], fontSize: 23.0),
      ),
      content: SortBar(
        dietChanged: changeDiet, healthChanged: changeHealth, 
        calorieFromChanged: changeCalorieFrom, calorieToChanged: changeCalorieTo,
        initialDiet: diet,
        initialHealth: health,
        calorieFrom: calorieFrom,
        calorieTo: calorieTo,
        sort: sort,
        sortChanged: changeSort,
        ),
      contentPadding: EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 0.0),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("CANCEL")),
        FlatButton(onPressed: (){
          sortButton();
          Navigator.of(context).pop();
        }, 
        child: Text("SORT RECIPES", style: Theme.of(context).textTheme.button.copyWith(color: Colors.deepOrange, fontWeight: FontWeight.bold),))
      ],
    );
  }

  void changeDiet(String d){
    setState(() {
          diet = d;
        });
  }

  void changeHealth(String h){
    setState(() {
          health = h;
        });
  }

  void changeCalorieFrom(int from){
    print(from);
    setState(() {
          calorieFrom = from;
        });
  }



  void changeCalorieTo(int to){
    setState(() {
          calorieTo = to;
        });
  }
  
    void changeSort(String s){
    setState(() {
          sort = s;
        });
  }

  void sortButton(){
    widget.inherited.changeDiet(diet);
    widget.inherited.changeHealth(health);
    widget.inherited.changeCalorieFrom(calorieFrom);
    widget.inherited.changeCalorieTo(calorieTo);
    widget.inherited.changeSort(sort);
  }
}