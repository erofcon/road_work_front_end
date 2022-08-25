import 'package:get/get.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../models/detection_result_list_model.dart';

class DetectionResultListController extends GetxController {
  final isLoading = true.obs;
  late Rx<List<DetectionResultListResponse>?> detectionList;
  final isDeleting = false.obs;

  @override
  void onInit() {
    getDetectionList();
    super.onInit();
  }

  void getDetectionList() async {
    detectionList = (await ApiService().getDetectionList()).obs;
    isLoading(false);
  }

  void deleteDetection(int index) async {
    isDeleting(true);
    bool result = await ApiService().deleteDetection(index.toString());
    if (result) {
      detectionList.update((val) {
        val!.removeWhere((element) {
          return element.id == index;
        });
      });
      Get.back();
    }
    isDeleting(false);
  }
}
