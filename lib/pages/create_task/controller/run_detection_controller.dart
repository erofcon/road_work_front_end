import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:large_file_uploader/large_file_uploader.dart';

import '../../../service/api_service.dart';
import '../../../service/web_service.dart';

class RunDetectionController extends GetxController {
  DateTime? runDateTime;
  dynamic videoFile;
  final isUploadVideo = false.obs;
  bool errorSelect = false;
  final uploadProgress = 0.obs;

  void selectDateTime(dateTime) async {
    runDateTime = dateTime;
    update();
  }

  void ioSelectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result == null) return;
    videoFile = result.files.first;
    update();
  }

  void webSelectFile() async {
    LargeFileUploader().pick(
        type: FileTypes.video,
        callback: (file) {
          videoFile = file;
          update();
        });
  }

  void uploadVideo() async {
    uploadProgress(0);
    if (runDateTime == null || videoFile == null) {
      errorSelect = true;
      update();
      return;
    } else {
      errorSelect = false;
      update();
      isUploadVideo(true);
      if (GetPlatform.isWeb) {
        WebService().uploadDetection(
            runDateTime!,
            videoFile,
            (p) => progress(p),
            (responce) => uploadComplete(),
            () => uploadError);
      } else {
        await ApiService().runDetection(
            runDateTime!,
            videoFile,
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
    Get.snackbar("Успех!",
        "видео отправлено на детектирование. после окончания вы получите уведомление",
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check_circle_outline));
    isUploadVideo(false);
  }

  void uploadError() {
    Get.snackbar(
        "Ошибка!", "не удалось загрузить видео. повторите попытку позже",
        backgroundColor: Colors.red, icon: const Icon(Icons.error));
    isUploadVideo(false);
  }
}
