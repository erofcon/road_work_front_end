import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:road_work_front_end/utils/constants.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Get.width,
              height: 70,
              color: Colors.amber,
            ),
             Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding),
              child: Text('sidebar_title'.tr),
            ),
            DrawerList(
                title: 'sidebar_info'.tr,
                icon: Icons.info_outline,
                press: () {}),
            DrawerList(
                title: 'sidebar_create_task'.tr,
                icon: Icons.create_outlined,
                press: () {}),
            DrawerList(
                title: 'sidebar_result_detection'.tr,
                icon: Icons.reset_tv_outlined,
                press: () {}),
            DrawerList(
                title: 'sidebar_task_list'.tr,
                icon: Icons.list,
                press: () {}),
            DrawerList(
                title: 'sidebar_menu_map'.tr,
                icon: Icons.map_outlined,
                press: () {}),
            DrawerList(
                title: 'sidebar_menu_report'.tr,
                icon: Icons.report_gmailerrorred_outlined,
                press: () {}),
          ],
        ),
      ),
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
