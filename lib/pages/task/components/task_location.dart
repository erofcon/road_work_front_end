import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';



class TaskLocation extends GetView<TaskController> {
  const TaskLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 350,
      child: FlutterMap(
        options: MapOptions(
          // enableScrollWheel: false,
          center: LatLng(controller.task.value.latitude!, controller.task.value.longitude!),
          zoom: 9.0,
          // plugins: [
          //   ZoomButtonsPlugin(),
          // ],
          // onTap: _handleTap,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://a.tile.openstreetmap.de/{z}/{x}/{y}.png',
          ),
          MarkerLayerOptions(markers: [
            Marker(
              point: LatLng(controller.task.value.latitude!, controller.task.value.longitude!),
              builder: (ctx) =>
              const Icon(Icons.location_on, size: 50.0, color: Colors.indigo),
            )
          ]),
          // MarkerLayerOptions(markers: markers)
        ],
        // nonRotatedLayers: [
        //   ZoomButtonsPluginOption(
        //       minZoom: 4,
        //       maxZoom: 15,
        //       mini: true,
        //       padding: defaultPadding,
        //       alignment: Alignment.bottomRight)
        // ],
      ),
    );
  }
}
