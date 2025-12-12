import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_example/utils/core_loading.dart';
import 'package:flutter_example/utils/camera_descript.dart';
import 'package:flutter_example/utils/check_device.dart';
import 'package:flutter_example/provider/errors_provider.dart';
import 'package:flutter_example/widgets/capture_sdk_camera.dart';

class CaptureSdkCameraScreen extends ConsumerStatefulWidget {
  const CaptureSdkCameraScreen({super.key});

  @override
  CaptureSdkCameraScreenState createState() => CaptureSdkCameraScreenState();
}

class CaptureSdkCameraScreenState
    extends ConsumerState<CaptureSdkCameraScreen> {
  late CameraController _controller;

  Future<void> getCameraPermission() async {
    try {
      await CameraDescript().getCamera();
      _controller = CameraController(
        CameraDescript.firstCamera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      return _controller.initialize();
    } catch (error) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<dynamic> showDialogCustom(
    String description,
    String labelButton,
    void Function() clickButton,
    bool barrierDismissible,
    bool buttonWide,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(description),
        actions: [TextButton(onPressed: clickButton, child: Text(labelButton))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Center(
          child: Text(
            'Captura SDK',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        leading: TextButton(
          onPressed: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        actions: const [SizedBox(width: 48, height: 18)],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: getCameraPermission(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.done) {
                    ErrorsNotifier.start = true;
                    return CheckDevice.isEmulator
                        ? Text('Dispositivo não suportado!')
                        : CaptureSdkCamera();
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CoreLoading.showSpinner(
                        Theme.of(context).colorScheme.primary,
                        40,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
