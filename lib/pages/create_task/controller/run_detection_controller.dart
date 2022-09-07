import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:large_file_uploader/large_file_uploader.dart';

import '../../../service/api_service.dart';
import '../../../service/web_service.dart';
import '../../../theme/colors.dart';

class RunDetectionController extends GetxController {
  final runDateTime = Rx<DateTime?>(null);
  final videoFile = Rx<dynamic>(null);
  final isUploadVideo = false.obs;
  final errorSelect = false.obs;
  final uploadProgress = 0.obs;

  void selectDateTime(dateTime) async {
    runDateTime(dateTime);
  }

  void ioSelectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result == null) return;
    videoFile(result.files.first.obs);
  }

  void webSelectFile() async {
    LargeFileUploader().pick(
        type: FileTypes.video,
        callback: (file) {
          videoFile(file);
          update();
        });
  }

  void uploadVideo() async {
    uploadProgress(0);
    if (runDateTime.value == null || videoFile.value == null) {
      errorSelect(true);
      return;
    } else {
      errorSelect(false);
      update();
      isUploadVideo(true);
      if (GetPlatform.isWeb) {
        WebService().uploadDetection(
            runDateTime.value!,
            videoFile.value,
            (p) => progress(p),
            (response) => uploadComplete(),
            () => uploadError);
      } else {
        await ApiService().runDetection(
            runDateTime.value!,
            videoFile.value,
            (send, total) => progress(send, total: total),
            uploadComplete,
            uploadError);
      }
    }
  }

  void progress(send, {total}) {
    if (total != null) {
      uploadProgress((send / total * 100).toInt());
    } else {
      uploadProgress(send);
    }
  }

  void uploadComplete() {
    Get.snackbar("Успех",
        "Видео отправлено на детектирование. После окончания вы получите уведомление",
        margin: EdgeInsets.zero,
        duration: const Duration(seconds: 2),
        borderRadius: 0,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.completedTaskColor);

    isUploadVideo(false);
  }

  void uploadError() {
    Get.snackbar(
        "Ошибка", "Не удалось загрузить видео. Повторите попытку позже",
        margin: EdgeInsets.zero,
        duration: const Duration(seconds: 2),
        borderRadius: 0,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.expiredTaskColor);

    isUploadVideo(false);
  }
}
