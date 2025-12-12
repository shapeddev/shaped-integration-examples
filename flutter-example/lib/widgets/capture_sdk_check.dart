import 'package:flutter/material.dart';
import 'package:flutter_example/provider/check_provider.dart';
import 'package:flutter_example/utils/image_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaptureSdkCheck extends ConsumerStatefulWidget {
  const CaptureSdkCheck({super.key});

  @override
  CaptureSdkCheckState createState() => CaptureSdkCheckState();
}

class CaptureSdkCheckState extends ConsumerState<CaptureSdkCheck> {
  @override
  Widget build(BuildContext context) {
    final checkInfo = ref.watch(checkProvider.notifier).get();
    final imageSize = checkInfo.imageSize;
    final showFrontalConfirm = checkInfo.showFrontalConfirm;

    return showFrontalConfirm
        ? Center(
            child: Container(
              width: ImageSize.getWidthFromImage(imageSize.width, context),
              height: ImageSize.getHeightFromImage(
                imageSize.width,
                imageSize.height,
                context,
              ),
              color: Colors.white,
              child: Center(
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 128,
                  color: Color.fromARGB(255, 73, 227, 47),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
