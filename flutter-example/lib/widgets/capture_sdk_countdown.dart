import 'package:flutter/material.dart';
import 'package:flutter_example/provider/countdown_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaptureSdkCountdown extends ConsumerStatefulWidget {
  const CaptureSdkCountdown({super.key});

  @override
  CaptureSdkCountdownState createState() => CaptureSdkCountdownState();
}

class CaptureSdkCountdownState extends ConsumerState<CaptureSdkCountdown> {
  @override
  Widget build(BuildContext context) {
    final countdownInfo = ref.watch(countdownProvider.notifier).get();
    final countdown = countdownInfo.countdown;
    final isCountdownVisible = countdownInfo.isCountdownVisible;

    return isCountdownVisible
        ? Positioned.fill(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOutExpo,
                child: Text(
                  countdown?.toString() ?? '',
                  key: ValueKey<int?>(countdown),
                  style: TextStyle(
                    fontSize: 400,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
