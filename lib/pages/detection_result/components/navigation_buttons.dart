import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/components/create_task.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

class DetectionAppBar extends GetView<DetectionResultController>
    implements PreferredSizeWidget {
  const DetectionAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back),
      //   onPressed: () {
      //     // controller.clearSelectIndex();
      //     controller.selectedIndex.clear();
      //     // Get.back();
      //   },
      // ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const DeleteImage(),
            IconButton(
                onPressed: () => Get.to(
                      () => const CreateTask(),
                      fullscreenDialog: true,
                    ),
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            const UploadTaskButton(),
          ],
        ),
      ),
    );
  }
}

class DeleteImage extends GetView<DetectionResultController> {
  const DeleteImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDeleteImage.isFalse) {
        return IconButton(
            onPressed: controller.deleteImage,
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Theme.of(context).primaryColor,
            ));
      } else {
        return const SizedBox(
            width: 24, height: 24, child: CircularProgressIndicator());
      }
    });
  }
}

class UploadTaskButton extends GetView<DetectionResultController> {
  const UploadTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isUploadTask.isFalse) {
        return IconButton(
            onPressed: controller.createTask,
            icon: Icon(
              Icons.send_to_mobile_outlined,
              color: Theme.of(context).primaryColor,
            ));
      } else {
        return const SizedBox(
            width: 24, height: 24, child: CircularProgressIndicator());
      }
    });
  }
}
