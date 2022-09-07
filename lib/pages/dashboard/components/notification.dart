import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/theme/colors.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../models/task_notification_response.dart';

class NotificationDialog extends GetView<DashboardController> {
  const NotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      contentPadding: EdgeInsets.zero,
      content: Builder(
        builder: (context) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: 500,
            ),
            padding: const EdgeInsets.symmetric(
                vertical: UiConstants.defaultPadding * 2,
                horizontal: UiConstants.defaultPadding * 0.5),
            child: SingleChildScrollView(
              child: SizedBox(
                width: context.width,
                child: Obx(
                  (){
                    if(controller.notificationsData.isNotEmpty){
                      return Column(
                        children: List.generate(
                            controller.notificationsData.length,
                                (index) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: UiConstants.defaultPadding),
                              child: NotificationPart(
                                notificationData:
                                controller.notificationsData[index],
                              ),
                            )),
                      );
                    }else{
                      return Center(child: Text("Пусто", style: TextStyle(color: CustomColors.iconColor),),);
                    }
                  }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationPart extends GetView<DashboardController> {
  const NotificationPart({Key? key, required this.notificationData})
      : super(key: key);

  final Data notificationData;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: _getNotificationColor(),
      child: ListTile(
        onTap: () {
          if (notificationData.type == NotificationTypes.detectionFinished) {
            controller.deleteDetectionNotification(notificationData.id);
            Get.toNamed(RoutesClass.detailDetectionResult,
                parameters: {'id': notificationData.detectionId.toString()});
          } else {
            controller.deleteTaskNotification(
                notificationData.id, notificationData.type);
            Get.toNamed(RoutesClass.task, arguments: notificationData.taskId);
          }
        },
        title: _createTitle(),
        subtitle: Text(DateFormat('yMMMMd', 'ru')
            .format(DateTime.parse(notificationData.createDateTime))),
        trailing: IconButton(
            splashRadius: 20,
            tooltip: "удалить",
            onPressed: () {
              if (notificationData.type ==
                  NotificationTypes.detectionFinished) {
                controller.deleteDetectionNotification(notificationData.id);
              } else {
                controller.deleteTaskNotification(
                    notificationData.id, notificationData.type);
              }
            },
            icon: const Icon(Icons.close)),
      ),
    );
  }

  Widget _createTitle() {
    if (notificationData.type == NotificationTypes.answerType) {
      return const Text("Добавлен ответ на задачу");
    } else if (notificationData.type == NotificationTypes.newTaskType) {
      return const Text("Создана новая задача");
    } else if (notificationData.type == NotificationTypes.closeTaskType) {
      return const Text("Куратор закрыл задачу");
    } else if (notificationData.type == NotificationTypes.detectionFinished) {
      return const Text("Детектирование закончено");
    } else {
      return const Text("");
    }
  }

  Color _getNotificationColor() {
    if (notificationData.type == NotificationTypes.answerType) {
      return CustomColors.completedTaskColor;
    } else if (notificationData.type == NotificationTypes.newTaskType) {
      return CustomColors.currentTaskColor;
    } else if (notificationData.type == NotificationTypes.closeTaskType) {
      return CustomColors.completedTaskColor;
    } else if (notificationData.type == NotificationTypes.detectionFinished) {
      return CustomColors.currentTaskColor;
    } else {
      return Colors.white;
    }
  }
}
