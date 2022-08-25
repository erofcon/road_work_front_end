import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/run_detection.dart';
import 'components/single_task.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[SingleTask(), const RunDetection()],
        ),
      ),
    );
  }
}
