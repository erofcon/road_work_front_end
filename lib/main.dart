import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:road_work_front_end/routes/routes.dart';
import 'package:road_work_front_end/theme/theme.dart';

import 'localization/localization.dart';
import 'login/controller/login_controller.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

Future<void> initialize() async {
  await GetStorage.init();
  Get.lazyPut<LoginController>(() => LoginController());
}

class MyApp extends GetWidget<LoginController> {
  const MyApp({Key? key}) : super(key: key);

  Future<void> initialize() async {
    controller.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    controller.checkLoginStatus();
    return FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
              initialRoute: RoutesClass.home,
              getPages: RoutesClass.routes,
              theme: Themes().lightTheme,
              darkTheme: Themes().darkTheme,
              translations: Localization(),
              locale: const Locale('ru', 'RU'),
              fallbackLocale: const Locale('en', 'US'));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
