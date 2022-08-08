import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:road_work_front_end/pages/login/models/login_response.dart';

mixin LoginCache {
  Future<void> saveUser(LoginResponse model) async {
    final box = GetStorage();
    final user = json.encode(model.user);

    await box.write('user', user);
    await box.write('token', model.access);
    await box.write('refresh', model.access);
  }

  Future<String?> getToken() async {
    final box = GetStorage();
    return box.read('token');
  }

  Future<String?> getUser() async {
    final box = GetStorage();
    return box.read('user');
  }

  Future<String?> getRefreshToken() async {
    final box = GetStorage();
    return box.read('refresh');
  }

  Future<void> updateToken(String token) async {
    final box = GetStorage();
    await box.write('token', token);
  }

  Future<void> logout() async {
    final box = GetStorage();
    await box.erase();
  }
}
