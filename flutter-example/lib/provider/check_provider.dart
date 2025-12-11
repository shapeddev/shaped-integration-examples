

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckEntity {
  final Size imageSize;
  final bool showFrontalConfirm;

  CheckEntity({
    this.imageSize = Size.zero,
    this.showFrontalConfirm = false,
  });
}

class CheckNotifier extends StateNotifier<CheckEntity> {
  CheckNotifier() : super(CheckEntity());

  void update(CheckEntity check) {
    state = check;
  }

  CheckEntity get() {
    return state;
  }
}

final checkProvider = StateNotifierProvider((ref) {
  return CheckNotifier();
});
