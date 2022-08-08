import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/login/service/login_service.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();

  final TextEditingController loginEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  Rx<bool> checkKeepUser = false.obs;

  void keepUser(bool? value) {
    checkKeepUser.value = value!;
  }

  void login(){

  }

}
