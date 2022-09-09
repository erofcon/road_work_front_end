class ApiUrl {
  static const String url = 'http://192.168.1.34:8000';

  static const String authenticate = '$url/api/v1/token/';
  static const String refreshToken = '$url/api/v1/refresh_token/';
  static const String getCountTasks = '$url/api/v1/task/get/counttask';
  static const String getRelatedUser = '$url/api/v1/token/related_user';
  static const String getTaskCategory = '$url/api/v1/task/get/category';
  static const String createSingleTask = '$url/api/v1/task/post/create';
  static const String uploadDetection = '$url/api/v1/detection/post/run';
  static const String getTaskList = '$url/api/v1/task/get';
  static const String createAnswer = '$url/api/v1/answer/post/create';
  static const String closeTask = '$url/api/v1/task/put/update';
  static const String detectionResultList = '$url/api/v1/detection/get';
  static const String detectionImageDelete =
      '$url/api/v1/detection/delete/image';
  static const String detectionDelete =
      '$url/api/v1/detection/delete/detection';
  static const String geoGeoJson = '$url/api/v1/map/get/geojson';
  static const String getTaskToMap = '$url/api/v1/map/get/tasktomap';
  static const String getReportCountTask = '$url/api/v1/report/get/counttask';
  static const String createReport = '$url/api/v1/report/get/createreport';
  static const String deleteTaskNotification =
      '$url/api/v1/notification/task/delete';
  static const String deleteDetectionNotification =
      '$url/api/v1/notification/detection/delete';
}

class UiConstants {
  static const double defaultPadding = 16;
}

class NotificationTypes {
  static String answerType = "answer";
  static String newTaskType = "new task";
  static String closeTaskType = "close task";
  static String detectionFinished = "detection finished";
}

class NotificationActions {
  static String getTaskNotificationList = "get_task_notification_list";
  static String getDetectionNotificationList =
      "get_detection_notification_list";
  static String subscribeTaskNotificationActivity =
      "subscribe_task_notification_activity";
  static String subscribeDetectionNotificationActivity =
      "subscribe_detection_notification_activity";
  static String delete = "delete";
}
