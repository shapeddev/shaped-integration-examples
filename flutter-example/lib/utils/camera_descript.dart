import 'package:camera/camera.dart';

class CameraDescript {
  static CameraDescription firstCamera = const CameraDescription(
    lensDirection: CameraLensDirection.back,
    name: 'Default',
    sensorOrientation: 0,
  );
  Future<void> getCamera() async {
    final cameras = await availableCameras();
    CameraDescript.firstCamera = cameras.first;
  }
}
