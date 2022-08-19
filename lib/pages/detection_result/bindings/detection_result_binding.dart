import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

class DetectionResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetectionResultController());
  }
}
