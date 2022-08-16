import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';
import 'package:road_work_front_end/utils/helpers/extension.dart';

import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import 'components/answer.dart';
import 'components/gallery.dart';
import 'components/heead_task_answer.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ResponsiveBuilder(
              mobileBuilder: (context, constraints) {
                return Container();
              },
              tabletBuilder: (context, constraints) {
                return Container();
              },
              desktopBuilder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: constraints.maxWidth > 1350 ? 10 : 9,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: _buildTaskContent(),
                        // child: const Gallery(),
                      ),
                    ),
                    SizedBox(
                      height: context.height,
                      child: const VerticalDivider(),
                    ),
                    Flexible(
                      flex: 4,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: _buildMap(),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskContent(){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding*2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: UiConstants.defaultPadding),
        Text(
          DateTime.parse(controller.task.value.createDateTime).formatdMMMMY(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: UiConstants.defaultPadding),
        const Gallery(),
        const SizedBox(height: UiConstants.defaultPadding*2),
        const HeadTaskAnswer(),
        const SizedBox(height: UiConstants.defaultPadding),
        const TaskAnswerList(),
      ],
    ),


      );
  }

  Widget _buildMap(){
    return Container();
  }


}
