import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/login/controller/login_controller.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../../task_list/controller/task_list_controller.dart';
import '../models/task_response.dart';

class TaskController extends GetxController {
  final isLoading = true.obs;
  LoginController loginController = Get.put(LoginController());
  late Rx<TaskResponseModel> task;

  List<PlatformFile>? files;
  final TextEditingController descriptionController = TextEditingController();
  final isSendingTask = false.obs;
  final isClosingTask = false.obs;

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

    files = result.files;
    update();
  }

  void createAnswer() async {
    if (isSendingTask.isFalse) {
      isSendingTask(true);
      Answer? response = await ApiService().createAnswer(
          task.value.id.toString(), descriptionController.text, files);
      if (response != null) {
        task.update((val) {
          val?.answer.add(response);
        });
      }
      isSendingTask(false);
    }
  }

  void closeTask() async {
    if (isClosingTask.isFalse) {
      isClosingTask(true);
      bool result = await ApiService().closeTask(task.value.id.toString());
      if (result) {
        task.update((val) => val?.isDone = true);
        final cont = Get.put(TaskListController());
        cont.taskList.update((val) {
          for(var element in val!.results){
            if (element.id == task.value.id) {
              element.isDone = true;
              return;
            }
          }
        });
        Get.back();
        Get.snackbar("Успех!", "задача закрыто",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check_circle_outline));
      }
      isClosingTask(false);
    }
  }
}
