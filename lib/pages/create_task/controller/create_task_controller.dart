import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:road_work_front_end/pages/create_task/models/task_category_response.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/pages/dashboard/models/related_user_response.dart';

import '../../../service/api_service.dart';

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

  // void webSelectFile() {
  //   LargeFileUploader().pick(
  //       type: FileTypes.video,
  //       callback: (file) {
  //         videoFile = file;
  //         update();
  //       });
  // }

  void uploadVideo() async{
    if(runDateTime == null || videoFile == null){
      errorSelect = true;
      update();
      return;
    }else{
      errorSelect = false;
      update();
      isUploadVideo(true);
      if(GetPlatform.isWeb){
        // WebService().uploadDetection(runDateTime!, videoFile, (progress) => null, (responce) => null, () => null);
      }

      isUploadVideo(false);
    }

  }

}

