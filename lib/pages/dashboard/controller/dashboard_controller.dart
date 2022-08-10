import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/shared_components/task_card_list.dart';

import '../models/count_tasks_response.dart';
import '../service/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService _dashboardService = DashboardService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final isLoading = true.obs;
  late Rx<CountTasks> countTasks;
  late Rx<List<TaskCardInfo>> taskData;

  @override
  void onInit() {
    fetchCountTasks();
    super.onInit();
  }

  void fetchCountTasks() async {
    isLoading(true);
    try {
      var result = await _dashboardService.getCountTasks();
      if (result != null) {
        countTasks = Rx<CountTasks>(result);

        taskData = Rx([
          TaskCardInfo(
              title: 'Текущие задачи',
              count: 120,
              primary: Colors.orange,
              textColor: Colors.white),
          TaskCardInfo(
              title: 'Выполненые задачи',
              count: 12,
              primary: Colors.green,
              textColor: Colors.white),
          TaskCardInfo(
              title: 'Просроченные задачи',
              count: 12,
              primary: Colors.red,
              textColor: Colors.white),
        ]);
      }
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
