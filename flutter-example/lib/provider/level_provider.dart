

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelEntity {
  final Size imageSize;
  final double offsetX;
  final double offsetY;
  final bool isLevelRight;

  LevelEntity({
    this.imageSize = Size.zero,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.isLevelRight = false,
  });
}

class LevelNotifier extends StateNotifier<LevelEntity> {
  LevelNotifier() : super(LevelEntity());

  void update(LevelEntity level) {
    state = level;
  }

  LevelEntity get() {
    return state;
  }
}

final levelProvider = StateNotifierProvider((ref) {
  return LevelNotifier();
});
