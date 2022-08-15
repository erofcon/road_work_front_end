import 'package:get/get.dart';
import 'package:road_work_front_end/pages/create_task/controller/create_task_controller.dart';

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTaskController());
  }
}
