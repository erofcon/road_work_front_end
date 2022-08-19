import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/components/image_carusel.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import 'components/navigation_buttons.dart';

class DetectionResultPage extends GetView<DetectionResultController> {
  const DetectionResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Scaffold(
          appBar: const DetectionAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(UiConstants.defaultPadding),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: controller.detectionResult.value!.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      final url =
                          controller.detectionResult.value!.images[index].url;
                      return Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              border: controller.selectedIndex.contains(
                                      controller.detectionResult.value!
                                          .images[index].id)
                                  ? Border.all(
                                      color: Colors.lightBlue, width: 5)
                                  : null),
                          child: ClipRRect(
                            child: InkWell(
                              onTap: () {
                                if (controller.selectedIndex.isEmpty) {
                                  controller.isLongPress = false;
                                }
                                if (controller.isLongPress) {
                                  if (controller.selectedIndex.contains(
                                      controller.detectionResult.value!
                                          .images[index].id)) {
                                    controller.deleteSelectIndex(controller
                                        .detectionResult
                                        .value!
                                        .images[index]
                                        .id);
                                  } else {
                                    controller.insertSelectIndex(controller
                                        .detectionResult
                                        .value!
                                        .images[index]
                                        .id);
                                  }
                                } else {
                                  controller.selectedIndex.clear();
                                  Get.to(() => DetectionResultImageCarousel(
                                      currentIndex: index,
                                      images: controller
                                          .detectionResult.value!.images));
                                }
                              },
                              onLongPress: () {
                                controller.isLongPress = true;
                                if (controller.selectedIndex.contains(controller
                                    .detectionResult.value!.images[index].id)) {
                                  controller.deleteSelectIndex(controller
                                      .detectionResult.value!.images[index].id);
                                } else {
                                  controller.insertSelectIndex(controller
                                      .detectionResult.value!.images[index].id);
                                }
                              },
                              child: ExtendedImage.network(
                                url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        );
      }
    });
  }
}
