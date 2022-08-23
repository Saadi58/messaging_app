import 'package:flutter/cupertino.dart';

class BouncypageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncypageRoute({required this.widget})
      : super(
            transitionDuration: const Duration(milliseconds: 700),
            transitionsBuilder: (BuildContext context, animation,
                secondaryAnimation, Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, animation, secondaryAnimation) {
              return widget;
            });
}
