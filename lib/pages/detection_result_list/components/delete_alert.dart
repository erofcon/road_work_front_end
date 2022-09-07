import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result_list/controller/detection_result_list_controller.dart';

class DeleteAlert extends GetView<DetectionResultListController> {
  const DeleteAlert({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDeleting.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return AlertDialog(
          title: Text('delete_detection_question'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () => controller.deleteDetection(index),
              child: Text('ok'.tr),
            ),
          ],
        );
      }
    });
  }
}
