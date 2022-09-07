import 'package:get/get.dart';

import '../controller/run_detection_controller.dart';
import '../controller/single_task_controller.dart';

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingleTaskController());
    Get.lazyPut(() => RunDetectionController());
  }
}
