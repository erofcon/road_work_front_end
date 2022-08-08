
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("sdsdsd"),
    );
  }
}


class DrawerList extends StatelessWidget {
  const DrawerList(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      onTap: press,
      horizontalTitleGap: 1.0,
      leading: Icon(icon, color: Colors.black45),
      title: Text(
        title,
      ),
    );
  }
}