import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';

import '../../../routes/routes.dart';

class HeadRecentTask extends GetView<DashboardController> {
  const HeadRecentTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('Последние задачи',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        const Spacer(),
        if(controller.loginController.user?.isCreator??false)
        ElevatedButton.icon(
          icon: const Icon(
            Icons.add,
            size: 16,
          ),
          onPressed: () => Get.toNamed(RoutesClass.create),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: Theme.of(context).primaryColor,
            elevation: 0,
          ),
          label: const Text("добавить"),
        ),
      ],
    );
  }
}
