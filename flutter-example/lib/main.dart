import 'package:flutter/material.dart';
import 'package:flutter_example/start/app.dart';
import 'package:flutter_example/start/boot.dart';

void main() {
  boot(
    app: const App(
      key: Key("app"),
    ),
  );
}