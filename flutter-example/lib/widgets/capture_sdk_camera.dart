import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_example/provider/check_provider.dart';
import 'package:flutter_example/provider/countdown_provider.dart';
import 'package:flutter_example/provider/errors_provider.dart';
import 'package:flutter_example/provider/images_provider.dart';
import 'package:flutter_example/provider/level_provider.dart';
import 'package:flutter_example/widgets/capture_sdk_check.dart';
import 'package:flutter_example/widgets/capture_sdk_countdown.dart';
import 'package:flutter_example/widgets/capture_sdk_errors.dart';
import 'package:flutter_example/widgets/capture_sdk_level.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_example/utils/core_loading.dart';

import 'package:shaped_plugin/shaped_plugin.dart';

class CaptureSdkCamera extends ConsumerStatefulWidget {
  const CaptureSdkCamera({super.key});

  @override
  CaptureSdkCameraState createState() => CaptureSdkCameraState();
}

class CaptureSdkCameraState extends ConsumerState<CaptureSdkCamera> {
  bool loading = false;

  void handleImages(
    List<Uint8List> capturedImages,
    bool frontalValidation,
  ) async {
    if (!frontalValidation) {
      setState(() {
        loading = true;
      });
      final imagesCaptured = ImagesEntity(
        capturedImages: capturedImages,
        captureType: "sdk",
      );
      ref.read(imagesProvider.notifier).update(imagesCaptured);
      await context.push('/capturesdkconfirmation/page');
      ErrorsNotifier.start = true;
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> changeFrontalValidation(
    bool frontalValidation,
    Size imageSize,
  ) async {
    if (!frontalValidation) {
      setState(() {
        final checkInfo = CheckEntity(
          imageSize: imageSize,
          showFrontalConfirm: true,
        );
        ref.read(checkProvider.notifier).update(checkInfo);
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        final checkInfo = CheckEntity(
          imageSize: imageSize,
          showFrontalConfirm: false,
        );
        ref.read(checkProvider.notifier).update(checkInfo);
      });
    }
  }

  void handleErrors(List<String> errors) {
    setState(() {
      final listErrors = ErrorsEntity(errorList: errors);
      ref.read(errorsProvider.notifier).update(listErrors);
    });
  }

  void handleCountdown(int? countdown) async {
    if (countdown != null) {
      setState(() {
        final countDowninfo = CountdownEntity(
          countdown: countdown,
          isCountdownVisible: true,
        );
        ref.read(countdownProvider.notifier).update(countDowninfo);
      });

      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        final countDowninfo = CountdownEntity(
          countdown: countdown,
          isCountdownVisible: false,
        );
        ref.read(countdownProvider.notifier).update(countDowninfo);
      });
    }
  }

  void onValidateDeviceLevel(DeviceLevel? deviceLevel, Size imageSize) {
    if (deviceLevel != null) {
      setState(() {
        final leveDevice = LevelEntity(
          imageSize: imageSize,
          offsetX: deviceLevel.x,
          offsetY: deviceLevel.y,
          isLevelRight: deviceLevel.isValid,
        );
        ref.read(levelProvider.notifier).update(leveDevice);
      });
    }
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
    return Center(
      child: Column(
        children: [
          CaptureSdkErrors(),
          !loading
              ? Stack(
                  children: [
                    ShapedSdkCamera(
                      onImagesCaptured: handleImages,
                      onChangeFrontalValidation: changeFrontalValidation,
                      onDeviceLevel: onValidateDeviceLevel,
                      onErrorsPose: handleErrors,
                      showDialog: showDialogCustom,
                      onCountdown: handleCountdown,
                    ),
                    CaptureSdkLevel(),
                    CaptureSdkCountdown(),
                    CaptureSdkCheck(),
                  ],
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: CoreLoading.showSpinner(
                    Theme.of(context).colorScheme.primary,
                    40,
                  ),
                ),
        ],
      ),
    );
  }
}
