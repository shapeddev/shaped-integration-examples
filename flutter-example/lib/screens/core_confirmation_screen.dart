import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/capture_sdk_confirmation_images.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CoreConfirmationScreen extends ConsumerStatefulWidget {
  const CoreConfirmationScreen({super.key});

  @override
  CoreConfirmationScreenState createState() =>
      CoreConfirmationScreenState();
}

class CoreConfirmationScreenState
    extends ConsumerState<CoreConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Center(
          child: Text(
            'Confirmação',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        leading: TextButton(
          onPressed: () {
            try {
              context.pop();
            } catch (e) {
              context.go('/home/back');
            }
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        actions: const [
          SizedBox(
            width: 48,
            height: 18,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 24),
            Text(
              'Confirmar Images Capturadas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 24),
            CaptureSDKConfirmationImages(),
          ],
        ),
      ),
    );
  }
}
