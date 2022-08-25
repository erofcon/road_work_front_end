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
          title: const Text('AlertDialog Title'),
          // content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              // onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => controller.deleteDetection(index),
              // onPressed: closeTask,
              child: const Text('OK'),
            ),
          ],
        );
      }
    });
  }
}
