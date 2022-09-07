import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task_list/models/task_list.dart';

import '../../../service/api_service.dart';
import '../../login/controller/login_controller.dart';

class TaskListController extends GetxController {
  final isLoading = true.obs;
  late Rx<TaskList> taskList;
  LoginController loginController = Get.put(LoginController());
  final scrollController = ScrollController();
  final scrollLoad = false.obs;
  int page = 1;
  final showBackToTopButton = false.obs;
  String value = Get.arguments;

  @override
  void onInit() {
    getTaskList();
    scrollAdd();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void getTaskList() async {
    isLoading(true);
    taskList = (await ApiService().getTaskList(page, value))!.obs;
    isLoading(false);
  }

  getNextPage() async {
    page++;
    TaskList? task = await ApiService().getTaskList(page, value);

    taskList.update((val) {
      val?.next = task?.next;
      val?.results.addAll(task!.results);
    });
  }

  scrollAdd() {
    scrollController.addListener(() {
      if (scrollController.offset > 10.0) {
        showBackToTopButton(true); // show the back-to-top button
      } else {
        showBackToTopButton(false); // hide the back-to-top button
      }

      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (taskList.value.next != null && scrollLoad.isTrue) {
          getNextPage();
        }
      }
    });
  }
}
