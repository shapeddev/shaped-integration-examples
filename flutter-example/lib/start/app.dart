import 'package:flutter/material.dart';
import 'package:flutter_example/routes/go_router_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: "Shaped SDK",
        routerConfig: GoRouterOptions.config(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 0, 70, 40),
          ),
        ),
      ),
    );
  }
}
