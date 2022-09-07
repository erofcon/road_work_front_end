import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/components/navigation_buttons.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

import '../../utils/constants.dart';
import 'components/image_carusel.dart';

class DetectionResultPage extends StatefulWidget {
  const DetectionResultPage({Key? key}) : super(key: key);

  @override
  State<DetectionResultPage> createState() => _DetectionResultPageState();
}

class _DetectionResultPageState extends State<DetectionResultPage> {
  late DetectionResultController controller;

  @override
  void initState() {
    controller = Get.put(DetectionResultController());
    super.initState();
  }

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
          body: Stack(
            children: [
              Padding(
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
                        itemCount:
                            controller.detectionResult.value!.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          final url = controller
                              .detectionResult.value!.images[index].url;
                          return Container(
                            decoration: BoxDecoration(
                                border: controller.selectedIndex.contains(
                                        controller.detectionResult.value!
                                            .images[index])
                                    ? Border.all(
                                        color: Colors.lightBlue, width: 5)
                                    : null),
                            child: InkWell(
                              onTap: () {
                                if (controller.selectedIndex.isEmpty) {
                                  controller.isLongPress(false);
                                }
                                if (controller.isLongPress.isTrue) {
                                  if (controller.selectedIndex.contains(
                                      controller.detectionResult.value!
                                          .images[index])) {
                                    controller.deleteSelectIndex(controller
                                        .detectionResult.value!.images[index]);
                                  } else {
                                    controller.insertSelectIndex(controller
                                        .detectionResult.value!.images[
                                          index]);
                                  }
                                  setState(() {});
                                } else {
                                  controller.currentIndex = index;
                                  // controller.selectedIndex.clear();
                                  // controller.insertSelectIndex(controller
                                  //     .detectionResult.value!.images[index]);
                                  Get.dialog(
                                      const DetectionResultImageCarousel());
                                }
                              },
                              onLongPress: () {
                                controller.isLongPress(true);
                                if (controller.selectedIndex.contains(controller
                                    .detectionResult.value!.images[index])) {
                                  controller.deleteSelectIndex(controller
                                      .detectionResult.value!.images[index]);
                                } else {
                                  controller.insertSelectIndex(controller
                                      .detectionResult.value!.images[index]);
                                }
                                setState(() {});
                              },
                              child: ExtendedImage.network(
                                url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
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
          ),
        );
      }
    });
  }
}
