
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoreHomeScreen extends StatefulWidget {
  const CoreHomeScreen({super.key});

  @override
  State<CoreHomeScreen> createState() => _CoreHomeScreenState();
}

class _CoreHomeScreenState extends State<CoreHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Shaped SDK Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.push('/capturesdk/page');
              },
              child: Text('Captura SDK'),
            ),
          ],
        ),
      ),
    );
  }
}