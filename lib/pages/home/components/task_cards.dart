import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_work_front_end/utils/constants.dart';
import 'package:road_work_front_end/utils/responsive.dart';

class TaskCards extends StatelessWidget {
  const TaskCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: UiConstants.defaultPadding*2),
      child: Column(
        children: <Widget>[
          Responsive(
            mobile: TaskInfo(
              crossAxisCount: context.width < 650 ? 2 : 4,
              childAspectRatio:
                  context.width < 650 && context.width > 350 ? 1.3 : 1,
            ),
            tablet: TaskInfo(
              childAspectRatio: context.width < 950 ? 1 : 2,
            ),
            desktop: const TaskInfo(
              childAspectRatio: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskInfo extends StatelessWidget {
  const TaskInfo({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => const Task(),
    );
  }
}

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(UiConstants.defaultPadding),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Текущие задачи".toUpperCase(),
                style: GoogleFonts.athiti(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(135, 138, 153, 1),
                        letterSpacing: .5))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  size: 64,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "234",
                  style: TextStyle(fontSize: 34),
                ),
              ],
            ),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.open_in_new),
                label: const Text("open"))
          ],
        ),
      );
  }
}

class TaskInfoCard extends StatelessWidget {
  const TaskInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(UiConstants.defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: UiConstants.defaultPadding),
                      child: Text("asdasd".toUpperCase())),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: UiConstants.defaultPadding),
                      child: Text("122")),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black12)),
                    child: Text('sdsdsdsdds'),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(UiConstants.defaultPadding),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(2),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 218, 218, 218),
                  ),
                ],
              ),
              child: const Icon(
                Icons.access_time,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
