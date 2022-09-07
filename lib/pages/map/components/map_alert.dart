import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../../../routes/routes.dart';
import '../../../theme/colors.dart';
import '../controller/map_controller.dart';

class MapAlert extends GetView<MapPageController> {
  const MapAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadTask.isTrue) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
          child: const Card(
            child: Padding(
                padding: EdgeInsets.all(UiConstants.defaultPadding),
                child: Center(
                  child: CircularProgressIndicator(),
                )),
          ),
        );
      } else {
        return Container(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 350),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      splashRadius: 10,
                      onPressed: () => controller.popupLayerController
                          .hidePopupsOnlyFor(controller.markers),
                      icon: const Icon(
                        Icons.close,
                        size: 15,
                      )),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.tasks!.length,
                      itemBuilder: (context, index) => _TaskCard(index: index),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

class _TaskCard extends GetView<MapPageController> {
  const _TaskCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: UiConstants.defaultPadding * 0.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 7,
              child: controller.tasks![index].images.url != null
                  ? ExtendedImage.network(
                      cache: true,
                      controller.tasks![index].images.url!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.black,
                      width: 150,
                      height: 120,
                      child: const Center(
                          child: Text(
                        "изображения не найдено",
                        style: TextStyle(color: Colors.white),
                      )),
                    )),
          Expanded(
              flex: controller.tasks![index].images.url != null ? 4 : 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: UiConstants.defaultPadding * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _taskData(),
                    const SizedBox(
                      height: UiConstants.defaultPadding * 0.2,
                    ),
                    _taskCategory(),
                    const SizedBox(
                      height: UiConstants.defaultPadding * 0.2,
                    ),
                    _taskState(),
                    const SizedBox(
                      height: UiConstants.defaultPadding * 0.5,
                    ),
                    _openButton(),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _taskData() {
    return Text(
      DateFormat('yMMMMd', 'ru')
          .format(DateTime.parse(controller.tasks![index].createDateTime)),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _taskCategory() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          controller.tasks![index].category.name,
          style: TextStyle(fontSize: 10, color: CustomColors.customTextColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _taskState() {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          (() {
            if (controller.tasks![index].isDone) {
              return "выполнено";
            } else if (controller.tasks![index].isExpired) {
              return "просроченно";
            }
            return "на исполнении";
          })(),
          style: TextStyle(fontSize: 10, color: CustomColors.customTextColor),
        ),
      ),
    );
  }

  Widget _openButton() {
    return ElevatedButton.icon(
      onPressed: () =>
          Get.toNamed(RoutesClass.task, arguments: controller.tasks![index].id),
      icon: const Icon(Icons.open_in_new),
      label: const Text(
        "открыть",
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Color _getColor() {
    if (controller.tasks![index].isDone) {
      return CustomColors.completedTaskColor;
    } else if (controller.tasks![index].isExpired) {
      return CustomColors.expiredTaskColor;
    } else {
      return CustomColors.currentTaskColor;
    }
  }
}
