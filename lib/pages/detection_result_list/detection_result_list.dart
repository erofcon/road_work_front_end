import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result_list/controller/detection_result_list_controller.dart';
import 'package:road_work_front_end/utils/helpers/extension.dart';

import '../../routes/routes.dart';
import '../../utils/constants.dart';
import 'components/delete_alert.dart';

class DetectionResultListPage extends GetView<DetectionResultListController> {
  const DetectionResultListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.detectionList.value!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: UiConstants.defaultPadding * 0.5),
                      child: DetectionResult(index: index),
                    ),
                  )),
            ),
          );
        }
      }),
    );
  }
}

class DetectionResult extends GetView<DetectionResultListController> {
  const DetectionResult({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.defaultPadding),
      ),
      onTap: () => Get.toNamed(RoutesClass.detailDetectionResult, parameters: {
        'id': controller.detectionList.value![index].id.toString()
      }),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: controller.loginController.user?.isCreator == true
          ? DeleteButton(
              index: index,
            )
          : null,
    );
  }

  Widget _buildTitle() {
    return Text(
      DateTime.parse(controller.detectionList.value![index].date)
          .formatdMMMMY()
          .toLowerCase(),
      style: const TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
        "?????????????????????? ?????????????????????? ${controller.detectionList.value![index].countImg}");
  }
}

class DeleteButton extends GetView<DetectionResultListController> {
  const DeleteButton({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
        onPressed: () => Get.dialog(DeleteAlert(
              index: controller.detectionList.value![index].id,
            )),
        child: const Text("??????????????"));
  }
}
