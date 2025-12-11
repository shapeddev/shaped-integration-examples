import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoreNotFoundScreen extends StatelessWidget {
  const CoreNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Center(
            child: Text(
              'Aviso',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          leading: TextButton(
            onPressed: () {
              context.go('/home/back');
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          actions: const [SizedBox(width: 48, height: 18)],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Página não\nencontrada!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
