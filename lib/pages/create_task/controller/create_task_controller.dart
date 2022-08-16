import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:large_file_uploader/large_file_uploader.dart';
import 'package:latlong2/latlong.dart';
import 'package:road_work_front_end/pages/create_task/models/task_category_response.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/pages/dashboard/models/related_user_response.dart';

import '../../../service/api_service.dart';
import '../../../service/web_service.dart';


class CreateTaskController extends GetxController {
  final isLoading = true.obs;
  DashboardController dashboardController = Get.put(DashboardController());
  late final List<TaskCategory>? taskCategories;

  TaskCategory? selectedTaskCategory;
  RelatedUser? relatedUser;
  final TextEditingController description = TextEditingController();
  List<PlatformFile>? files;
  LatLng? location;
  DateTime? expiredDateTime;

  //run detection
  DateTime? runDateTime;
  dynamic videoFile;
  final isUploadVideo = false.obs;
  bool errorSelect = false;
  final uploadProgress = 0.obs;

  @override
  void onInit() {
    getTaskCategory();
    super.onInit();
  }

  void selectCategory(TaskCategory taskCategory) {
    selectedTaskCategory = taskCategory;
    update();
  }

  void selectRelatedUser(RelatedUser relatedUser) {
    this.relatedUser = relatedUser;
    update();
  }

  void getTaskCategory() async {
    isLoading(true);

    try {
      taskCategories = await ApiService().getTaskCategory();
    } finally {
      isLoading(false);
    }
  }

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return;
    files = result.files;
    update();
  }

  void selectDate(dateTime) async {
    expiredDateTime = dateTime;
    update();
  }

  void selectLocation(LatLng latLng) {
    location = latLng;
    update();
  }

  Future<bool> createTask() async {
    bool result = await ApiService().createSingleTask(
        selectedTaskCategory!.id, relatedUser!.id, expiredDateTime!,
        description: description.text,
        latitude: location?.latitude.toString(),
        longitude: location?.longitude.toString(),
        files: files);
    return result;
  }

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

    // var z= await WebHelpers.webSelectFile();
    // print(z);
    // videoFile = await WebHelpers.webSelectFile();
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
        WebService().uploadDetection(runDateTime!, videoFile, (p) =>progress(p), (responce) => uploadComplete(), () => uploadError);
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
