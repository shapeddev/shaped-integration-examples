import 'package:flutter/material.dart';

class CoreLoading {
  static ValueNotifier<String?> percent = ValueNotifier(null);

  static Widget showSpinner(Color color, int opacity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color.withAlpha(opacity)),
          ),
        ),
      ],
    );
  }
}
