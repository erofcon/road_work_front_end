import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/navigation/side_bar.dart';

import '../navigation/controller/navigation_controller.dart';
import '../navigation/navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          SideBar(),
          Expanded(
              child: Align(
            alignment: Alignment.topCenter,
            child: NavBar(),
          )),
        ],
      ),

      // appBar: AppBar(),
      //   body: Align(
      // alignment: Alignment.topCenter,
      // child: Navbar(),
    );
  }
}

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white54,
    );
  }
}
