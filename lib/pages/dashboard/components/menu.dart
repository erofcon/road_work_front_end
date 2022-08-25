import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../routes/routes.dart';
import '../../login/controller/login_controller.dart';

class Menu extends GetView<LoginController> {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerList(
            title: 'sidebar_task_list'.tr,
            icon: Icons.list_alt_outlined,
            press: () => Get.toNamed(RoutesClass.taskList)),
        if (controller.user?.isSuperUser == true ||
            controller.user?.isCreator == true)
          DrawerList(
              title: 'sidebar_result_detection'.tr,
              icon: Icons.reset_tv_outlined,
              press: () => Get.toNamed(RoutesClass.detectionResult)),
        if (controller.user?.isCreator == true)
          DrawerList(
              title: 'sidebar_create_task'.tr,
              icon: Icons.create_outlined,
              press: () => Get.toNamed(RoutesClass.create)),
        DrawerList(
            title: 'sidebar_map'.tr,
            icon: Icons.map_outlined,
            press: () => Get.toNamed(RoutesClass.map)),
        if (controller.user?.isSuperUser == true)
          DrawerList(
              title: 'sidebar_report'.tr,
              icon: Icons.report_gmailerrorred_outlined,
              press: ()=>Get.toNamed(RoutesClass.report)),
        DrawerList(
            title: 'sidebar_log_out'.tr,
            icon: Icons.logout,
            press: () => Get.offNamed(RoutesClass.login)),
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
