import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/create_task/create_task.dart';
import 'package:road_work_front_end/pages/dashboard/bindings/dashboard_binding.dart';
import 'package:road_work_front_end/pages/dashboard/dashboard_page.dart';
import 'package:road_work_front_end/pages/detection_result/bindings/detection_result_binding.dart';
import 'package:road_work_front_end/pages/detection_result/detection_result.dart';
import 'package:road_work_front_end/pages/detection_result_list/detection_result_list.dart';
import 'package:road_work_front_end/pages/login/login_page.dart';
import 'package:road_work_front_end/pages/map/map_page.dart';
import 'package:road_work_front_end/pages/report/report.dart';
import 'package:road_work_front_end/pages/task_list/task_list_page.dart';

import '../pages/create_task/bindings/create_task_bindings.dart';
import '../pages/detection_result_list/bindings/detection_result_list_bindings.dart';
import '../pages/login/controller/login_controller.dart';
import '../pages/map/bindings/map_bindings.dart';
import '../pages/task/bindings/task_bindings.dart';
import '../pages/task/task_page.dart';
import '../pages/task_list/bindings/task_list_bindings.dart';
import '../pages/report/bindings/report_bindings.dart';

class RoutesClass {
  static String home = '/';
  static String login = '/login';
  static String create = '/create';
  static String taskList = '/list';
  static String task = '/task';
  static String detectionResult = '/result';
  static String detailDetectionResult = '/detailResult';
  static String map = '/map';
  static String report = '/report';

  static List<GetPage> routes = [
    GetPage(
        name: home,
        page: () => const HomePage(),
        binding: DashboardBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
        name: create,
        page: () => const CreateTask(),
        binding: CreateTaskBinding(),
        middlewares: [AuthGuard(), HasCreateAccess()]),
    GetPage(
        name: taskList,
        page: () => const TaskListPage(),
        binding: TaskListBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: task,
        page: () => const TaskPage(),
        binding: TaskBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: detectionResult,
        page: () => const DetectionResultListPage(),
        binding: DetectionResultListBinding(),
        middlewares: [AuthGuard(), HasWatchAccess()]),
    GetPage(
        name: detailDetectionResult,
        page: () => const DetectionResultPage(),
        binding: DetectionResultBinding(),
        middlewares: [AuthGuard(), HasWatchAccess()]),
    GetPage(
        name: map,
        page: () => const MapPage(),
        binding: MapPageBinding(),
        middlewares: [AuthGuard()]),
    GetPage(name: report, page: () => const ReportPage(),
        binding: ReportPageBinding(),
        middlewares: [AuthGuard(), UserIsAdmin()]),
  ];
}

class AuthGuard extends GetMiddleware {
  final authService = Get.find<LoginController>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isLogin.value
        ? null
        : RouteSettings(name: RoutesClass.login);
  }
}

class HasCreateAccess extends GetMiddleware {
  final authService = Get.find<LoginController>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user?.isCreator == true
        ? null
        : RouteSettings(name: RoutesClass.login);
  }
}

class HasWatchAccess extends GetMiddleware {
  final authService = Get.find<LoginController>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user?.isCreator == true ||
            authService.user?.isSuperUser == true
        ? null
        : RouteSettings(name: RoutesClass.login);
  }
}

class UserIsAdmin extends GetMiddleware {
  final authService = Get.find<LoginController>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user?.isSuperUser == true
        ? null
        : RouteSettings(name: RoutesClass.login);
  }
}
