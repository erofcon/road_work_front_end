import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/navigation/components/side_bar.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../pages/home/components/last_files.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0),
        drawer: context.responsiveValue<bool>(
            desktop: false, tablet: true, mobile: true, watch: true)
            ? const SideBar()
            : null,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (context.responsiveValue<bool>(
                  desktop: true, tablet: false, mobile: false, watch: false))
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: UiConstants.defaultPadding * 2),
                        child: SideBar())),
                Expanded(
                flex: 5,
                child: widget,
              ),
            ],
          ),
        ));
  }
}
