import 'dart:io';

import 'package:get/get.dart';
import 'package:road_work_front_end/login/models/login_response.dart';
import 'package:road_work_front_end/utils/constants.dart';

class LoginService extends GetConnect {
  Future<LoginResponse?> login(LoginResponse model) async {
    final response = await post(ApiUrl.authenticate, model.toJson(),);

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
