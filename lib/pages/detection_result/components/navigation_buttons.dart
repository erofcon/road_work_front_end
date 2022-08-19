import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/components/task_description.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

class DetectionAppBar extends GetView<DetectionResultController>
    implements PreferredSizeWidget {
  const DetectionAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () => Get.to(()=>
                      const TaskDescription(),
                      fullscreenDialog: true,
                    ),
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send_to_mobile_outlined,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ),
      ),
    );
  }
}
