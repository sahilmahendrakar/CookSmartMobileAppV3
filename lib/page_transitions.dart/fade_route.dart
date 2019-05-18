import 'package:flutter/material.dart';

class FadeRoute extends PageRoute {

  final Widget child;

  FadeRoute(this.child);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;


  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

}