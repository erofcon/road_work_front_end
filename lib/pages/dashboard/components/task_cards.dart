import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../routes/routes.dart';
import '../../../shared_components/task_card_list.dart';

class TaskCards extends GetView<DashboardController> {
  const TaskCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiConstants.defaultPadding * 2),
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.taskData.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: UiConstants.defaultPadding),
            child: CardTask(
              taskData: controller.taskData[index],
            ),
          ),
        ),
      ),
    );
  }
}

class CardTask extends StatelessWidget {
  const CardTask({
    required this.taskData,
    Key? key,
  }) : super(key: key);

  final TaskCardInfo taskData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiConstants.defaultPadding * 2),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [taskData.primary, taskData.primary.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: _BackgroundDecoration(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLabel(),
                          const SizedBox(height: 20),
                          _buildTaskCount(),
                        ],
                      ),
                    ),
                    _doneButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      taskData.title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: taskData.textColor,
        letterSpacing: 1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTaskCount() {
    return Text(
      taskData.count.toString(),
      style: TextStyle(
        color: taskData.textColor,
        fontSize: 40,
        letterSpacing: 1,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _doneButton() {
    return ElevatedButton.icon(
      onPressed: () =>
          Get.toNamed(RoutesClass.taskList, arguments: taskData.routArguments),
      style: ElevatedButton.styleFrom(
        primary: taskData.primary,
        onPrimary: taskData.textColor,
      ),
      icon: const Icon(Icons.open_in_new),
      label: const Text("open"),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -25),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Transform.translate(
            offset: const Offset(-70, 70),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
