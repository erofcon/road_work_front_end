import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/pages/report/controller/report_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';
import 'package:road_work_front_end/utils/helpers/date_time.dart';

class ReportChange extends GetView<ReportController> {
  const ReportChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlinedButton(onPressed: controller.createReport, child: const Text("Export")),
          const SizedBox(
            width: UiConstants.defaultPadding * 0.5,
          ),
          OutlinedButton(
              onPressed: () async {
                controller.startTime(await selectDate(context));
              },
              child: Text(
                DateFormat('MMM yyyy').format(controller.startTime.value),
              )),
          const SizedBox(
            width: UiConstants.defaultPadding * 0.5,
          ),
          OutlinedButton(
              onPressed: () async {
                controller.endDateTime(await selectDate(context));
              },
              child: Text(
                DateFormat('MMM yyyy').format(controller.endDateTime.value),
              )),
          IconButton(
              splashRadius: 20,
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.getReportCountTask();
                }
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
