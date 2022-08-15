import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../shared_components/chart_data.dart';

class TasksStatistic extends GetView<DashboardController> {
  const TasksStatistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: UiConstants.defaultPadding),
      child: Column(
        children: <Widget>[
          const Chart(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiConstants.defaultPadding),
              child: StatisticTaskInfo(
                  title: controller.taskData[index].title,
                  subtitle: controller.taskData[index].count.toString(),
                  hoverColor:
                      controller.taskData[index].primary.withOpacity(.1),
                  borderColor: controller.taskData[index].primary,
                  iconWidget: controller.taskData[index].iconWidget),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticTaskInfo extends StatelessWidget {
  const StatisticTaskInfo(
      {Key? key,
      required this.hoverColor,
      required this.borderColor,
      required this.title,
      required this.subtitle,
      required this.iconWidget})
      : super(key: key);

  final Color hoverColor;
  final Color borderColor;
  final String title;
  final String subtitle;
  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: UiConstants.defaultPadding / 2),
      child: ListTile(
        hoverColor: hoverColor,
        onTap: () {},
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(
            UiConstants.defaultPadding,
          ),
        ),
        leading: iconWidget,
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: PieChart(
          PieChartData(
              startDegreeOffset: 180,
              sections: taskChartData,
              centerSpaceRadius: double.infinity),
        ));
  }
}
