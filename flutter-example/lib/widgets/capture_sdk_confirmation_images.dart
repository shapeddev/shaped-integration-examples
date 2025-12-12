import 'package:flutter/material.dart';
import 'package:flutter_example/provider/images_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaptureSDKConfirmationImages extends ConsumerStatefulWidget {
  const CaptureSDKConfirmationImages({super.key});

  @override
  CaptureSDKConfirmationImagesState createState() =>
      CaptureSDKConfirmationImagesState();
}

class CaptureSDKConfirmationImagesState
    extends ConsumerState<CaptureSDKConfirmationImages> {
  @override
  Widget build(BuildContext context) {
    final imagesCaptured = ref.read(imagesProvider.notifier).get();
    final capturedImages = imagesCaptured.capturedImages;

    return Expanded(
      child: ListView.builder(
        itemCount: capturedImages?.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: AlignmentGeometry.topCenter,
                  image: Image.memory(capturedImages![index]).image,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
