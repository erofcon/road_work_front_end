import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

class HeadTaskAnswer extends GetView<TaskController> {
  const HeadTaskAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('Ответы',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        const Spacer(),
        if (controller.loginController.user?.isSuperUser != true &&
            !controller.task.value.isExpired &&
            !controller.task.value.isDone)
          ElevatedButton.icon(
            icon: Icon(
              controller.loginController.user?.isExecutor == true
                  ? Icons.add
                  : Icons.close,
              size: 16,
            ),
            onPressed: answerCallback,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            label: controller.loginController.user?.isExecutor == true
                ? const Text("добавить")
                : const Text("закрыть"),
          ),
      ],
    );
  }

  void answerCallback() {
    if (controller.loginController.user?.isExecutor == true) {
      Get.bottomSheet(const _AddAnswer(), isScrollControlled: true);
    } else {
      Get.dialog(const _CloseTask());
    }
  }
}

class _AddAnswer extends GetView<TaskController> {
  const _AddAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: context.height / 2,
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  onPressed: () => Get.back(), icon: const Icon(Icons.close))
            ],
          ),
          Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(labelText: "описание"),
              )),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          Container(
              constraints: const BoxConstraints(maxWidth: 500), child: _SelectFile()),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          const _SendButton(),
        ],
      ),
    );
  }
}

class _SelectFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      builder: (controller) => SizedBox(
        width: context.width,
        child: ElevatedButton.icon(
          onPressed: () => controller.selectFile(),
          icon: controller.files == null
              ? const Icon(Icons.image_outlined)
              : const Icon(Icons.check_circle_outline),
          label: controller.files == null
              ? const Text("Выберите изображение")
              : const Text("Изображение выбрано"),
        ),
      ),
    );
  }
}

class _CloseTask extends GetView<TaskController> {
  const _CloseTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isClosingTask.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return AlertDialog(
          title: Text('close_task_question'.tr),
          // content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              // onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: controller.closeTask,
              // onPressed: closeTask,
              child: Text('ok'.tr),
            ),
          ],
        );
      }
    });
  }
}

class _SendButton extends GetView<TaskController> {
  const _SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSendingTask.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ElevatedButton(
          onPressed: controller.createAnswer,
          child: const Text("Отправить"),
        );
      }
    });
  }
}
