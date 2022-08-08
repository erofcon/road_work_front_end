import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/login/controller/login_controller.dart';

import '../utils/constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
          height: 550.0,
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            child: Column(
              children: <Widget>[
                _loginField(),
                _passwordField(),
                _keepUser(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: "Login"),
      controller: controller.loginEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please send login";
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: "Password"),
      controller: controller.passwordEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please send password";
        }
        return null;
      },
    );
  }

  Widget _keepUser() {
    return Padding(
      padding: const EdgeInsets.only(top: UiConstants.defaultPadding),
      child: Row(
        children: <Widget>[
          Obx(() => Checkbox(
                value: controller.checkKeepUser.value,
                onChanged: controller.checkKeepUser,
              )),
          const Text('keep me')
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        print(controller.checkKeepUser.value);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.teal),
        elevation: MaterialStateProperty.all(10),
      ),
      child: const Icon(Icons.arrow_forward),
    );
  }
}
