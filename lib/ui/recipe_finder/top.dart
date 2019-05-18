import 'dart:async';
import 'package:cooksmart_v3/services/ingredient_service.dart';
import 'package:flutter/material.dart';

class Top extends StatefulWidget {
  final AnimationController controller;
  final IngredientServiceState ingredientService;
  Top(this.controller, this.ingredientService);
  @override
  TopState createState() {
    return new TopState();
  }
}

class TopState extends State<Top> {
  Animation<double> containerWidth;
  Animation<Offset> textSlide;
  Animation<double> textOpacity;
  Animation<Offset> arrowSlide;

  @override
  void initState() {
    super.initState();
    containerWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.controller,
            curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn)));
    textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(0.1, 1.0, curve: Curves.easeInOut,)
    ));
    textSlide = Tween(
      begin: Offset(2.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(0.1, 0.7,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    arrowSlide = Tween(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
    ));
    widget.ingredientService.ingredients.addListener((added){
      if(added && widget.ingredientService.ingredients.length > 0 && widget.ingredientService.ingredients.length < 2){
      startAnimation();
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final ingredientService = IngredientService.of(context);
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => widget.controller.forward(),
                  child: Container(
                    child: ClipPath(
                      clipper: HillClipper(),
                      child: Container(
                        color: Colors.red,
                        width: 500.0 * containerWidth.value,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SlideTransition(
                  position: textSlide,
                  child: FadeTransition(
                    opacity: textOpacity,
                    child: Container(
                      margin: EdgeInsets.only(right: 0.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 160.0,
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "Swipe Right To Find Recipes!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20.0, height: 1.2, color: Colors.white, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 60.0, 0.0),
                              child: SlideTransition(
                                position: arrowSlide,
                                child: Icon(Icons.arrow_forward, size: 30.0, color: Colors.white,)),),
                          ]),
                    ),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  //onTap: () => startAnimation(),
                ),
              )
            ],
          );
        });
  }

  Future startAnimation() async {
    await Future.delayed(Duration(seconds: 1), () => widget.controller.forward()
    .then((value) => Future.delayed(Duration(seconds: 1), () => widget.controller.reverse())));

  }
}

class HillClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(size.width, size.height / 5);
    //path.lineTo(size.width, size.height/5);

    var medianControlPoint = new Offset(0.0, size.height / 2);
    var medianPoint = new Offset(size.width, size.height - size.height / 5);
    path.quadraticBezierTo(medianControlPoint.dx, medianControlPoint.dy,
        medianPoint.dx, medianPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}