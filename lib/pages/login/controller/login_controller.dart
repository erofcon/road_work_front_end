import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:road_work_front_end/pages/login/models/login_request.dart';
import 'package:road_work_front_end/pages/login/models/login_response.dart';
import 'package:road_work_front_end/pages/login/service/login_cache.dart';


import '../../../service/api_service.dart';

class LoginController extends GetxController with LoginCache {
  final ApiService _loginService = ApiService();

  final TextEditingController loginEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final formKey = GlobalKey<FormState>().obs;
  final checkKeepUser = false.obs;
  final sendingData = false.obs;
  final loginError = false.obs;
  final isLogin = false.obs;

  User? user;

  void checkLoginStatus() {
    final box = GetStorage();
    var token = box.read('token');
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
