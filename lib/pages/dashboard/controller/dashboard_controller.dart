import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/models/related_user_response.dart';
import 'package:road_work_front_end/service/api_service.dart';
import 'package:road_work_front_end/shared_components/task_card_list.dart';

import '../models/count_tasks_response.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final isLoading = true.obs;
  late CountTasks countTasks;
  late List<TaskCardInfo> taskData;
  late List<RelatedUser> relatedUser;

  @override
  void onInit() {
    getCountTasks();
    super.onInit();
  }

  void getCountTasks() async {
    isLoading(true);
    try {
      var result = await _apiService.getCountTasks();
      if (result != null) {
        countTasks = result;
        taskData = [
          TaskCardInfo(
              title: 'current_tasks'.tr,
              count: countTasks.countCurrentTasks,
              primary: Colors.orange,
              textColor: Colors.white,
              iconWidget: const Icon(Icons.list_alt_outlined,
                  size: 34, color: Colors.orange)),
          TaskCardInfo(
              title: 'completed_tasks'.tr,
              count: countTasks.countIsDoneTasks,
              primary: Colors.green,
              textColor: Colors.white,
              iconWidget: const Icon(
                Icons.cloud_done_rounded,
                size: 34,
                color: Colors.green,
              )),
          TaskCardInfo(
              title: 'expired_tasks'.tr,
              count: countTasks.countExpiredTasks,
              primary: Colors.red,
              textColor: Colors.white,
              iconWidget: const Icon(Icons.disabled_by_default_outlined,
                  size: 34, color: Colors.red)),
        ];
      }

      var related = await _apiService.getRelatedUser();
      relatedUser = related!;
    } finally {
      isLoading(false);
    }
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}
