import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:road_work_front_end/shared_components/task_card_list.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../shared_components/chart_data.dart';

class TasksStatistic extends StatelessWidget {
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
              padding:
                  const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding),
              child: StatisticTaskInfo(hoverColor: taskData[index].primary.withOpacity(0.4), borderColor: taskData[index].primary),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticTaskInfo extends StatelessWidget {
  const StatisticTaskInfo({Key? key, required this.hoverColor, required this.borderColor})
      : super(key: key);

  final Color hoverColor;
  final Color borderColor;

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
        leading: _buildIcon(),
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '23.10.1996 16:00',
      style: TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'ямочный ремонт',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildIcon() {
    return const CircleAvatar(
      backgroundImage: NetworkImage(
          'https://i.pinimg.com/originals/e9/e0/75/e9e075386271a5449e62e885cd8fa226.jpg'),
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
