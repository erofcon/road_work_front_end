import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/models/related_user_response.dart';
import 'package:road_work_front_end/pages/dashboard/models/task_notification_response.dart';
import 'package:road_work_front_end/service/api_service.dart';
import 'package:road_work_front_end/shared_components/task_card_list.dart';
import 'package:road_work_front_end/theme/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../utils/constants.dart';
import '../../login/controller/login_controller.dart';
import '../../task_list/models/task_list.dart';
import '../models/count_tasks_response.dart';

class DashboardController extends GetxController {
  late CountTasks countTasks;
  late List<TaskCardInfo> taskData;
  late List<PieChartSectionData> taskChartData;
  late List<RelatedUser> relatedUser;
  late TaskList? taskList;
  late WebSocketChannel channel;

  LoginController loginController = Get.put(LoginController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final isLoading = true.obs;
  final isDarkMode = Get.isDarkMode.obs;
  final notifications = <TaskNotificationResponse>[].obs;
  final notificationsData = <Data>[].obs;

  @override
  void onInit() {
    getCountTasks();
    ApiService().connectWebSocket(getMessage);

    super.onInit();
  }

  void getCountTasks() async {
    isLoading(true);
    try {
      var result = await ApiService().getCountTasks();
      if (result != null) {
        countTasks = result;
        taskData = [
          TaskCardInfo(
              title: 'current_tasks'.tr,
              count: countTasks.countCurrentTasks,
              primary: CustomColors.currentTaskColor,
              textColor: Colors.white,
              iconWidget: Icon(Icons.list_alt_outlined,
                  size: 34, color: CustomColors.currentTaskColor),
              routArguments: 'all_current_tasks'),
          TaskCardInfo(
              title: 'completed_tasks'.tr,
              count: countTasks.countIsDoneTasks,
              primary: CustomColors.completedTaskColor,
              textColor: Colors.white,
              iconWidget: Icon(
                Icons.cloud_done_rounded,
                size: 34,
                color: CustomColors.completedTaskColor,
              ),
              routArguments: 'is_done'),
          TaskCardInfo(
              title: 'expired_tasks'.tr,
              count: countTasks.countExpiredTasks,
              primary: CustomColors.expiredTaskColor,
              textColor: Colors.white,
              iconWidget: Icon(Icons.disabled_by_default_outlined,
                  size: 34, color: CustomColors.expiredTaskColor),
              routArguments: 'expired_tasks'),
        ];

        taskChartData = [
          PieChartSectionData(
            color: CustomColors.currentTaskColor,
            value: countTasks.countCurrentTasks.toDouble(),
            showTitle: true,
            radius: 75,
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          PieChartSectionData(
            color: CustomColors.completedTaskColor,
            value: countTasks.countIsDoneTasks.toDouble(),
            showTitle: true,
            radius: 82,
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          PieChartSectionData(
            color: CustomColors.expiredTaskColor,
            value: countTasks.countExpiredTasks.toDouble(),
            showTitle: true,
            radius: 89,
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ];
      }

      var related = await ApiService().getRelatedUser();
      relatedUser = related!;

      taskList = await ApiService().getTaskList(1, 'all');
    } finally {
      isLoading(false);
    }
  }

  void getMessage(message) {
    var result = taskNotificationResponse(message);
    if (result.action != NotificationActions.delete) {
      notificationsData.addAll(result.data);
    }
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void deleteTaskNotification(int id, String type) async {
    bool result = await ApiService().deleteTaskNotification(id, type);
    if (result) {
      notificationsData.removeWhere((element) => element.id == id);
    }
  }

  void deleteDetectionNotification(int id) async {
    bool result = await ApiService().deleteDetectionNotification(id);

    if (result) {
      notificationsData.removeWhere((element) => element.id == id);
    }
  }
}
