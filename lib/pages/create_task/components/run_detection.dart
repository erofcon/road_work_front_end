import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:road_work_front_end/pages/create_task/controller/create_task_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../utils/helpers/date_time.dart';

class RunDetection extends StatelessWidget {
  const RunDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTaskController>(
      builder: (controller) => Center(
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
              ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Colors.white,
                    side: const BorderSide(width: 1, color: Colors.black12),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.all(UiConstants.defaultPadding * 2),
                    width: context.width,
                    child: controller.runDateTime == null
                        ? const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.black,
                            size: 48,
                          )
                        : Text(
                            controller.runDateTime.toString(),
                            style: const TextStyle(color: Colors.black54),
                          ),
                  )),
              if (controller.errorSelect)
                Center(
                  child: Text('select_date_time'.tr.toLowerCase(), style: const TextStyle(color: Colors.red),),
                ),
              const SizedBox(
                height: UiConstants.defaultPadding,
              ),
              Text('select_video'.tr),
              const SizedBox(
                height: UiConstants.defaultPadding,
              ),
              ElevatedButton(
                  onPressed: (){
                    if(GetPlatform.isWeb){
                      controller.webSelectFile();
                    }else{
                      controller.ioSelectVideo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Colors.white,
                    side: const BorderSide(width: 1, color: Colors.black12),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.all(UiConstants.defaultPadding * 2),
                    width: context.width,
                    child: controller.videoFile == null
                        ? const Icon(
                            Icons.upload,
                            color: Colors.black,
                            size: 48,
                          )
                        : Text(controller.videoFile!.name,
                            style: const TextStyle(color: Colors.black)),
                  )),
              if (controller.errorSelect)
                Center(
                  child: Text('select_video'.tr.toLowerCase(), style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(
                height: UiConstants.defaultPadding * 0.5,
              ),
              Text(
                "video_description".tr,
                // S.of(context).accepted_video_types,
                style: const TextStyle(color: Colors.black45),
              ),
              const SizedBox(
                height: UiConstants.defaultPadding,
              ),
              const UploadProgress(),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadProgress extends GetView<CreateTaskController> {
  const UploadProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isUploadVideo.isTrue) {
        return  Center(child: CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 10.0,
          percent: controller.uploadProgress.value/100,
          progressColor: Theme.of(context).primaryColor,
        ));
      } else {
        return ElevatedButton(
          onPressed: () => controller.uploadVideo(),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: SizedBox(
            width: context.width,
            height: 35,
            child: Center(child: Text('upload'.tr)),
          ),
        );
      }
    });
  }
}
