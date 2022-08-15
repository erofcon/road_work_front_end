import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/create_task/controller/create_task_controller.dart';

import 'components/run_detection.dart';
import 'components/single_task.dart';

class CreateTask extends GetView<CreateTaskController> {
  const CreateTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.isLoading.isTrue){
        return const Center(child: CircularProgressIndicator(),);
      }else{
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "create_single_task".tr),
                  Tab(text: "run_detection".tr),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                const SingleTask(),
                RunDetection()
              ],
            ),
          ),
        );
      }
    }
    );
  }
}
