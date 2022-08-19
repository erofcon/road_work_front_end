import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../service/api_service.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/models/related_user_response.dart';
import '../models/task_category_response.dart';

class SingleTaskController extends GetxController {

  final isLoading = true.obs;
  DashboardController dashboardController = Get.put(DashboardController());
  late final List<TaskCategory>? taskCategories;

  TaskCategory? selectedTaskCategory;
  RelatedUser? relatedUser;
  final TextEditingController description = TextEditingController();
  List<PlatformFile>? files;
  LatLng? location;
  DateTime? expiredDateTime;


  @override
  void onInit() {
    getTaskCategory();
    super.onInit();
  }

  void getTaskCategory() async {
    isLoading(true);

    try {
      taskCategories = await ApiService().getTaskCategory();
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(TaskCategory taskCategory) {
    selectedTaskCategory = taskCategory;
    update();
  }

  void selectRelatedUser(RelatedUser relatedUser) {
    this.relatedUser = relatedUser;
    update();
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

}
