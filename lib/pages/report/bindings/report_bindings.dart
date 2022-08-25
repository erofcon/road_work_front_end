import 'package:get/get.dart';
import 'package:road_work_front_end/pages/report/controller/report_controller.dart';

class ReportPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportController());
  }
}
