import 'package:cooksmart_v3/page_transitions.dart/fade_route.dart';
import 'package:cooksmart_v3/ui/recipe_finder/recipe_finder_home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/* Author: Sahil Mahendrakar */

void main(){
  runApp(MaterialApp(
    title: "CookSmart",
    theme: ThemeData(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.deepOrangeAccent,
      scaffoldBackgroundColor: Colors.orange[50],
    ),
    home: SplashScreen(),
    //home: RecipeFinderHome()
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
with SingleTickerProviderStateMixin {


void handleTimeout() {
  Navigator.of(context).pushReplacement(new FadeRoute(
    new RecipeFinderHome()));
}

startTimeout() async {
  var duration = const Duration(seconds: 2);
  return new Timer(duration, handleTimeout);
}

@override
void initState() {
  // TODO: implement initState
  super.initState();
  startTimeout();
}

@override
Widget build(BuildContext context) {
  return new Scaffold(
    backgroundColor: Colors.deepOrange,
    body: Center(
      child: Text("CookSmart", 
      style: Theme.of(context).textTheme.display3.copyWith(color: Colors.white),)
    ),
  );
}
}