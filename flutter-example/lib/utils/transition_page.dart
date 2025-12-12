import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionPage {
  CustomTransitionPage<void> custom(
    ValueKey<String> key,
    Widget child,
    String? direction,
  ) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = direction == "back"
            ? const Offset(-1.0, 0.0)
            : const Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
