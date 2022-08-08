import 'package:get/get.dart';
import 'package:road_work_front_end/create_task/create_task_page.dart';
import 'package:road_work_front_end/home/home_page.dart';

import '../../detection_result/detection_result_page.dart';

class NavigationController extends GetxController {
  final navBarSelectedIndex = 0.obs;

  final pages = [
    const InformationPage(),
    const CreateTaskPage(),
    const DetectionResultPage()
  ].obs;
}
