

import 'package:get/get.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../models/task_response.dart';

class TaskController extends GetxController{
  final isLoading = true.obs;
  late Rx<TaskResponseModel> task;

  @override
  void onInit() {
    getTask();
    super.onInit();
  }

  void getTask() async {
    task = (await ApiService().getTask(Get.arguments.toString()))!.obs;
    isLoading(false);
  }
}