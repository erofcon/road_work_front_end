
import 'dart:convert';

TaskNotificationResponse taskNotificationResponse(String str) =>
    TaskNotificationResponse.fromJson(json.decode(str));


class TaskNotificationResponse {
  TaskNotificationResponse({
    required this.errors,
    required this.data,
    required this.action,
    required this.responseStatus,
    required this.requestId,
  });

  late final List<dynamic> errors;
  late final List<Data> data;
  late final String action;
  late final int responseStatus;
  late final String requestId;

  TaskNotificationResponse.fromJson(Map<String, dynamic> json) {
    errors = List.castFrom<dynamic, dynamic>(json['errors']);
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    action = json['action'];
    responseStatus = json['response_status'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['errors'] = errors;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['action'] = action;
    _data['response_status'] = responseStatus;
    _data['request_id'] = requestId;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.type,
    this.taskId,
    this.relatedUser,
    this.detectionId,
    this.recipient,
    required this.createDateTime,
  });

  late final int id;
  late final String type;
  int? taskId;
  int? relatedUser;
  int? detectionId;
  int? recipient;
  late final String createDateTime;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    taskId = json['task_id'];
    relatedUser = json['related_user'];
    detectionId = json['detection_id'];
    recipient = json['recipient'];
    createDateTime = json['createDateTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['task_id'] = taskId;
    data['related_user'] = relatedUser;
    data['createDateTime'] = createDateTime;
    return data;
  }
}
