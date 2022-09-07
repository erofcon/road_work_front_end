import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../../../service/web_service.dart';
import '../models/report_get_count_task_response.dart';

class ReportController extends GetxController {
  final isLoading = true.obs;

  ReportGetCountTaskResponse? reportGetCountTaskResponse;
  List<BarChartGroupData> barGroups = [];

  final startTime = DateTime(DateTime.now().year, DateTime.now().month - 2).obs;
  final endDateTime = DateTime.now().obs;

  @override
  void onInit() {
    getReportCountTask();
    super.onInit();
  }

  void getReportCountTask() async {
    isLoading(true);
    barGroups.clear();
    reportGetCountTaskResponse = await ApiService()
        .reportGetCountTask(startTime.value, endDateTime.value);

    for (var i = 0; i < reportGetCountTaskResponse!.labels.length; i++) {
      barGroups.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
          toY: reportGetCountTaskResponse!.datasets.countAllTasks[i].toDouble(),
          color: Colors.blue,
        ),
        BarChartRodData(
          toY: reportGetCountTaskResponse!.datasets.countExecutedTasks[i]
              .toDouble(),
          color: Colors.green,
        ),
        BarChartRodData(
          toY: reportGetCountTaskResponse!.datasets.countExpiredTasks[i]
              .toDouble(),
          color: Colors.red,
        ),
      ]));
    }

    isLoading(false);
  }

  void createReport() async{
    // if(GetPlatform.isWeb){
    //   await WebService().createReport(startTime.value, endDateTime.value);
    // }else{
    //   await ApiService().createReport(startTime.value, endDateTime.value);
    // }

    await ApiService().createReport(startTime.value, endDateTime.value);
  }
}
