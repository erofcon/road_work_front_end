import 'package:flutter/material.dart';
import 'package:road_work_front_end/utils/constants.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerList(title: 'Home', icon: Icons.dashboard_outlined, press: (){}),
        DrawerList(title: 'Tasks', icon: Icons.list_alt_outlined, press: (){}),
        DrawerList(title: 'Map', icon: Icons.map_outlined, press: (){}),
      ],
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.defaultPadding)),
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

