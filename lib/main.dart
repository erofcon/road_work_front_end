import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:road_work_front_end/login/login_page.dart';
import 'package:road_work_front_end/login/service/login_service.dart';

import 'login/controller/login_controller.dart';

void main() async {
  await initialize();
  runApp(const MyApp());
}

Future<void> initialize() async {
  Get.lazyPut(() => LoginController());
  await GetStorage.init();
}

class MyApp extends GetWidget<LoginController>{
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
    );
  }


}
