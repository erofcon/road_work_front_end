import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/create_task/components/select_on_,map.dart';
import 'package:road_work_front_end/pages/create_task/controller/create_task_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../utils/helpers/date_time.dart';
import '../../dashboard/models/related_user_response.dart';
import '../models/task_category_response.dart';

class SingleTask extends StatefulWidget {
  const SingleTask({Key? key}) : super(key: key);

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  int activeStepIndex = 0;
  bool uploadTask = false;

  bool categoryError = false;
  bool executorError = false;
  bool expireDateError = false;
  final controller = Get.put(CreateTaskController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stepper(
        currentStep: activeStepIndex,
        steps: <Step>[
          Step(
              state: categoryError ? StepState.error : StepState.indexed,
              isActive: activeStepIndex == 0 ? true : false,
              title: const Text("Категория и описание задачи"),
              content: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Category(),
                    categoryError
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
              isActive: activeStepIndex == 1 ? true : false,
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
            state: executorError == true || expireDateError == true
                ? StepState.error
                : StepState.indexed,
            isActive: activeStepIndex == 2 ? true : false,
            title: const Text("Исполнитель и срок выполнения"),
            content: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const RelUser(),
                  executorError
                      ? const Text("пожалуйста, выберите исполнителя",
                          style: TextStyle(color: Colors.red))
                      : const Text(''),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: const ExpireDate()),
                  expireDateError
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
          final isLastStep = activeStepIndex == 2;
          return Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: UiConstants.defaultPadding),
              constraints: const BoxConstraints(maxWidth: 500),
              child: uploadTask
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
                        if (activeStepIndex > 0)
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

  void onStepContinue({int? next}) async {
    if (activeStepIndex >= 0 && activeStepIndex < 2) {
      if (activeStepIndex == 0) {
        if (controller.selectedTaskCategory == null) {
          categoryError = true;
        } else {
          categoryError = false;
        }
      }

      setState(() {
        next != null ? activeStepIndex = next : activeStepIndex += 1;
      });
    } else if (next != null) {
      if (controller.relatedUser == null) {
        executorError = true;
      } else {
        executorError = false;
      }

      if (controller.expiredDateTime == null) {
        expireDateError = true;
      } else {
        expireDateError = false;
      }
      setState(() {
        activeStepIndex = next;
      });
    } else {
      if (controller.relatedUser == null) {
        executorError = true;
      } else {
        executorError = false;
      }

      if (controller.expiredDateTime == null) {
        expireDateError = true;
      } else {
        expireDateError = false;
      }

      if (controller.selectedTaskCategory != null &&
          controller.relatedUser != null &&
          controller.expiredDateTime != null) {

        setState(() {uploadTask = true;});

        bool result = await controller.createTask();

        result?Get.snackbar("Успех", "задача успешно создано!",
            backgroundColor: Colors.green, icon: const Icon(Icons.check_circle_outline)):
        Get.snackbar("Ошибка", "ошибка созданеия задачи",
            backgroundColor: Colors.red, icon: const Icon(Icons.error));

        setState(() {uploadTask = false;});
      } else {
        setState(() {});
        Get.snackbar("Ошибка", "обязательные поля не заполнены!",
            backgroundColor: Colors.red, icon: const Icon(Icons.error));
      }
    }
  }

  void onStepCancel() {
    if (activeStepIndex > 0 && activeStepIndex <= 2) {
      if (activeStepIndex == 2) {
        if (controller.relatedUser == null) {
          executorError = true;
        } else {
          executorError = false;
        }
        if (controller.expiredDateTime == null) {
          expireDateError = true;
        } else {
          expireDateError = false;
        }
      }
      setState(() {
        activeStepIndex -= 1;
      });
    }
  }
}

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTaskController>(builder: (controller) {
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

class Description extends GetView<CreateTaskController> {
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
    return GetBuilder<CreateTaskController>(builder: (controller) {
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
    return GetBuilder<CreateTaskController>(builder: (controller) {
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
    return GetBuilder<CreateTaskController>(builder: (controller) {
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
    return GetBuilder<CreateTaskController>(
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
