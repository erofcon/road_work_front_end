class ApiUrl {
  static const String url = 'http://192.168.1.34:8000';
  static const String authenticate = '$url/api/v1/token/';
  static const String getCountTasks = '$url/api/v1/task/get/counttask';
  static const String getRelatedUser = '$url/api/v1/token/related_user';
  static const String getTaskCategory = '$url/api/v1/task/get/category';
  static const String createSingleTask = '$url/api/v1/task/post/create';
  static const String uploadDetection = '$url/api/v1/detection/post/run';
  static const String getTaskList = '$url/api/v1/task/get';
}

class UiConstants {
  static const double defaultPadding = 16;
}
