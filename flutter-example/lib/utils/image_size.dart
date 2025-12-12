import 'package:flutter/material.dart';

class ImageSize {
  static double getWidthFromImage(double width, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 24;
    return width < screenWidth ? width : screenWidth;
  }

  static double getHeightFromImage(
    double width,
    double height,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width - 24;
    final imageWidthDiffPercent = ((screenWidth * 100) / width) / 100;
    final containerHeight = height * imageWidthDiffPercent;
    return width < screenWidth ? height : containerHeight;
  }
}
