import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../routes/routes.dart';
import '../../../theme/colors.dart';

class RecentTaskList extends GetView<DashboardController> {
  const RecentTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: context.height / 2),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        itemCount: controller.taskList!.results.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: UiConstants.defaultPadding),
          child: RecentTask(
            index: index,
          ),
        ),
      ),
    );
  }
}

class RecentTask extends GetView<DashboardController> {
  const RecentTask({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.defaultPadding)),
      onTap: () {
        Get.toNamed(RoutesClass.task,
            arguments: controller.taskList!.results[index].id);
      },
      leading: _buildImage(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: _buildStatus(),
    );
  }

  Widget _buildTitle() {
    return Text(
      DateFormat('yMMMMEEEEd', 'ru').format(DateTime.parse(
          controller.taskList!.results[index].createDateTime.toString())),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      controller.taskList!.results[index].description ?? '',
    );
  }

  Widget _buildImage() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: CustomColors.userColor,
      child: Text(
        (() {
          if (controller.loginController.user?.isExecutor == true) {
            return '${controller.taskList!.results[index].creator?.firstName[0].toUpperCase()}${controller.taskList!.results[index].creator?.lastName[0].toUpperCase()}';
          } else {
            return '${controller.taskList!.results[index].executor?.firstName[0].toUpperCase()}${controller.taskList!.results[index].executor?.lastName[0].toUpperCase()}';
          }
        })(),
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildStatus() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: _getStatusColor(),
          ),
          child: Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.2),
              child: Text(
                (() {
                  if (controller.taskList!.results[index].isDone ?? false) {
                    return "выполнено";
                  } else if (controller.taskList!.results[index].isExpired ??
                      false) {
                    return "просроченно";
                  }
                  return "на исполнении";
                })(),
                style: TextStyle(fontSize: 9, color: CustomColors.customTextColor),
              )),
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.orangeAccent,
          ),
          child: Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.2),
              child: Text(
                (() {
                  return controller.taskList!.results[index].category?.name ??
                      '';
                })(),
                style: TextStyle(fontSize: 10, color: CustomColors.customTextColor),
              )),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    if (controller.taskList!.results[index].isDone ?? false) {
      return CustomColors.completedTaskColor;
    } else if (controller.taskList!.results[index].isExpired ?? false) {
      return CustomColors.expiredTaskColor;
    } else {
      return CustomColors.currentTaskColor;
    }
  }
}
