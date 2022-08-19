import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';

import '../../../utils/constants.dart';

class User extends GetView<TaskController> {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: UiConstants.defaultPadding),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            (() {
              if (controller.loginController.user?.isExecutor == true) {
                return "Куратор";
              } else {
                return "Исполнитель";
              }
            })(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: UiConstants.defaultPadding),
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.orange.withOpacity(.2),
          child: Text(
            (() {
              if (controller.loginController.user?.isExecutor == true) {
                return '${controller.task.value.creator.firstName[0].toUpperCase()}${controller.task.value.creator.lastName[0].toUpperCase()}';
              } else {
                return '${controller.task.value.executor.firstName[0].toUpperCase()}${controller.task.value.executor.lastName[0].toUpperCase()}';
              }
            })(),
            style: const TextStyle(
              fontSize: 30,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: UiConstants.defaultPadding),
        Column(
          children: <Widget>[_buildName(), _buildEmail(), _buildNumberPhone()],
        )
      ],
    );
  }

  Widget _buildName() {
    return Text(
      ((){
        if (controller.loginController.user?.isExecutor == true) {
          return '${controller.task.value.creator.firstName} ${controller.task.value.creator.lastName}';
        } else {
          return '${controller.task.value.executor.firstName} ${controller.task.value.executor.lastName}';
        }
      })(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEmail() {
    return Text(
      ((){
        if (controller.loginController.user?.isExecutor == true) {
          return controller.task.value.creator.email;
        } else {
          return controller.task.value.executor.email;
        }
      })(),
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNumberPhone() {
    return Text(
      ((){
        if (controller.loginController.user?.isExecutor == true) {
          return controller.task.value.creator.numberPhone;
        } else {
          return controller.task.value.executor.numberPhone;
        }
      })(),
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
