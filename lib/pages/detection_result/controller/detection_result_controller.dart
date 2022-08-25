import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/models/detection_result_response.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../../create_task/controller/single_task_controller.dart';

class DetectionResultController extends GetxController {
  final isLoading = true.obs;

  // late DetectionResultResponse? detectionResult;

  late Rx<DetectionResultResponse?> detectionResult;

  final selectedIndex = <Images>[].obs;
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
    update();
  }

  void insertSelectIndex(Images index) {
    selectedIndex.add(index);
  }

  void deleteSelectIndex(Images index) {
    selectedIndex.remove(index);
  }

  void createTask() async {
    if (selectedIndex.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: "Ошибка!",
        message: "Изображения не выбраны!",
        backgroundColor: Colors.red,
      ));
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
          ? Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 1),
              title: "Успех!",
              message: "задача успешно создано!",
              backgroundColor: Colors.green,
            ))
          : Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 1),
              title: "Ошибка!",
              message: "ошибка созданеия задачи!",
              backgroundColor: Colors.red));

      isUploadTask(false);
    } else {
      Get.showSnackbar(const GetSnackBar(
          title: "Ошибка!",
          message: "обязательные поля не заполнены!",
          backgroundColor: Colors.red));
    }
    selectedIndex.clear();
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
    }
    selectedIndex.clear();
    isDeleteImage(false);
  }
}
