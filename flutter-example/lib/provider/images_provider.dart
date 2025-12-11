import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagesEntity {
  final List<Uint8List>? capturedImages;
  final String? captureType;

  ImagesEntity({
    this.capturedImages,
    this.captureType,
  });
}

class ImagesNotifier extends StateNotifier<ImagesEntity> {
  ImagesNotifier() : super(ImagesEntity());

  void update(ImagesEntity images) {
    state = images;
  }

  ImagesEntity get() {
    return state;
  }
}

final imagesProvider = StateNotifierProvider((ref) {
  return ImagesNotifier();
});
