

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/login/controller/login_controller.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../../dashboard/controller/dashboard_controller.dart';
import '../models/task_response.dart';

class TaskController extends GetxController{
  final isLoading = true.obs;
  LoginController loginController = Get.put(LoginController());
  late Rx<TaskResponseModel> task;
  List<PlatformFile>? file;

  @override
  void onInit() {
    getTask();
    super.onInit();
  }

  void getTask() async {
    task = (await ApiService().getTask(Get.arguments.toString()))!.obs;
    isLoading(false);
  }

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return;

    file = result.files;
    update();
  }
}