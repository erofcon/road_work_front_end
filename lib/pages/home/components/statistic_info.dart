import 'package:flutter/material.dart';
import 'package:road_work_front_end/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';


class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Storage Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: UiConstants.defaultPadding),
          Chart(),
          StorageInfoCard(

          ),
          StorageInfoCard(

          ),
          StorageInfoCard(

          ),
          StorageInfoCard(

          ),
        ],
      ),
    );
  }
}




class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: UiConstants.defaultPadding),
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.teal),
        borderRadius: const BorderRadius.all(
          Radius.circular(UiConstants.defaultPadding),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            height: 20,
            width: 20,
            child: Icon(Icons.access_time),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ssdsdsd',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "sdssd Files",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Text('sdsdsd')
        ],
      ),
    );
  }
}







class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: UiConstants.defaultPadding),
                Text(
                  "29.1",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
                ),
                Text("of 128GB")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: Colors.teal,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: Colors.blue,
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
