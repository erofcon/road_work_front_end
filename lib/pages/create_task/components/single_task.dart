import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/create_task/components/select_on_map.dart';
import 'package:road_work_front_end/pages/create_task/controller/single_task_controller.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers/date_time.dart';
import '../../dashboard/models/related_user_response.dart';
import '../models/task_category_response.dart';

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
                      children: <Widget>[
                        Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: const SelectImages()),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: const SelectLocation()),
                      ],
                    ),
                  )),
              Step(
                state: controller.executorError.isTrue ||
                        controller.expireDateError.isTrue
                    ? StepState.error
                    : StepState.indexed,
                isActive: controller.activeStepIndex.value == 2 ? true : false,
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
                      Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: const ExpireDate()),
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
            ? Get.showSnackbar(const GetSnackBar(
                title: "Успех",
                message: "задача успешно создано!",
                backgroundColor: Colors.green,
              ))
            : Get.showSnackbar(const GetSnackBar(
                title: "Ошибка",
                message: "ошибка созданеия задачи",
                backgroundColor: Colors.red,
              ));
      } else {
        Get.showSnackbar(const GetSnackBar(
          title: "Ошибка",
          message: "обязательные поля не заполнены!",
          backgroundColor: Colors.red,
        ));
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
      return ElevatedButton(
          onPressed: controller.selectFile,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            primary: Colors.white,
            side: const BorderSide(width: 1, color: Colors.black12),
          ),
          child: Container(
            padding: const EdgeInsets.all(UiConstants.defaultPadding * 2),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.image_outlined,
                  color: Colors.black,
                  size: 48,
                ),
                const SizedBox(
                  height: UiConstants.defaultPadding,
                ),
                Text(
                  controller.files != null
                      ? controller.files!.first.name.toString()
                      : 'Выберите изображение',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ));
    });
  }
}

class SelectLocation extends StatelessWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleTaskController>(builder: (controller) {
      return ElevatedButton(
          onPressed: () {
            Get.to(() => Location(
                  location: controller.selectLocation,
                ));
          },
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            primary: Colors.white,
            side: const BorderSide(width: 1, color: Colors.black12),
          ),
          child: Container(
            padding: const EdgeInsets.all(UiConstants.defaultPadding * 2),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 48,
                ),
                const SizedBox(
                  height: UiConstants.defaultPadding,
                ),
                Text(
                  controller.location != null
                      ? '${controller.location!.latitude}  ${controller.location!.longitude}'
                      : 'Select Location',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ));
    });
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
      builder: (controller) => ElevatedButton(
          onPressed: () async {
            final selected = await selectDate(context);
            if (selected != null) {
              controller.selectDate(selected);
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            primary: Colors.white,
            side: const BorderSide(width: 1, color: Colors.black12),
          ),
          child: Container(
            padding: const EdgeInsets.all(UiConstants.defaultPadding * 2),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.date_range_outlined,
                  color: Colors.black,
                  size: 48,
                ),
                const SizedBox(
                  height: UiConstants.defaultPadding,
                ),
                Text(
                  controller.expiredDateTime != null
                      ? controller.expiredDateTime.toString()
                      : "Выбрать дату",
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          )),
    );
  }
}
