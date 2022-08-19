import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../models/detection_result_response.dart';

class DetectionResultImageCarousel extends StatefulWidget {
  const DetectionResultImageCarousel(
      {Key? key, required this.images, required this.currentIndex})
      : super(key: key);

  final List<Images?> images;
  final int currentIndex;

  @override
  State<DetectionResultImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<DetectionResultImageCarousel> {
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_to_mobile_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
        ),
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
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: ButtonTheme(
      //     minWidth: 0.0,
      //     padding: EdgeInsets.zero,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: <Widget>[
      //         IconButton(
      //             onPressed: () {},
      //             icon: Icon(
      //               Icons.delete_forever_outlined,
      //               color: Theme.of(context).primaryColor,
      //             )),
      //         IconButton(
      //             onPressed: () {},
      //             icon: Icon(
      //               Icons.edit,
      //               color: Theme.of(context).primaryColor,
      //             )),
      //         IconButton(
      //             onPressed: () {},
      //             icon: Icon(
      //               Icons.send_to_mobile_outlined,
      //               color: Theme.of(context).primaryColor,
      //             )),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
