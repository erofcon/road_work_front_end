import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task_list/controller/task_list_controller.dart';

class TaskListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskListController());
  }
}
