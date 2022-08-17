import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

import '../models/task_response.dart';

class Gallery extends GetView<TaskController> {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiConstants.defaultPadding * 2),
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: controller.task.value.images.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: UiConstants.defaultPadding * 0.4),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(UiConstants.defaultPadding * 2),
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(UiConstants.defaultPadding * 2),
                onTap: () {
                  Get.to(()=>ImageCarousel(
                    currentIndex: i,
                    images: controller.task.value.images,
                  ));
                },
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: ExtendedImage.network(
                    cache: true,
                    controller.task.value.images[i]!.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel(
      {Key? key, required this.images, required this.currentIndex})
      : super(key: key);

  final List<Images?> images;
  final int currentIndex;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
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
            cache: true,
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
            cache: true,
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
