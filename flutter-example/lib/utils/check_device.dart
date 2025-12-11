import 'package:emulator_checker/emulator_checker.dart';

class CheckDevice {
  static bool isEmulator = false;

  static Future<void> emulator() async {
    CheckDevice.isEmulator = await EmulatorChecker.isEmulator();
  }
}
