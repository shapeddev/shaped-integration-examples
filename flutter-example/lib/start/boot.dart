import 'package:flutter/widgets.dart';
import 'package:flutter_example/utils/check_device.dart';

Future<void> boot({
  required Widget app,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await CheckDevice.emulator();
  runApp(app);
}
