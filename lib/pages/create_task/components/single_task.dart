import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/create_task/controller/single_task_controller.dart';
import 'package:road_work_front_end/theme/colors.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers/date_time_select.dart';
import '../../dashboard/models/related_user_response.dart';
import '../models/task_category_response.dart';
import 'select_on_map.dart';

class SingleTask extends GetView<SingleTaskController> {
  SingleTask({Key? key}) : super(key: key);

  final successSnackBar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.only(top: UiConstants.defaultPadding * 2),
              constraints: const BoxConstraints(maxWidth: 500),
              child: Stepper(
                currentStep: controller.activeStepIndex.value,
                steps: <Step>[
                  Step(
                      state: controller.categoryError.isTrue
                          ? StepState.error
                          : StepState.indexed,
                      isActive:
                          controller.activeStepIndex.value == 0 ? true : false,
                      title: const Text("Категория и описание задачи"),
                      content: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Category(),
                            controller.categoryError.value
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
                      isActive:
                          controller.activeStepIndex.value == 1 ? true : false,
                      title: const Text("Изображение и локация"),
                      content: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            SelectImages(),
                            SizedBox(
                              height: 25,
                            ),
                            SelectLocation(),
                          ],
                        ),
                      )),
                  Step(
                    state: controller.executorError.isTrue ||
                            controller.expireDateError.isTrue
                        ? StepState.error
                        : StepState.indexed,
                    isActive:
                        controller.activeStepIndex.value == 2 ? true : false,
                    title: const Text("Исполнитель и срок выполнения"),
                    content: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const RelUser(),
                          controller.executorError.isTrue
                              ? const Text("пожалуйста, выберите исполнителя",
                                  style: TextStyle(color: Colors.red))
                              : const Text(''),
                          const SizedBox(
                            height: UiConstants.defaultPadding,
                          ),
                          const ExpireDate(),
                          controller.expireDateError.isTrue
                              ? const Text("пожалуйста, выберите исполнителя",
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
                  final isLastStep = controller.activeStepIndex.value == 2;
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: UiConstants.defaultPadding),
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: controller.uploadTask
                          ? const Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 5.0,
                            ))
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: onStepContinue,
                                    child: isLastStep
                                        ? const Text('Отправить')
                                        : const Text('Вперед'),
                                  ),
                                ),
                                const SizedBox(
                                  width: UiConstants.defaultPadding,
                                ),
                                if (controller.activeStepIndex.value > 0)
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: onStepCancel,
                                        child: const Text('Назад')),
                                  ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }
    });
  }

  void onStepContinue({int? next}) async {
    if (controller.activeStepIndex.value >= 0 &&
        controller.activeStepIndex.value < 2) {
      if (controller.activeStepIndex.value == 0) {
        if (controller.selectedTaskCategory == null) {
          controller.categoryError.value = true;
        } else {
          controller.categoryError.value = false;
        }
      }
      next != null
          ? controller.activeStepIndex(next)
          : controller.activeStepIndex.value += 1;
    } else if (next != null) {
      if (controller.relatedUser == null) {
        controller.executorError(true);
      } else {
        controller.executorError(false);
      }

      if (controller.expiredDateTime == null) {
        controller.expireDateError(true);
      } else {
        controller.expireDateError(false);
      }
      controller.activeStepIndex(next);
    } else {
      if (controller.relatedUser == null) {
        controller.executorError(true);
      } else {
        controller.executorError(false);
      }

      if (controller.expiredDateTime == null) {
        controller.expireDateError(true);
      } else {
        controller.expireDateError(false);
      }

      if (controller.selectedTaskCategory != null &&
          controller.relatedUser != null &&
          controller.expiredDateTime != null) {
        // controller.uploadTask(true);

        bool result = await controller.createTask();

        result
            ? Get.snackbar("Успех", "задача успешно создано",
                margin: EdgeInsets.zero,
                duration: const Duration(seconds: 2),
                borderRadius: 0,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: CustomColors.completedTaskColor)
            : Get.snackbar("Ошибка", "ошибка созданеия задачи",
                margin: EdgeInsets.zero,
                duration: const Duration(seconds: 2),
                borderRadius: 0,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: CustomColors.expiredTaskColor);
      } else {
        Get.snackbar("Ошибка", "Обязательные поля не заполнены",
            margin: EdgeInsets.zero,
            duration: const Duration(seconds: 2),
            borderRadius: 0,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: CustomColors.expiredTaskColor);
      }
    }
  }

  void onStepCancel() {
    if (controller.activeStepIndex.value > 0 &&
        controller.activeStepIndex.value <= 2) {
      if (controller.activeStepIndex.value == 2) {
        if (controller.relatedUser == null) {
          controller.executorError(true);
        } else {
          controller.executorError(false);
        }
        if (controller.expiredDateTime == null) {
          controller.expireDateError(true);
        } else {
          controller.expireDateError(false);
        }
      }
      controller.activeStepIndex.value -= 1;
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

class SelectImages extends StatelessWidget {
  const SelectImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleTaskController>(builder: (controller) {
      return SizedBox(
          width: context.width,
          child: ElevatedButton.icon(
              onPressed: controller.selectFile,
              icon: controller.files == null
                  ? const Icon(Icons.image_outlined)
                  : const Icon(Icons.check_circle_outline),
              label: controller.files == null
                  ? const Text("Выберите изображение", maxLines: 1)
                  : const Text(
                      "Изображение выбрано",
                    )));
    });
  }
}

class SelectLocation extends StatelessWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleTaskController>(
      builder: (controller) => SizedBox(
        width: context.width,
        child: ElevatedButton.icon(
            onPressed: () => Get.dialog(Location(
                  location: controller.selectLocation,
                )),
            icon: controller.location == null
                ? const Icon(Icons.location_on_outlined)
                : const Icon(Icons.check_circle_outline),
            label: controller.location == null
                ? const Text(
                    "Выберите местоположение",
                    maxLines: 1,
                  )
                : const Text(
                    "местоположение выбрано",
                    maxLines: 1,
                  )),
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
