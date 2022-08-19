

import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/models/detection_result_response.dart';
import 'package:road_work_front_end/service/api_service.dart';

class DetectionResultController extends GetxController{

  final isLoading = true.obs;
  late Rx<DetectionResultResponse?> detectionResult;
  final selectedIndex = <int>[].obs;
  bool isLongPress = false;

  @override
  void onInit() {
    getDetectionResult();
    super.onInit();
  }

  void getDetectionResult()async{
    detectionResult = (await ApiService().getDetailDetection(Get.parameters['id']!)).obs;
    isLoading(false);
  }

  void insertSelectIndex(int index){
    selectedIndex.add(index);
  }

  void deleteSelectIndex(int index){
    selectedIndex.remove(index);
  }


}