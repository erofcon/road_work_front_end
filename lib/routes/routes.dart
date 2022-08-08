import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/home/home_page.dart';
import 'package:road_work_front_end/pages/login/login_page.dart';

import '../pages/login/controller/login_controller.dart';

class RoutesClass {
  static String home = '/';
  static String login = '/login';

  static List<GetPage> routes = [
    GetPage(
        name: home, page: () => const HomePage(), middlewares: [AuthGuard()]),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
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
