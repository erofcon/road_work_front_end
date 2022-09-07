import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/colors.dart';
import '../../../utils/constants.dart';
import '../controller/task_controller.dart';

class HeadTaskPage extends GetView<TaskController> {
  const HeadTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat('yMMMMd', 'ru').format(
                      DateTime.parse(controller.task.value.createDateTime)),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: UiConstants.defaultPadding*0.2,),
                Text(
                  controller.task.value.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: CustomColors.iconColor,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.2),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(UiConstants.defaultPadding),
                      color: _getColor()),
                  child: Text(
                    (() {
                      if (controller.task.value.isDone) {
                        return "выполнено";
                      } else if (controller.task.value.isExpired) {
                        return "просроченно";
                      }
                      return "на исполнении";
                    })(),
                    style: TextStyle(
                        fontSize: 10, color: CustomColors.customTextColor),
                  ),
                ),
                const SizedBox(
                  height: UiConstants.defaultPadding * 0.2,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.orangeAccent,
                  ),
                  child: Padding(
                      padding:
                          const EdgeInsets.all(UiConstants.defaultPadding * 0.2),
                      child: Text(
                        (() {
                          return controller.task.value.category.name;
                        })(),
                        style: TextStyle(
                            fontSize: 10, color: CustomColors.customTextColor),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    if (controller.task.value.isDone) {
      return CustomColors.completedTaskColor;
    } else if (controller.task.value.isExpired) {
      return CustomColors.expiredTaskColor;
    } else {
      return CustomColors.currentTaskColor;
    }
  }
}
