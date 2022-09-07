import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';

import '../../../utils/helpers/map_helpers.dart';

class TaskLocation extends GetView<TaskController> {
  const TaskLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 350,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(controller.task.value.latitude!,
              controller.task.value.longitude!),
          zoom: 9.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: MapHelpers.lightMapTile,
          ),
          MarkerLayerOptions(markers: [
            Marker(
              point: LatLng(controller.task.value.latitude!,
                  controller.task.value.longitude!),
              builder: (ctx) => const Icon(Icons.location_on,
                  size: 50.0, color: Colors.indigo),
            )
          ]),
          // MarkerLayerOptions(markers: markers)
        ],
      ),
    );
  }
}
