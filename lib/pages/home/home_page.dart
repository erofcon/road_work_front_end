import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/home/components/task_cards.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../navigation/navigation.dart';
import 'components/last_files.dart';
import 'components/statistic_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      widget: SingleChildScrollView(
        padding: const EdgeInsets.only(left: UiConstants.defaultPadding),
        child: Column(
          children: <Widget>[
            TaskCards(),
          ],
        ),
        // child: Row(
        //   children: <Widget>[
        //     Expanded(
        //       flex: 5,
        //       child: Column(
        //         children: [
        //           TaskCards(),
        //           LastFiles(),
        //           // StarageDetails()
        //         ],
        //       ),
        //     ),
        //
        //     if(context.isLargeTablet)
        //       Expanded(
        //         flex: 2,
        //         child: StarageDetails(),
        //       ),
        //     //   StarageDetails()
        //
        //     // Column(
        //     //   children: const <Widget>[
        //     //    SizedBox( height: 500, child: TaskCards()),
        //     //     // LastFiles(),
        //     //     // StarageDetails(),
        //     //   ],
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
