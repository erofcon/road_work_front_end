import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';
import 'package:road_work_front_end/utils/helpers/extension.dart';

import '../../utils/responsive.dart';
import 'components/head_recent_tasks.dart';
import 'components/menu.dart';
import 'components/recent_task_list.dart';
import 'components/related_user.dart';
import 'components/task_cards.dart';
import 'components/tasks_statistic.dart';
import 'components/user_profile.dart';

class HomePage extends GetView<DashboardController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: _buildSidebar()),
              ),
            ),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return Obx(() {
              if (controller.isLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTaskContent(
                        onPressedMenu: () => controller.openDrawer(),
                      ),
                      _buildChartContent(),
                    ],
                  ),
                );
              }
            });
          },
          tabletBuilder: (context, constraints) {
            return Obx(() {
              if (controller.isLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: constraints.maxWidth > 800 ? 8 : 7,
                      child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: _buildTaskContent(
                              onPressedMenu: () => controller.openDrawer())),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const VerticalDivider(),
                    ),
                    Flexible(
                      flex: 4,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: _buildChartContent(),
                      ),
                    ),
                  ],
                );
              }
            });
          },
          desktopBuilder: (context, constraints) {
            return Obx(() {
              if (controller.isLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        flex: constraints.maxWidth > 1350 ? 3 : 4,
                        child: SingleChildScrollView(
                          child: _buildSidebar(),
                        )),
                    Flexible(
                      flex: constraints.maxWidth > 1350 ? 10 : 9,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: _buildTaskContent(),
                      ),
                    ),
                    SizedBox(
                      height: context.height,
                      child: const VerticalDivider(),
                    ),
                    Flexible(
                      flex: 4,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: _buildChartContent(),
                      ),
                    ),
                  ],
                );
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: UiConstants.defaultPadding),
          child: UserProfile(
            onPressed: () {},
            userName: 'Temirlan Shereuzhev',
            job: 'administrator',
            imageUrl: 'https://avatarfiles.alphacoders.com/162/162739.jpg',
          ),
        ),
        const SizedBox(height: UiConstants.defaultPadding),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding * 2),
          child: Menu(),
        ),
        const Divider(
          indent: 40,
          thickness: 1,
          endIndent: 20,
          height: 60,
        ),
        RelatedUsers(),
      ],
    );
  }

  Widget _buildTaskContent({Function()? onPressedMenu}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: UiConstants.defaultPadding),
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: UiConstants.defaultPadding),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(Icons.menu),
              ),
            ),
          Text(
            DateTime.now().formatdMMMMY(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: UiConstants.defaultPadding),
          const TaskCards(),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          const HeadRecentTask(),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          const RecentTaskList(),
        ],
      ),
    );
  }

  Widget _buildChartContent() {
    return Padding(
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Статистика задач',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_chart),
                tooltip: "отчет",
              )
            ],
          ),
          const TasksStatistic(),
        ],
      ),
    );
  }
}
