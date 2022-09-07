import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/pages/task_list/controller/task_list_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../routes/routes.dart';
import '../../theme/colors.dart';

class TaskListPage extends GetView<TaskListController> {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: "все задачи",
            onPressed: () {
              controller.value = "all";
              controller.page = 1;
              controller.scrollLoad(false);
              controller.showBackToTopButton(false);
              controller.getTaskList();
            },
            icon: const Icon(Icons.all_inbox),
            splashRadius: 20,
          ),
          IconButton(
              tooltip: "выполненые задачи",
              onPressed: () {
                controller.value = "is_done";
                controller.page = 1;
                controller.scrollLoad(false);
                controller.showBackToTopButton(false);
                controller.getTaskList();
              },
              icon: const Icon(Icons.check_circle_outline),
              splashRadius: 20),
          IconButton(
            tooltip: "задачи на исполнении",
            onPressed: () {
              controller.value = "all_current_tasks";
              controller.page = 1;
              controller.scrollLoad(false);
              controller.showBackToTopButton(false);
              controller.getTaskList();
            },
            icon: const Icon(Icons.auto_mode_outlined),
            splashRadius: 20,
          ),
          IconButton(
            tooltip: 'просроченные задачи',
            onPressed: () {
              controller.value = "expired_tasks";
              controller.page = 1;
              controller.showBackToTopButton(false);
              controller.scrollLoad(false);
              controller.getTaskList();
            },
            icon: const Icon(Icons.dangerous_rounded),
            splashRadius: 20,
          ),
          const SizedBox(
            width: UiConstants.defaultPadding,
          )
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        controller: controller.scrollController,
                        itemCount: controller.taskList.value.results.length + 1,
                        cacheExtent: 100.0,
                        itemBuilder: (context, index) {
                          if (index <
                              controller.taskList.value.results.length) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: UiConstants.defaultPadding * 0.5),
                                child: _TaskCard(
                                  index: index,
                                ));
                          } else {
                            return Obx(() {
                              if (controller.taskList.value.next != null) {
                                if (controller.scrollLoad.isTrue) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: UiConstants.defaultPadding),
                                      child: SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: IconButton(
                                            splashRadius: 25,
                                            tooltip: "загрузить еще",
                                            padding: const EdgeInsets.all(0),
                                            icon: Icon(
                                              Icons.add_circle_outline_outlined,
                                              size: 35,
                                              color: CustomColors.iconColor,
                                            ),
                                            onPressed: () {
                                              controller.scrollLoad(true);
                                              controller.getNextPage();
                                            },
                                          )),

                                  );
                                }
                              } else {
                                return Container();
                              }
                            });
                          }
                        }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(UiConstants.defaultPadding),
                    child: Obx(() {
                      if (controller.showBackToTopButton.isTrue) {
                        return FloatingActionButton(
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            controller.scrollController.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          },
                          child: const Icon(Icons.arrow_upward),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}

class _TaskCard extends GetView<TaskListController> {
  const _TaskCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.defaultPadding)),
      onTap: () {
        Get.toNamed(RoutesClass.task,
            arguments: controller.taskList.value.results[index].id);
      },
      leading: _buildImage(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: _buildStatus(),
    );
  }

  Widget _buildTitle() {
    return Text(
      DateFormat('yMMMMd', 'ru').format(DateTime.parse(
          controller.taskList.value.results[index].createDateTime.toString())),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      controller.taskList.value.results[index].description ?? '',
    );
  }

  Widget _buildImage() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: CustomColors.userColor,
      child: Text(
        (() {
          if (controller.loginController.user?.isExecutor == true) {
            return '${controller.taskList.value.results[index].creator?.firstName[0].toUpperCase()}${controller.taskList.value.results[index].creator?.lastName[0].toUpperCase()}';
          } else {
            return '${controller.taskList.value.results[index].executor?.firstName[0].toUpperCase()}${controller.taskList.value.results[index].executor?.lastName[0].toUpperCase()}';
          }
        })(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatus() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: _getStatusColor(),
          ),
          child: Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.2),
              child: Text(
                (() {
                  if (controller.taskList.value.results[index].isDone ??
                      false) {
                    return "выполнено";
                  } else if (controller
                          .taskList.value.results[index].isExpired ??
                      false) {
                    return "просроченно";
                  }
                  return "на исполнении";
                })(),
                style:
                    TextStyle(fontSize: 9, color: CustomColors.customTextColor),
              )),
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.orangeAccent,
          ),
          child: Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.2),
              child: Text(
                (() {
                  return controller
                          .taskList.value.results[index].category?.name ??
                      '';
                })(),
                style: TextStyle(
                    fontSize: 10, color: CustomColors.customTextColor),
              )),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    if (controller.taskList.value.results[index].isDone ?? false) {
      return CustomColors.completedTaskColor;
    } else if (controller.taskList.value.results[index].isExpired ?? false) {
      return CustomColors.expiredTaskColor;
    } else {
      return CustomColors.currentTaskColor;
    }
  }
}
