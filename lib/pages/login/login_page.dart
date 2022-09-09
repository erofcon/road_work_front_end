import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/utils/constants.dart';

// class LoginPage extends GetView<LoginController> {
//   const LoginPage({Key? key}) : super(key: key);
//
//   // final controller = Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
//           height: 550.0,
//           constraints: const BoxConstraints(maxWidth: 300),
//           child: Form(
//             // key: controller.formKey.value,
//             child: Column(
//               children: <Widget>[
//                 const LoginField(),
//                 const PasswordField(),
//                 const KeepUser(),
//                 const SubmitButton(),
//                 Obx(() => Padding(
//                     padding:
//                         const EdgeInsets.only(top: UiConstants.defaultPadding),
//                     child: controller.loginError.value
//                         ? const Text(
//                             'error auth',
//                             style: TextStyle(color: Colors.red),
//                           )
//                         : const Text('')))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LoginField extends GetView<LoginController> {
//   const LoginField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: TextInputType.name,
//       decoration: const InputDecoration(labelText: "Login"),
//       controller: controller.loginEditingController,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "Please send login";
//         }
//         return null;
//       },
//     );
//   }
// }
//
// class PasswordField extends GetView<LoginController> {
//   const PasswordField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: true,
//       keyboardType: TextInputType.name,
//       decoration: const InputDecoration(labelText: "Password"),
//       controller: controller.passwordEditingController,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "Please send password";
//         }
//         return null;
//       },
//     );
//   }
// }
//
// class KeepUser extends GetView<LoginController> {
//   const KeepUser({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: UiConstants.defaultPadding),
//       child: Row(
//         children: <Widget>[
//           Obx(() => Checkbox(
//                 value: controller.checkKeepUser.value,
//                 onChanged: (_) => controller.checkKeepUser.toggle(),
//               )),
//           const Text('keep me')
//         ],
//       ),
//     );
//   }
// }
//
// class SubmitButton extends GetView<LoginController> {
//   const SubmitButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => ElevatedButton(
//           onPressed: () async {
//             bool res = await controller.login();
//             if (res) {
//               Get.offNamed(RoutesClass.home);
//             }
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Colors.teal),
//             elevation: MaterialStateProperty.all(10),
//           ),
//           child: controller.sendingData.value
//               ? const SizedBox(
//                   height: 15,
//                   width: 15,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ))
//               : const Icon(Icons.arrow_forward),
//         ));
//   }
// }

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1557683316-973673baf926?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&w=1000&q=80"))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding:
                          const EdgeInsets.all(UiConstants.defaultPadding * 2),
                      child: Column(
                        children: const <Widget>[
                          Flexible(
                            child: Text(
                              "Добро пожаловать",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "система мониторинка дорожного полотна",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      )),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            UiConstants.defaultPadding * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: UiConstants.defaultPadding),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.white,
                                  decoration:
                                      const InputDecoration(labelText: "Логин"),
                                )),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: UiConstants.defaultPadding),
                                child: TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.visibility)),
                                      labelText: "Пароль"),
                                )),

                            //     return TextFormField(
//       obscureText: true,
//       keyboardType: TextInputType.name,
//       decoration: const InputDecoration(labelText: "Password"),
//       controller: controller.passwordEditingController,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "Please send password";
//         }
//         return null;
//       },
//     );

                            SizedBox(
                                width: context.width,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("войти"))),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Checkbox(value: true, onChanged: (_) {}),
                                const Flexible(
                                  child: Text(
                                    "сохранить учетные данные",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ))
                              ],
                            ),

                            //       child: Row(
//         children: <Widget>[
//           Obx(() => Checkbox(
//                 value: controller.checkKeepUser.value,
//                 onChanged: (_) => controller.checkKeepUser.toggle(),
//               )),
//           const Text('keep me')
//         ],
//       ),
//     );
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //               image: NetworkImage(
    //                   'https://images.unsplash.com/photo-1557683316-973673baf926?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&w=1000&q=80'),
    //               fit: BoxFit.fill),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(
    //             flex: 6,
    //             child: Padding(
    //               padding: const EdgeInsets.only(top: 60, left: 25),
    //               child: Column(
    //                 children: [
    //                   Text('Hello', style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white),),
    //                   Text('Lorem ipsum dolor sit amet', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),),
    //                 ],
    //               ),
    //             ),),
    //           Expanded(
    //             flex: 3,
    //             child: Column(
    //               children: [
    //                 Container(
    //                   height: 80,
    //                   width: double.infinity,
    //                   padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
    //                   child: RaisedButton(
    //                     onPressed: (){},
    //                     elevation: 0,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(25),
    //                     ),
    //                     color: Colors.indigo,
    //                     child: Text(
    //                       'Log In',
    //                       style: TextStyle(
    //                         fontSize: 20,
    //                         fontWeight: FontWeight.w700,
    //                         color: Colors.white,),
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   height: 80,
    //                   width: double.infinity,
    //                   padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
    //                   child: RaisedButton(
    //                     elevation: 0,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(25),
    //                     ),
    //                     color: Colors.white,
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Sign Up',
    //                       style: TextStyle(
    //                         fontSize: 20,
    //                         fontWeight: FontWeight.w700,
    //                         color: Colors.lightBlue,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
