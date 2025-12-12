import 'package:flutter/material.dart';
import 'package:flutter_example/routes/core_routes.dart';
import 'package:flutter_example/screens/core_notfound_screen.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class GoRouterOptions {
  static GoRouter config() {
    final initial = "/home";

    return GoRouter(
      initialLocation: '$initial/page',
      navigatorKey: _rootNavigatorKey,
      routes: <RouteBase>[
        ...CoreRoutes().routes(initial, _rootNavigatorKey),
      ],
      errorBuilder: (context, state) => const CoreNotFoundScreen(),
    );
  }
}
