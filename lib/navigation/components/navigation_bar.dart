import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../controller/navigation_controller.dart';

class NavBar extends GetView<NavigationController> {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: UiConstants.defaultPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(onPressed: () {controller.sidebarState.toggle();}, icon: controller.sidebarState.isTrue?const Icon(Icons.menu):const Icon(Icons.keyboard_double_arrow_right)),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.dark_mode_outlined)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded)),
          const ProfileCard(),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: UiConstants.defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: UiConstants.defaultPadding,
        vertical: UiConstants.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(243,243,249, 1),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children:  <Widget>[
          const CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/originals/92/0d/60/920d60db9c1a9088aa8f1538a84423d9.png'),
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(
                horizontal: UiConstants.defaultPadding / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Angelina Jolie"),
                Text("administator")
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
