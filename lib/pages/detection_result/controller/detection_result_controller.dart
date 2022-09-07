import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/models/detection_result_response.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../../../theme/colors.dart';
import '../../create_task/controller/single_task_controller.dart';

class DetectionResultController extends GetxController {
  final isLoading = true.obs;

  late Rx<DetectionResultResponse?> detectionResult;

  List<Images> selectedIndex = [];
  final isLongPress = false.obs;
  final isUploadTask = false.obs;
  final isDeleteImage = false.obs;
  int currentIndex = 0;

  SingleTaskController singleTaskController = Get.put(SingleTaskController());

  @override
  void onInit() {
    getDetectionResult();
    super.onInit();
  }

  void getDetectionResult() async {
    detectionResult =
        (await ApiService().getDetailDetection(Get.parameters['id']!)).obs;
    isLoading(false);
  }

  void insertSelectIndex(Images index) {
    selectedIndex.add(index);
  }

  void deleteSelectIndex(Images index) {
    selectedIndex.remove(index);
  }

  void createTask() async {
    if (selectedIndex.isEmpty) {
      Get.snackbar("Ошибка", "Изображения не выбраны",
          margin: EdgeInsets.zero,
          duration: const Duration(seconds: 1),
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CustomColors.expiredTaskColor);
      return;
    }

    if (singleTaskController.selectedTaskCategory != null &&
        singleTaskController.relatedUser != null &&
        singleTaskController.expiredDateTime != null &&
        isUploadTask.isFalse) {
      isUploadTask(true);

      List<String> urls = [];
      String? latitude = '';
      String? longitude = '';

      for (Images image in selectedIndex) {
        urls.add(image.url);

        latitude = image.latitude.toString();
        longitude = image.longitude.toString();
      }

      bool result = await ApiService().createSingleTaskFromDetection(
          singleTaskController.selectedTaskCategory!.id,
          singleTaskController.relatedUser!.id,
          singleTaskController.expiredDateTime!,
          latitude: latitude,
          longitude: longitude,
          description: singleTaskController.description.text,
          urls: urls);

      await deleteImage();

      result
          ? Get.snackbar("Успех", "Задача успешно создано",
              margin: EdgeInsets.zero,
              duration: const Duration(seconds: 2),
              borderRadius: 0,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: CustomColors.completedTaskColor)
          : Get.snackbar("Ошибка", "Ошибка созданеия задачи",
              margin: EdgeInsets.zero,
              duration: const Duration(seconds: 2),
              borderRadius: 0,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: CustomColors.expiredTaskColor);

      isUploadTask(false);
    } else {
      Get.snackbar("Ошибка", "Обязательные поля не заполнены",
          margin: EdgeInsets.zero,
          duration: const Duration(seconds: 2),
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CustomColors.expiredTaskColor);
    }

    update();
  }

  Future<void> deleteImage() async {
    isDeleteImage(true);
    for (Images image in selectedIndex) {
      await ApiService().deleteImageFromDetection(image.id.toString());
      detectionResult.update((val) {
        val!.images.removeWhere((element) {
          return element.id == image.id;
        });
      });
      // print(selectedIndex);
    }
    selectedIndex.clear();
    isDeleteImage(false);
  }
}
