import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: Get.width,
        height: 70,
        padding:
            const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding*2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const InkWell(child: Icon(Icons.menu),),
            const Spacer(),
            const InkWell(
              child: Icon(Icons.dark_mode_outlined),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiConstants.defaultPadding * 2),
              child: const InkWell(
                child: Icon(Icons.notifications_none_rounded),
              ),
            ),
            Container(
              width: Get.width / 8,
              height: Get.height,
              color: const Color.fromRGBO(243, 243, 249, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/92/0d/60/920d60db9c1a9088aa8f1538a84423d9.png'),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text('Temirlan Shereuzhev'),
                        Text('administrator')
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
