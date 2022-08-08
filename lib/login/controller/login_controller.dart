import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:road_work_front_end/login/models/login_request.dart';
import 'package:road_work_front_end/login/models/login_response.dart';
import 'package:road_work_front_end/login/service/login_cache.dart';
import 'package:road_work_front_end/login/service/login_service.dart';
import 'package:road_work_front_end/routes/routes.dart';

class LoginController extends GetxController with LoginCache {
  final LoginService _loginService = LoginService();

  final TextEditingController loginEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final formKey = GlobalKey<FormState>().obs;
  final checkKeepUser = false.obs;
  final sendingData = false.obs;
  final loginError = false.obs;
  final isLogin = false.obs;

  User? user;
  String? token;

  void checkLoginStatus() {
    final box = GetStorage();
    token = box.read('token');
    if (token == null) {
      isLogin.value = false;
      return;
    }

    String? res = box.read('user');
    if (res == null) {
      isLogin.value = false;
      return;
    }

    user = currentUser(box.read('user'));
    isLogin.value = true;
  }

  Future<bool> login() async {
    sendingData.toggle();
    LoginRequest loginRequest = LoginRequest(
        username: loginEditingController.text,
        password: passwordEditingController.text);
    LoginResponse? loginResponse = await _loginService.login(loginRequest);

    if (loginResponse != null) {
      user = loginResponse.user;
      token = loginResponse.access;
      await saveUser(loginResponse);
      sendingData.toggle();
      isLogin.value = true;
      return true;
    } else {
      sendingData.toggle();
      loginError.toggle();
      return false;
    }
  }
}
