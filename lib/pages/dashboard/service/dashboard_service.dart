import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:road_work_front_end/pages/dashboard/models/count_tasks_response.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../login/service/login_cache.dart';

class DashboardService extends GetConnect with LoginCache {
  Future<CountTasks?> getCountTasks() async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      final response = await get(ApiUrl.getCountTasks, headers: headers);

      if(response.statusCode == HttpStatus.ok){
        return countTasks(response.bodyString!);
      }else{
        return null;
      }
    }

    return null;
  }
}
