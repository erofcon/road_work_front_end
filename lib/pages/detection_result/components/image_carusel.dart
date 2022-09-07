import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

import 'navigation_buttons.dart';

class DetectionResultImageCarousel extends GetView<DetectionResultController> {
  const DetectionResultImageCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetectionAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          controller.selectedIndex.clear();
          return true;
        },
        child: Obx(() {
          return Stack(
            children: [
              ExtendedImageGesturePageView.builder(
                itemCount: controller.detectionResult.value!.images.length,
                onPageChanged: (int index) {
                  controller.selectedIndex.clear();
                  controller.insertSelectIndex(
                      controller.detectionResult.value!.images[index]);
                },
                controller: ExtendedPageController(
                    initialPage: controller.currentIndex),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  String img =
                      controller.detectionResult.value!.images[index].url;
                  if(controller.isDeleteImage.isFalse){
                    controller.insertSelectIndex(
                        controller.detectionResult.value!.images[index]);
                  }

                  Widget image = ExtendedImage.network(
                    img,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (ExtendedImageState state) {
                      return GestureConfig(
                        minScale: 1.005,
                        animationMinScale: 0.1,
                        maxScale: 4.0,
                        animationMaxScale: 4.5,
                        speed: 1.0,
                        initialScale: 1.005,
                        inPageView: true,
                        initialAlignment: InitialAlignment.center,
                        reverseMousePointerScrollDirection: true,
                      );
                    },
                  );
                  image = Container(
                    padding: const EdgeInsets.all(5.0),
                    child: image,
                  );
                  if (index == controller.currentIndex) {
                    return Hero(tag: img + index.toString(), child: image);
                  } else {
                    return image;
                  }
                },
              ),
              if (controller.isDeleteImage.isTrue ||
                  controller.isDeleteImage.isTrue)
                Container(
                  width: context.width,
                  height: context.height,
                  color: Colors.black38,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        }),
      ),
    );
  }
}
