import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/models/task_response.dart';
import 'package:road_work_front_end/utils/constants.dart';
import 'package:road_work_front_end/utils/helpers/extension.dart';

import '../../../utils/responsive.dart';
import '../controller/task_controller.dart';

class TaskAnswerList extends GetView<TaskController> {
  const TaskAnswerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Container(
        constraints: BoxConstraints(maxHeight: context.height / 2),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          itemCount: controller.task.value.answer.length,
          itemBuilder: (context, index) => RecentTask(index: index),
        ),
      ),
    );
  }
}

class RecentTask extends GetView<TaskController> {
  const RecentTask({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiConstants.defaultPadding),
          ),
          leading: _buildIcon(),
          title: _buildTitle(),
          subtitle: _buildSubtitle(),
          trailing: ResponsiveBuilder.isDesktop(context)?
          SizedBox(
            height: 50,
            width: 300,
            child: AnswerGallery(index: index),
          ):null,
          // trailing: AnswerGallery(index: index),
        ),
        if (ResponsiveBuilder.isMobile(context) || ResponsiveBuilder.isTablet(context))
          SizedBox(
            height: 50,
            width: context.width,
            child: AnswerGallery(index: index),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      DateTime.parse(controller.task.value.answer[index].replyDate)
          .formatdMMMMY()
          .toLowerCase(),
      style: const TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      controller.task.value.answer[index].description,
    );
  }

  Widget _buildIcon() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.orange.withOpacity(.2),
      child: Text(
        '${controller.task.value.executor.firstName[0].toUpperCase()}${controller.task.value.executor.lastName[0].toUpperCase()}',
        style: const TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class AnswerGallery extends GetView<TaskController> {
  const AnswerGallery({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiConstants.defaultPadding * 2),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: controller.task.value.answer[index].answerImages.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: UiConstants.defaultPadding * 0.4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(UiConstants.defaultPadding * 2),
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(UiConstants.defaultPadding * 2),
              onTap: () {
                Get.to(()=>AnswerImageCarousel(
                  currentIndex: i,
                  images: controller.task.value.answer[index].answerImages,
                ));
              },
              child: SizedBox(
                width: 50,
                height: 60,
                child: ExtendedImage.network(
                  controller.task.value.answer[index].answerImages[i].url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerImageCarousel extends StatefulWidget {
  const AnswerImageCarousel(
      {Key? key, required this.images, required this.currentIndex})
      : super(key: key);

  final List<AnswerImages?> images;
  final int currentIndex;

  @override
  State<AnswerImageCarousel> createState() => _AnswerImageCarouselState();
}

class _AnswerImageCarouselState extends State<AnswerImageCarousel> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: UiConstants.defaultPadding),
              child: Text(
                  "${currentIndex + 1}/${widget.images.length.toString()}",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          )
        ],
      ),
      body: ExtendedImageGesturePageView.builder(
        itemCount: widget.images.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: ExtendedPageController(initialPage: currentIndex),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          String img = widget.images[index]!.url;
          Widget image = ExtendedImage.network(
            img,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (ExtendedImageState state) {
              return GestureConfig(
                minScale: 1.005,
                animationMinScale: 0.1,
                maxScale: 4.0,
                animationMaxScale: 4.5,
                speed: 1.0,
                initialScale: 1.005,
                inPageView: true,
                initialAlignment: InitialAlignment.center,
                reverseMousePointerScrollDirection: true,
              );
            },
          );
          image = Container(
            padding: const EdgeInsets.all(5.0),
            child: image,
          );

          if (index == currentIndex) {
            return Hero(tag: img + index.toString(), child: image);
          } else {
            return image;
          }
        },
      ),
    );
  }
}
