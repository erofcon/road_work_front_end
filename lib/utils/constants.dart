class ApiUrl {
  static const String url = 'http://127.0.0.1:8000';
  static const String authenticate = '$url/api/v1/token/';
  static const String getCountTasks = '$url/api/v1/task/get/counttask';
  static const String getRelatedUser = '$url/api/v1/token/related_user';
  static const String getTaskCategory = '$url/api/v1/task/get/category';
  static const String createSingleTask = '$url/api/v1/task/post/create';
  static const String uploadDetection = '$url/api/v1/detection/post/run';
  static const String getTaskList = '$url/api/v1/task/get';
  static const String createAnswer = '$url/api/v1/answer/post/create';
  static const String closeTask = '$url/api/v1/task/put/update';
  static const String detectionResultList = '$url/api/v1/detection/get';
}

class UiConstants {
  static const double defaultPadding = 16;
}
