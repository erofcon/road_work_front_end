import 'package:get/get.dart';
import 'package:road_work_front_end/service/api_service.dart';

import '../models/detection_result_list_model.dart';

class DetectionResultListController extends GetxController {
  final isLoading = true.obs;
  late Rx<List<DetectionResultListResponse>?> detectionList;

  @override
  void onInit() {
    getDetectionList();
    super.onInit();
  }

  void getDetectionList() async {
    detectionList = (await ApiService().getDetectionList()).obs;
    isLoading(false);
  }
}
