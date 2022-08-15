import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' as gtx;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:road_work_front_end/pages/create_task/models/task_category_response.dart';
import 'package:road_work_front_end/pages/dashboard/models/count_tasks_response.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../pages/dashboard/models/related_user_response.dart';
import '../pages/login/models/login_request.dart';
import '../pages/login/models/login_response.dart';
import '../pages/login/service/login_cache.dart';

class ApiService with LoginCache {

  Future<LoginResponse?> login(LoginRequest model) async {
    final response =
        await Dio().post(ApiUrl.authenticate, data: model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponse.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<CountTasks?> getCountTasks() async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      final response = await Dio()
          .get(ApiUrl.getCountTasks, options: Options(headers: headers));

      if (response.statusCode == HttpStatus.ok) {
        return CountTasks.fromJson(response.data);
      } else {
        return null;
      }
    }

    return null;
  }

  Future<List<RelatedUser>?> getRelatedUser() async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      final response = await Dio()
          .get(ApiUrl.getRelatedUser, options: Options(headers: headers));

      if (response.statusCode == HttpStatus.ok) {
        return List<RelatedUser>.from(
            response.data.map((dynamic row) => RelatedUser.fromJson(row)));
      }
    }
    return null;
  }

  Future<List<TaskCategory>?> getTaskCategory() async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      final response = await Dio()
          .get(ApiUrl.getTaskCategory, options: Options(headers: headers));

      if (response.statusCode == HttpStatus.ok) {
        return List<TaskCategory>.from(
            response.data.map((dynamic row) => TaskCategory.fromJson(row)));
      }
    }
    return null;
  }

  Future<bool> createSingleTask(int categoryId, int executor, DateTime leadTime,
      {String? description,
      String? latitude,
      String? longitude,
      List<PlatformFile>? files}) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      FormData formData = FormData.fromMap({
        'category': categoryId.toString(),
        'description': description ?? '',
        'latitude': latitude ?? '',
        'longitude': longitude ?? '',
        'executor': executor.toString(),
        'leadDateTime': leadTime.toString(),
      });

      if (files != null) {
        for (PlatformFile file in files) {
          formData.files.addAll([
            MapEntry(
                "images",
                gtx.GetPlatform.isWeb
                    ? MultipartFile.fromBytes(file.bytes!.toList(),
                        filename: file.name)
                    : await MultipartFile.fromFile(file.path!,
                        filename: file.name))
          ]);
        }
      }

      Response response = await Dio().post(
        ApiUrl.createSingleTask,
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 210) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}
