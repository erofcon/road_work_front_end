import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';

import '../../../theme/colors.dart';
import '../../../utils/constants.dart';

class User extends GetView<TaskController> {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: UiConstants.defaultPadding,
            left: UiConstants.defaultPadding * 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            (() {
              if (controller.loginController.user?.isExecutor == true) {
                return "Куратор";
              } else {
                return "Исполнитель";
              }
            })(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(
                top: UiConstants.defaultPadding,
                right: UiConstants.defaultPadding * 2),
            leading: _buildAvatar(),
            title: _buildName(),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.open_in_new,
                color: CustomColors.iconColor,
              ),
              splashRadius: 24,
            ),
          ),
        ]));
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: CustomColors.userColor,
      child: Text(
        (() {
          if (controller.loginController.user?.isExecutor == true) {
            return '${controller.task.value.creator.firstName[0].toUpperCase()}${controller.task.value.creator.lastName[0].toUpperCase()}';
          } else {
            return '${controller.task.value.executor.firstName[0].toUpperCase()}${controller.task.value.executor.lastName[0].toUpperCase()}';
          }
        })(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      (() {
        if (controller.loginController.user?.isExecutor == true) {
          return '${controller.task.value.creator.firstName} ${controller.task.value.creator.lastName}';
        } else {
          return '${controller.task.value.executor.firstName} ${controller.task.value.executor.lastName}';
        }
      })(),
      style: const TextStyle(
        fontSize: 13,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
