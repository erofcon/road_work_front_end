import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class NavBar extends StatelessWidget {
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
          const IconButtonHover(iconData: Icons.menu,),
          const Spacer(),
          const IconButtonHover(iconData: Icons.dark_mode_outlined,),
          const IconButtonHover(iconData: Icons.notifications_none_rounded),
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
    );
  }
}

class IconButtonHover extends StatelessWidget {
  const IconButtonHover({Key? key, required this.iconData}) : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStateProperty.all(const EdgeInsets.all(UiConstants.defaultPadding)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.indigo[100];
            }
            return null;
          })),
      child: Icon(iconData, color: Colors.black,),
    );
  }
}

// Color? primary,
//     Color? onPrimary,
// Color? onSurface,
//     Color? shadowColor,
// Color? surfaceTintColor,
