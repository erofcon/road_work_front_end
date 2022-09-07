import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/detection_result/controller/detection_result_controller.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers/date_time_select.dart';
import '../../create_task/controller/single_task_controller.dart';
import '../../create_task/models/task_category_response.dart';
import '../../dashboard/models/related_user_response.dart';
import '../controller/detection_result_controller.dart';

class CreateTask extends GetView<DetectionResultController> {
  const CreateTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return SingleChildScrollView(
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.only(top: UiConstants.defaultPadding * 2),
              constraints: const BoxConstraints(maxWidth: 500),
              child: Stepper(
                currentStep:
                    controller.singleTaskController.activeStepIndex.value,
                steps: <Step>[
                  Step(
                      state:
                          controller.singleTaskController.categoryError.isTrue
                              ? StepState.error
                              : StepState.indexed,
                      isActive: controller
                                  .singleTaskController.activeStepIndex.value ==
                              0
                          ? true
                          : false,
                      title: const Text("Категория и описание задачи"),
                      content: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Category(),
                            controller.singleTaskController.categoryError.value
                                ? const Text(
                                    "пожалуйста, выберите категорию",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : const Text(''),
                            const Description()
                          ],
                        ),
                      )),
                  Step(
                    state:
                        controller.singleTaskController.executorError.isTrue ||
                                controller
                                    .singleTaskController.expireDateError.isTrue
                            ? StepState.error
                            : StepState.indexed,
                    isActive:
                        controller.singleTaskController.activeStepIndex.value ==
                                1
                            ? true
                            : false,
                    title: const Text("Исполнитель и срок выполнения"),
                    content: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const RelUser(),
                          controller.singleTaskController.executorError.isTrue
                              ? const Text("пожалуйста, выберите исполнителя",
                                  style: TextStyle(color: Colors.red))
                              : const Text(''),
                          const SizedBox(
                            height: UiConstants.defaultPadding,
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: const ExpireDate()),
                          controller.singleTaskController.expireDateError.isTrue
                              ? const Text(
                                  "пожалуйста, выберите срок выполнения",
                                  style: TextStyle(color: Colors.red))
                              : const Text(''),
                        ],
                      ),
                    ),
                  ),
                ],
                onStepContinue: onStepContinue,
                onStepCancel: onStepCancel,
                onStepTapped: (int index) => onStepContinue(next: index),
                controlsBuilder: (context, details) {
                  final isLastStep =
                      controller.singleTaskController.activeStepIndex.value ==
                          1;
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: UiConstants.defaultPadding),
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: controller.singleTaskController.uploadTask
                          ? const Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 5.0,
                            ))
                          : Row(
                              children: <Widget>[
                                if (!isLastStep)
                                  ElevatedButton(
                                    onPressed: onStepContinue,
                                    child: const Text('Вперед'),
                                  ),
                                if (controller.singleTaskController
                                        .activeStepIndex.value >
                                    0)
                                  ElevatedButton(
                                      onPressed: onStepCancel,
                                      child: const Text('Назад')),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  void onStepContinue({int? next}) async {
    if (controller.singleTaskController.activeStepIndex.value >= 0 &&
        controller.singleTaskController.activeStepIndex.value < 1) {
      if (controller.singleTaskController.activeStepIndex.value == 0) {
        if (controller.singleTaskController.selectedTaskCategory == null) {
          controller.singleTaskController.categoryError.value = true;
        } else {
          controller.singleTaskController.categoryError.value = false;
        }
      }
      next != null
          ? controller.singleTaskController.activeStepIndex(next)
          : controller.singleTaskController.activeStepIndex.value += 1;
    } else if (next != null) {
      if (controller.singleTaskController.relatedUser == null) {
        controller.singleTaskController.executorError(true);
      } else {
        controller.singleTaskController.executorError(false);
      }

      if (controller.singleTaskController.expiredDateTime == null) {
        controller.singleTaskController.expireDateError(true);
      } else {
        controller.singleTaskController.expireDateError(false);
      }
      controller.singleTaskController.activeStepIndex(next);
    } else {
      if (controller.singleTaskController.relatedUser == null) {
        controller.singleTaskController.executorError(true);
      } else {
        controller.singleTaskController.executorError(false);
      }

      if (controller.singleTaskController.expiredDateTime == null) {
        controller.singleTaskController.expireDateError(true);
      } else {
        controller.singleTaskController.expireDateError(false);
      }
    }
  }

  void onStepCancel() {
    if (controller.singleTaskController.activeStepIndex.value > 0 &&
        controller.singleTaskController.activeStepIndex.value <= 1) {
      if (controller.singleTaskController.activeStepIndex.value == 1) {
        if (controller.singleTaskController.relatedUser == null) {
          controller.singleTaskController.executorError(true);
        } else {
          controller.singleTaskController.executorError(false);
        }
        if (controller.singleTaskController.expiredDateTime == null) {
          controller.singleTaskController.expireDateError(true);
        } else {
          controller.singleTaskController.expireDateError(false);
        }
      }
      controller.singleTaskController.activeStepIndex.value -= 1;
    }
  }
}

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleTaskController>(builder: (controller) {
      return DropdownButton<TaskCategory>(
        value: controller.selectedTaskCategory,
        hint: const Text("Категория задачи"),
        onChanged: (TaskCategory? newValue) {
          controller.selectCategory(newValue!);
        },
        items: controller.taskCategories!
            .map<DropdownMenuItem<TaskCategory>>((value) {
          return DropdownMenuItem<TaskCategory>(
            value: (value),
            child: Text(value.name),
          );
        }).toList(),
      );
    });
  }
}

class Description extends GetView<SingleTaskController> {
  const Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextField(
        controller: controller.description,
        decoration: const InputDecoration(
          labelText: "Введите описание задачи",
        ),
      ),
    );
  }
}

class RelUser extends StatelessWidget {
  const RelUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleTaskController>(builder: (controller) {
      return DropdownButton<RelatedUser>(
        value: controller.relatedUser,
        hint: const Text("Исполнитель"),
        onChanged: (RelatedUser? newValue) {
          controller.selectRelatedUser(newValue!);
        },
        items: controller.dashboardController.relatedUser
            .map<DropdownMenuItem<RelatedUser>>((value) {
          return DropdownMenuItem<RelatedUser>(
            value: (value),
            child: Text('${value.firstName} ${value.lastName}'),
          );
        }).toList(),
      );
    });
  }
}

class ExpireDate extends StatelessWidget {
  const ExpireDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleTaskController>(
      builder: (controller) => SizedBox(
        width: context.width,
        child: ElevatedButton.icon(
          onPressed: () async {
            final selected = await selectDate(context);
            if (selected != null) {
              controller.selectDate(selected);
            }
          },
          icon: controller.expiredDateTime == null
              ? const Icon(Icons.access_time)
              : const Icon(Icons.check_circle_outline),
          label: controller.expiredDateTime == null
              ? const Text("Установите срок выполнения")
              : const Text("Срок выполения выбрано"),
        ),
      ),
    );
  }
}
