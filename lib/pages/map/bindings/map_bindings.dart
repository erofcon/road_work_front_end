import 'package:get/get.dart';

import '../controller/map_controller.dart';

class MapPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapPageController());
  }
}
