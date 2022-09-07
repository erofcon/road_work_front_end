import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../theme/colors.dart';
import '../../../utils/helpers/date_time_select.dart';
import '../controller/run_detection_controller.dart';

class RunDetection extends StatelessWidget {
  const RunDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
            top: UiConstants.defaultPadding * 3,
            left: UiConstants.defaultPadding,
            right: UiConstants.defaultPadding),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text('select_date_time'.tr),
            const SizedBox(
              height: UiConstants.defaultPadding,
            ),
            const DateTimeSelect(),
            const SizedBox(
              height: UiConstants.defaultPadding,
            ),
            Text('select_video'.tr),
            const SizedBox(
              height: UiConstants.defaultPadding,
            ),
            const SelectFile(),
            const SizedBox(
              height: UiConstants.defaultPadding * 0.5,
            ),
            Text(
              "video_description".tr,
              style: TextStyle(color: CustomColors.iconColor),
            ),
            const SizedBox(
              height: UiConstants.defaultPadding,
            ),
            const UploadProgress(),
          ],
        ),
      ),
    );
  }
}

class DateTimeSelect extends GetView<RunDetectionController> {
  const DateTimeSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: context.width,
        child: ElevatedButton.icon(
          onPressed: () async {
            final date = await selectDate(context);
            if (date == null) return;

            final time = await selectTime(context);
            if (time == null) return;

            DateTime dateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            controller.selectDateTime(dateTime);
          },
          icon: controller.runDateTime.value == null
              ? const Icon(Icons.access_time)
              : const Icon(null),
          label: controller.runDateTime.value == null
              ? const Text("Дата и время выезда")
              : Text(DateFormat('yMMMMd', 'ru').format(
                  DateTime.parse(controller.runDateTime.value.toString()))),
        ),
      ),
    );
  }
}

class SelectFile extends GetView<RunDetectionController> {
  const SelectFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: context.width,
        child: ElevatedButton.icon(
          onPressed: () {
            if (GetPlatform.isWeb) {
              controller.webSelectFile();
            } else {
              controller.ioSelectVideo();
            }
          },
          icon: controller.videoFile.value == null
              ? const Icon(Icons.video_call_outlined)
              : const Icon(Icons.check_circle_outline),
          label: controller.videoFile.value == null
              ? const Text("Видео файл")
              : const Text("Видео файл выбран"),
        ),
      ),
    );
  }
}

class UploadProgress extends GetView<RunDetectionController> {
  const UploadProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isUploadVideo.isTrue) {
        return Center(
            child: CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 10.0,
          percent: controller.uploadProgress.value / 100,
          progressColor: Theme.of(context).primaryColor,
        ));
      } else {
        return Column(
            children: <Widget>[
              SizedBox(
                width: context.width,
                child: ElevatedButton.icon(
                  onPressed: () => controller.uploadVideo(),
                  icon: const Icon(Icons.upload),
                  label: Text('upload'.tr),
                ),
              ),
              if(controller.errorSelect.isTrue)
                const Text("Обязательные поляне выбраны", style: TextStyle(color: Colors.red),)
            ],
        );
      }
    });
  }
}
