import 'package:flutter/material.dart';
import 'package:flutter_example/screens/capture_sdk_camera_screen.dart';
import 'package:flutter_example/screens/core_confirmation_screen.dart';
import 'package:flutter_example/screens/core_home_screen.dart';
import 'package:flutter_example/screens/core_notfound_screen.dart';
import 'package:flutter_example/utils/transition_page.dart';
import 'package:go_router/go_router.dart';

class CoreRoutes {
  static final defaultRoutes = [
    GoRoute(
      path: "/notfound/:direction",
      pageBuilder: (context, state) => TransitionPage().custom(
        state.pageKey,
        const CoreNotFoundScreen(),
        state.pathParameters['direction'].toString(),
      ),
    ),
  ];

  List<RouteBase> routes(String initial, GlobalKey<NavigatorState> key) {
    List<dynamic> targetRoutes = [];

    targetRoutes = [
      GoRoute(
        path: '$initial/:direction',
        pageBuilder: (context, state) => TransitionPage().custom(
          state.pageKey,
          const CoreHomeScreen(),
          state.pathParameters['direction'].toString(),
        ),
      ),
      GoRoute(
        path: '/capturesdk/:direction',
        pageBuilder: (context, state) => TransitionPage().custom(
          state.pageKey,
          const CaptureSdkCameraScreen(),
          state.pathParameters['direction'].toString(),
        ),
      ),
      GoRoute(
        path: '/capturesdkconfirmation/:direction',
        pageBuilder: (context, state) => TransitionPage().custom(
          state.pageKey,
          const CoreConfirmationScreen(),
          state.pathParameters['direction'].toString(),
        ),
      ),
    ];

    return [...targetRoutes];
  }
}
