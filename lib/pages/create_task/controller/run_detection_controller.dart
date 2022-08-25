import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:large_file_uploader/large_file_uploader.dart';

import '../../../service/api_service.dart';
import '../../../service/web_service.dart';

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
    Get.showSnackbar(const GetSnackBar(
      title: "Успех",
      message:
          "видео отправлено на детектирование. после окончания вы получите уведомление",
      backgroundColor: Colors.green,
    ));
    isUploadVideo(false);
  }

  void uploadError() {
    Get.showSnackbar(const GetSnackBar(
      title: "Ошибка!",
      message: "не удалось загрузить видео. повторите попытку позже",
      backgroundColor: Colors.red,
    ));
    isUploadVideo(false);
  }
}
