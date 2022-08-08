import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/login/controller/login_controller.dart';

import '../../routes/routes.dart';
import '../../utils/constants.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  // final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
          height: 550.0,
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            // key: controller.formKey.value,
            child: Column(
              children: <Widget>[
                const LoginField(),
                const PasswordField(),
                const KeepUser(),
                const SubmitButton(),
                Obx(() => Padding(
                    padding:
                        const EdgeInsets.only(top: UiConstants.defaultPadding),
                    child: controller.loginError.value
                        ? const Text(
                            'error auth',
                            style: TextStyle(color: Colors.red),
                          )
                        : const Text('')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginField extends GetView<LoginController> {
  const LoginField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class PasswordField extends GetView<LoginController> {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class KeepUser extends GetView<LoginController> {
  const KeepUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: UiConstants.defaultPadding),
      child: Row(
        children: <Widget>[
          Obx(() => Checkbox(
                value: controller.checkKeepUser.value,
                onChanged: (_) => controller.checkKeepUser.toggle(),
              )),
          const Text('keep me')
        ],
      ),
    );
  }
}

class SubmitButton extends GetView<LoginController> {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ElevatedButton(
          onPressed: () async {
            bool res = await controller.login();
            if(res){
              Get.offNamed(RoutesClass.home);
            }
            // if (controller.formKey.value.currentState!.validate()) {
            //   controller.sendingData.toggle();
            //   await controller.login();
            //   controller.sendingData.toggle();
            // }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
            elevation: MaterialStateProperty.all(10),
          ),
          child: controller.sendingData.value
              ? const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
              : const Icon(Icons.arrow_forward),
        ));
  }
}
