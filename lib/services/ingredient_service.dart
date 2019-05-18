import 'dart:collection';
import 'dart:core';
import 'package:cooksmart_v3/model/ingredient.dart';
import 'package:cooksmart_v3/model/recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IngredientService extends StatefulWidget {
  final Widget child;

  IngredientService({this.child});

  static IngredientServiceState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_InheritedIngredients) as _InheritedIngredients).data;
  }

  @override
  IngredientServiceState createState() => IngredientServiceState();
}

class IngredientServiceState extends State<IngredientService> with SingleTickerProviderStateMixin {
  IngredientList<Ingredient> ingredients = IngredientList();
  List<Recipe> savedRecipes = List<Recipe>();                                                                                                                                                  
  AnimationController controller;
  String diet;
  String health;
  int calorieTo;
  int calorieFrom;
  String sort;
  
  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedIngredients(
      data: this,
      child: widget.child,
    );
  }

  void changeSort(String s){
    setState(() {
          sort = s;
        });
  }

  void changeCalorieFrom(int from){
    setState(() {
          calorieFrom = from;
        });
  }

  void changeCalorieTo(int to){
    setState((){
      calorieTo = to;
    });
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

  void addIngredient(Ingredient ingredient){
    setState(() {
      ingredients.add(ingredient);          
    });
    ingredients.notifyListeners(added: true);
    print(ingredients);
  }

  Ingredient removeIngredient(int index){
    Ingredient ingredient = ingredients[index];
    setState(() {
      ingredients.removeAt(index);
    });
    return ingredient;
  }  

    String toUrlForm(){
      StringBuffer buffer = StringBuffer();
      for(int i = 0; i < ingredients.length; i++){
        buffer.write(ingredients[i].name);
        if(i+1 < ingredients.length){
          buffer.write("+");
        }
    }
    return buffer.toString();
  }
}


class _InheritedIngredients extends InheritedWidget {
  _InheritedIngredients({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final IngredientServiceState data;

  @override
  bool updateShouldNotify(_InheritedIngredients old) {
    return true;
  }
}


class IngredientList<Ingredient> extends ListBase<Ingredient> with ChangeNotifier{
  List<Ingredient> list = List();
  ObserverList<Function> _listeners = new ObserverList<Function>();

  @override
  int get length => list.length;

  set length(int length) => list.length = length; 

  @override
  Ingredient operator [](int index) {
    return list[index];
  }

  @override
  operator []=(int index, Ingredient value) {
    list[index]=value;
  }

  void add(Ingredient value){
    list.add(value);
    //notifyListeners(added: true);
  }

  @override
  bool remove(ingredient){
    notifyListeners(added: false);
    return list.remove(ingredient);
  }

  @override
  Ingredient removeAt(int index){
    notifyListeners(added: false);
    return list.removeAt(index);
  }

  void addAll(Iterable<Ingredient> value){
    list.addAll(value);
  }

  @override
  void notifyListeners({bool added = false}) {
    assert(_debugAssertNotDisposed());
    if (_listeners != null) {
      final List<Function> localListeners = new List<Function>.from(_listeners);
      for (Function listener in localListeners) {
        try {
          if (_listeners.contains(listener))
            listener(added);
        } catch (exception, stack) {
          FlutterError.reportError(new FlutterErrorDetails(
            exception: exception,
            stack: stack,
            library: 'foundation library',
            context: 'while dispatching notifications for $runtimeType',
            informationCollector: (StringBuffer information) {
              information.writeln('The $runtimeType sending notification was:');
              information.write('  $this');
            }
          ));
        }
      }
    }
  }

  @override
  void addListener(Function listener) {
    assert(_debugAssertNotDisposed());
    _listeners.add(listener);
  }

  @override
  void removeListener(Function listener) {
    assert(_debugAssertNotDisposed());
    _listeners.remove(listener);
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw new FlutterError(
          'A $runtimeType was used after being disposed.\n'
          'Once you have called dispose() on a $runtimeType, it can no longer be used.'
        );
      }
      return true;
    }());
    return true;
  }
}