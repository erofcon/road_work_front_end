import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../utils/responsive.dart';


class TaskData extends GetView<TaskController> {
  const TaskData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.all(ResponsiveBuilder.isMobile(context) ? 0 : UiConstants.defaultPadding * 2),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(UiConstants.defaultPadding),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Card(
                        margin: const EdgeInsets.all(0),
                        color: Colors.yellow,
                        child: Padding(
                            padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.5),
                            child: Text(controller.task.value.category.name))),
                    Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: UiConstants.defaultPadding),
                        color: Colors.teal,
                        child: Padding(
                            padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.5),
                            child: Text(
                                ((){
                                  if(controller.task.value.isDone){
                                    return "done";
                                  }else if(controller.task.value.isExpired){
                                    return "expired";
                                  }
                                  return "on continue";
                                })()

                            ))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: UiConstants.defaultPadding),
                  child: Text(controller.task.value.description),
                ),
                const SizedBox(
                  height: UiConstants.defaultPadding * 0.5,
                ),
                Text("Срок выполнения: ${controller.task.value.leadDateTime}"),
              ],
            ),
          ),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          Container(
            padding: const EdgeInsets.all(UiConstants.defaultPadding),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Исполнитель", style: TextStyle(fontSize: 19)),
                const SizedBox(
                  height: UiConstants.defaultPadding * 0.3,
                ),
                Text('${controller.task.value.executor.firstName} ${controller.task.value.executor.lastName}',
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(
                  height: UiConstants.defaultPadding,
                ),
                Text(controller.task.value.executor.numberPhone),
                Text(controller.task.value.executor.email),
              ],
            ),
          ),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          // Container(
          //   width: double.infinity,
          //   constraints: const BoxConstraints(maxHeight: 500),
          //   child: const Map(),
          // ),
        ],
      ),
    );
  }
}
