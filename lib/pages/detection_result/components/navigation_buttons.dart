import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/components/create_task.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';
import 'package:road_work_front_end/pages/login/controller/login_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

class DetectionAppBar extends GetView<LoginController>
    implements PreferredSizeWidget {
  const DetectionAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: controller.user?.isCreator == true
          ? [
              const DeleteImage(),
              IconButton(
                  splashRadius: 20,
                  onPressed: () => Get.dialog(const CreateTask()),
                  icon: const Icon(
                    Icons.edit,
                  )),
              const UploadTaskButton(),
              const SizedBox(
                width: UiConstants.defaultPadding,
              )
            ]
          : [],
    );
  }
}

class DeleteImage extends GetView<DetectionResultController> {
  const DeleteImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 20,
        onPressed: () {
          if (controller.isDeleteImage.isFalse) {
            controller.deleteImage();
          }
        },
        icon: const Icon(
          Icons.delete_forever_outlined,
        ));
  }
}

class UploadTaskButton extends GetView<DetectionResultController> {
  const UploadTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 20,
        onPressed: () {
          if (controller.isUploadTask.isFalse) {
            controller.createTask();
          }
        },
        icon: const Icon(
          Icons.send_to_mobile_outlined,
        ));
  }
}
