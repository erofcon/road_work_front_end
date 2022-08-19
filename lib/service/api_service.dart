import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' as gtx;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:road_work_front_end/pages/create_task/models/task_category_response.dart';
import 'package:road_work_front_end/pages/dashboard/models/count_tasks_response.dart';
import 'package:road_work_front_end/pages/detection_result_list/models/detection_result_list_model.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../pages/dashboard/models/related_user_response.dart';
import '../pages/detection_result/models/detection_result_response.dart';
import '../pages/login/models/login_request.dart';
import '../pages/login/models/login_response.dart';
import '../pages/login/service/login_cache.dart';
import '../pages/task/models/task_response.dart';
import '../pages/task_list/models/task_list.dart';

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

  Future<void> runDetection(
      DateTime dateTime,
      PlatformFile file,
      Function(dynamic send, dynamic total) uploadProgress,
      Function() uploadComplete,
      Function() uploadFailure) async {
    final token = await getToken();
    if (token != null) {
      try {
        Map<String, String> headers = {"Authorization": "Bearer $token"};

        FormData formData = FormData.fromMap({
          'date': dateTime.toString(),
          'video':
              await MultipartFile.fromFile(file.path!, filename: file.name),
        });

        Response response = await Dio().post(ApiUrl.uploadDetection,
            data: formData,
            options: Options(headers: headers),
            onSendProgress: uploadProgress);

        if (response.statusCode! >= 200 && response.statusCode! < 210) {
          uploadComplete();
        } else {
          uploadFailure();
        }
      } catch (e) {
        uploadFailure();
      }
    }
  }

  Future<TaskList?> getTaskList() async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      final response = await Dio()
          .get(ApiUrl.getTaskList, options: Options(headers: headers));
      if (response.statusCode == HttpStatus.ok) {
        return taskResult(response.toString());
      } else {
        return null;
      }
    }
    return null;
  }

  Future<TaskResponseModel?> getTask(String id) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      final response = await Dio()
          .get('${ApiUrl.getTaskList}/$id', options: Options(headers: headers));
      if (response.statusCode == HttpStatus.ok) {
        return taskResponseModel(response.toString());
      } else {
        return null;
      }
    }
    return null;
  }

  Future<Answer?> createAnswer(
      String taskId, String? description, List<PlatformFile>? files) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      FormData formData = FormData.fromMap({
        'task': taskId,
        'description': description ?? '',
      });

      if (files != null) {
        for (PlatformFile file in files) {
          formData.files.addAll([
            MapEntry(
                "images",
                GetPlatform.isWeb
                    ? MultipartFile.fromBytes(file.bytes!.toList(),
                        filename: file.name)
                    : await MultipartFile.fromFile(file.path!,
                        filename: file.name))
          ]);
        }
      }

      Response response = await Dio().post(
        ApiUrl.createAnswer,
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.created) {
        return Answer.fromJson(response.data);
      }
    }
    return null;
  }

  Future<bool> closeTask(String taskId) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      String url = '${ApiUrl.closeTask}/$taskId';

      Response response = await Dio().put(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
    }
    return false;
  }

  Future<List<DetectionResultListResponse>?> getDetectionList() async {
    final token = await getToken();
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      Response response = await Dio().get(
        ApiUrl.detectionResultList,
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.ok) {
        return List<DetectionResultListResponse>.from(response.data
            .map((dynamic row) => DetectionResultListResponse.fromJson(row)));
      }
    }
    return null;
  }

  Future<DetectionResultResponse?> getDetailDetection(String id) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      Response response = await Dio().get(
        '${ApiUrl.detectionResultList}/$id',
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.ok) {
        return DetectionResultResponse.fromJson(response.data);
      }
    }

    return null;
  }
}