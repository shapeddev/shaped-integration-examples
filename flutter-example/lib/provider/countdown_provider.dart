
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownEntity {
  final int? countdown;
  final bool isCountdownVisible;

  CountdownEntity({
    this.countdown,
    this.isCountdownVisible = false,
  });
}

class CountdownNotifier extends StateNotifier<CountdownEntity> {
  CountdownNotifier() : super(CountdownEntity());

  void update(CountdownEntity countdown) {
    state = countdown;
  }

  CountdownEntity get() {
    return state;
  }
}

final countdownProvider = StateNotifierProvider((ref) {
  return CountdownNotifier();
});
