import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:road_work_front_end/routes/routes.dart';
import 'package:road_work_front_end/shared_components/theme_service.dart';
import 'package:road_work_front_end/theme/theme.dart';

import 'localization/localization.dart';
import 'pages/login/controller/login_controller.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

Future<void> initialize() async {
  await GetStorage.init();
  initializeDateFormatting();
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
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesClass.home,
              getPages: RoutesClass.routes,
              theme: Themes().lightTheme,
              darkTheme: Themes().darkTheme,
              themeMode: ThemeService().getThemeMode(),
              translations: Localization(),
              locale: const Locale('ru', 'RU'),
              scrollBehavior: CustomScrollBehaviour(),
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

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
