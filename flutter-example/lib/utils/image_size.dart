import 'package:flutter/material.dart';

class ImageSize {
  static double getWithFromImage(double width, BuildContext context) {
    final screenWitdh = MediaQuery.of(context).size.width - 24;
    return width < screenWitdh ? width : screenWitdh;
  }

  static double getHeightFromImage(
    double width,
    double height,
    BuildContext context,
  ) {
    final screenWitdh = MediaQuery.of(context).size.width - 24;
    final imageWithDiffPercent = ((screenWitdh * 100) / width) / 100;
    final containerHeight = height * imageWithDiffPercent;
    return width < screenWitdh ? height : containerHeight;
  }
}
