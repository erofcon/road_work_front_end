import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/utils/helpers/extension.dart';

import '../../../utils/constants.dart';
import '../controller/task_controller.dart';

class HeadTaskPage extends GetView<TaskController> {
  const HeadTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          DateTime.parse(controller.task.value.createDateTime).formatdMMMMY(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiConstants.defaultPadding),
              color: controller.task.value.isDone?Colors.green[400]:Colors.orange),
          child: Text(controller.task.value.state),
        ),
      ],
    );
  }
}
