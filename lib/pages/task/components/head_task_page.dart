import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/utils/helpers/extension.dart';

import '../../../utils/constants.dart';
import '../controller/task_controller.dart';

class HeadTaskPage extends GetView<TaskController> {
  const HeadTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
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
                color: _getColor()),
            child: Text((() {
              if (controller.task.value.isDone) {
                return "выполнено";
              } else if (controller.task.value.isExpired) {
                return "просроченно";
              }
              return "на исполнении";
            })()),
          ),
        ],
      ),
    );
  }

  MaterialColor _getColor() {
    if (controller.task.value.isDone) {
      return Colors.green;
    } else if (controller.task.value.isExpired) {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }
}
