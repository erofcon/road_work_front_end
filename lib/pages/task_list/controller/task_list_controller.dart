import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task_list/models/task_list.dart';

import '../../../service/api_service.dart';

class TaskListController extends GetxController {
  final isLoading = true.obs;
  late  Rx<TaskList> taskList;

  @override
  void onInit() {
    getTaskList();
    super.onInit();
  }

  void getTaskList() async {
    isLoading(true);
    taskList = (await ApiService().getTaskList())!.obs;
    isLoading(false);
  }
}
