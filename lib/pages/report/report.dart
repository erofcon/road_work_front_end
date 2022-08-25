import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/report/controller/report_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import 'components/bar_chart.dart';
import 'components/legend.dart';
import 'components/report_controller.dart';

class ReportPage extends GetView<ReportController> {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(UiConstants.defaultPadding),
        child: Column(
          children: <Widget>[
            const ReportChange(),
            LegendsListWidget(
              legends: [
                Legend("Все задачи", Colors.blue),
                Legend("Выполненые задачи", Colors.green),
                Legend("Просроченные задачи", Colors.red),
              ],
            ),
            const SizedBox(
              height: UiConstants.defaultPadding,
            ),
            Obx(() {
              if (controller.isLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Flexible(
                  child: controller.barGroups.isNotEmpty
                      ? const Chart()
                      : Container(),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
