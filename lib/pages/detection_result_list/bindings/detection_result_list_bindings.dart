import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result_list/controller/detection_result_list_controller.dart';

class DetectionResultListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetectionResultListController());
  }
}
