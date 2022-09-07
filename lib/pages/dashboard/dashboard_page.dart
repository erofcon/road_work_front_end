import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';
import 'package:road_work_front_end/shared_components/theme_service.dart';
import 'package:road_work_front_end/theme/colors.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../routes/routes.dart';
import '../../utils/responsive.dart';
import 'components/head_recent_tasks.dart';
import 'components/menu.dart';
import 'components/notification.dart';
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
          : const Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: _BuildSidebar()),
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
                      BuildTaskContent(
                        onPressedMenu: () => controller.openDrawer(),
                      ),
                      const Divider(),
                      const _BuildChartContent(),
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
                          child: BuildTaskContent(
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
                        child: const _BuildChartContent(),
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
                        child: const SingleChildScrollView(
                          child: _BuildSidebar(),
                        )),
                    Flexible(
                      flex: constraints.maxWidth > 1350 ? 10 : 9,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: const BuildTaskContent(),
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
                        child: const _BuildChartContent(),
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
}

class BuildTaskContent extends GetView<DashboardController> {
  const BuildTaskContent({Key? key, this.onPressedMenu}) : super(key: key);

  final Function()? onPressedMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: UiConstants.defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (onPressedMenu != null)
                IconButton(
                    onPressed: () => controller.openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: CustomColors.iconColor,
                    )),
              const Spacer(),
              Obx(
                () => IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      ThemeService().changeThemeMode();
                      controller.isDarkMode.toggle();
                    },
                    icon: controller.isDarkMode.isTrue
                        ? Icon(
                            Icons.sunny,
                            color: CustomColors.iconColor,
                          )
                        : Icon(Icons.dark_mode_outlined,
                            color: CustomColors.iconColor)),
              ),
              Obx(
                () => Stack(
                  children: <Widget>[
                    if (controller.notificationsData.isNotEmpty)
                      Positioned(
                        right: 1,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            controller.notificationsData.length.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          )),
                        ),
                      ),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () => Get.dialog(const NotificationDialog()),
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: CustomColors.iconColor,
                        )),
                  ],
                ),
              ),
              IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/language/ru.png'),
                  )),
            ],
          ),
          const Divider(),
          const SizedBox(
            height: UiConstants.defaultPadding,
          ),
          Text(
            DateFormat('yMMMMd', 'ru').format(DateTime.now()),
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
          if (ResponsiveBuilder.isMobile(context)) const Divider(),
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
}

class _BuildChartContent extends GetView<DashboardController> {
  const _BuildChartContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Статистика задач',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (controller.loginController.user?.isSuperUser ?? false)
                IconButton(
                  splashRadius: 20,
                  onPressed: () => Get.toNamed(RoutesClass.report),
                  icon: Icon(
                    Icons.add_chart,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
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

class _BuildSidebar extends StatelessWidget {
  const _BuildSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UserProfile(
          onPressed: () {},
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
        const RelatedUsers(),
      ],
    );
  }
}
