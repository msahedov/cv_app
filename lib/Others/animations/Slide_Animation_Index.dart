import 'package:flutter/material.dart';
// ignore: camel_case_types
class Slide_Animation_mine extends StatelessWidget {
  final int index;
  final Widget child;
  final AnimationController animationController;

  const Slide_Animation_mine({Key key, this.index, this.animationController, this.child}) : super(key: key);
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
              begin: Offset(0, index.toDouble()), end: Offset.zero)
          .animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: child,
      ),
    );
  }
}