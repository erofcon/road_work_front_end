import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

class TaskDescription extends GetView<DetectionResultController> {
  const TaskDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Full-screen dialog"),
      ),
    );
  }
}
