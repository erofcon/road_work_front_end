import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';

import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import 'components/answer.dart';
import 'components/gallery.dart';
import 'components/head_task_answer.dart';
import 'components/head_task_page.dart';
import 'components/task_location.dart';
import 'components/user.dart';

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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTaskContent(),
                      const SizedBox(height: UiConstants.defaultPadding * 2),
                      _buildMapContent(),
                    ],
                  ),
                );
              },
              tabletBuilder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: constraints.maxWidth > 800 ? 8 : 7,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: _buildTaskContent(),
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
                        child: _buildMapContent(),
                      ),
                    ),
                  ],
                );
              },
              desktopBuilder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding*5),
                  child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: constraints.maxWidth > 1350 ? 10 : 9,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: _buildTaskContent(),
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
                              child: _buildMapContent(),
                            ),
                          ),
                        ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: UiConstants.defaultPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          SizedBox(height: UiConstants.defaultPadding),
          HeadTaskPage(),
          SizedBox(height: UiConstants.defaultPadding * 2),
          Gallery(),
          SizedBox(height: UiConstants.defaultPadding * 2),
          HeadTaskAnswer(),
          SizedBox(height: UiConstants.defaultPadding),
          TaskAnswerList(),
        ],
      ),
    );
  }

  Widget _buildMapContent() {
    return Column(
      children: <Widget>[
        const User(),
        const SizedBox(height: UiConstants.defaultPadding * 2),
        if (controller.task.value.latitude != null &&
            controller.task.value.longitude != null)
          const TaskLocation()
      ],
    );
  }
}
