import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' as gtx;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:road_work_front_end/pages/create_task/models/task_category_response.dart';
import 'package:road_work_front_end/pages/dashboard/models/count_tasks_response.dart';
import 'package:road_work_front_end/pages/detection_result_list/models/detection_result_list_model.dart';
import 'package:road_work_front_end/pages/map/models/geo_json_response.dart';
import 'package:road_work_front_end/pages/map/models/get_task_to_map_response.dart';
import 'package:road_work_front_end/pages/report/models/report_get_count_task_response.dart';
import 'package:road_work_front_end/utils/constants.dart';
import 'package:universal_html/html.dart' as html;
import 'package:web_socket_channel/web_socket_channel.dart';

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

  Future<TaskList?> getTaskList(int page, String value) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      final response = await Dio().get(ApiUrl.getTaskList,
          options: Options(headers: headers),
          queryParameters: {'page': page, 'value': value});
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

  Future<bool> createSingleTaskFromDetection(
      int categoryId, int executor, DateTime leadTime,
      {String? description,
      String? latitude,
      String? longitude,
      List<String>? urls}) async {
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

      if (urls != null) {
        int i = 0;
        for (String url in urls) {
          var res = await Dio()
              .get(url, options: Options(responseType: ResponseType.bytes));
          Uint8List imageBytes = res.data;
          formData.files.addAll([
            MapEntry(
                "images",
                MultipartFile.fromBytes(imageBytes.toList(),
                    filename: "img$i.jpg"))
          ]);
          i++;
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

  Future<bool> deleteImageFromDetection(String id) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().delete(
        '${ApiUrl.detectionImageDelete}/$id',
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.noContent) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  Future<bool> deleteDetection(String id) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().delete(
        '${ApiUrl.detectionDelete}/$id',
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.noContent) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  Future<GeoJsonResponse?> getGeoJson() async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().get(
        ApiUrl.geoGeoJson,
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.ok) {
        return GeoJsonResponse.fromJson(response.data);
      } else {
        return null;
      }
    }

    return null;
  }

  Future<List<GetTaskToMapResponse>?> getTaskToMap(LatLng latLng) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().get(
        ApiUrl.getTaskToMap,
        queryParameters: {'lat': latLng.latitude, 'lng': latLng.longitude},
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.ok) {
        return List<GetTaskToMapResponse>.from(response.data
            .map((dynamic row) => GetTaskToMapResponse.fromJson(row)));
      } else {
        return null;
      }
    }

    return null;
  }

  Future<ReportGetCountTaskResponse?> reportGetCountTask(
      DateTime start, DateTime end) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().get(
        ApiUrl.getReportCountTask,
        queryParameters: {'start': start.toString(), 'end': end.toString()},
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.ok) {
        return ReportGetCountTaskResponse.fromJson(response.data);
      } else {
        return null;
      }
    }

    return null;
  }

  Future<bool> createReport(DateTime start, DateTime end) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/ms-excel',
      };

      if (GetPlatform.isWeb) {
        var res = await Dio().get(ApiUrl.createReport,
            queryParameters: {'start': start.toString(), 'end': end.toString()},
            options:
                Options(headers: headers, responseType: ResponseType.bytes));

        final blob = html.Blob([res.data]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = '${DateTime.now().toString()}.xlsx';
        html.document.body?.children.add(anchor);

        anchor.click();

        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        await Permission.storage.request();
        bool hasPermission = await Permission.storage.request().isGranted;
        if (!hasPermission) return false;
        var dir = await getApplicationDocumentsDirectory();

        String fileName = '${DateTime.now().toString()}.xlsx';
        Dio dio = Dio();
        await dio.download(ApiUrl.createReport, "${dir.path}/$fileName",
            queryParameters: {'start': start.toString(), 'end': end.toString()},
            options: Options(headers: headers));
        OpenFile.open("${dir.path}/$fileName",
            type:
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      }
    }

    return false;
  }

  Future<void> connectWebSocket(Function getMessage) async {
    final token = await getToken();

    if (token != null) {
      final wsUrl =
          Uri.parse('ws://192.168.1.34:8000/ws/notification?token=$token');
      WebSocketChannel channel = WebSocketChannel.connect(wsUrl);

      Map<String, dynamic> getTaskNotificationList = {
        "action": "get_task_notification_list",
        "request_id": DateTime.now().toString()
      };
      Map<String, dynamic> getDetectionNotificationList = {
        "action": "get_detection_notification_list",
        "request_id": DateTime.now().toString()
      };
      Map<String, dynamic> subscribeTaskNotificationActivity = {
        "action": "subscribe_task_notification_activity",
        "request_id": DateTime.now().toString()
      };
      Map<String, dynamic> subscribeDetectionNotificationActivity = {
        "action": "subscribe_detection_notification_activity",
        "request_id": DateTime.now().toString()
      };

      channel.sink.add(json.encode(getTaskNotificationList));
      channel.sink.add(json.encode(getDetectionNotificationList));
      channel.sink.add(json.encode(subscribeTaskNotificationActivity));
      channel.sink.add(json.encode(subscribeDetectionNotificationActivity));

      channel.stream.listen((message) {
        getMessage(message);
      });
    }
  }

  Future<bool> deleteTaskNotification(int id, String type) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().delete(
        '${ApiUrl.deleteTaskNotification}/$id/$type',
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.noContent) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<bool> deleteDetectionNotification(int id) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      Response response = await Dio().delete(
        '${ApiUrl.deleteDetectionNotification}/$id',
        options: Options(headers: headers),
      );

      if (response.statusCode == HttpStatus.noContent) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
