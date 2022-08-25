import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:road_work_front_end/pages/map/controller/map_controller.dart';

import 'components/map_alert.dart';

class MapPage extends GetView<MapPageController> {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return FlutterMap(
            options: MapOptions(
              maxZoom: 18,
              zoom: 5.0,
              center: LatLng(43.1211212, 44.12121212),
              onTap: (_, __) => controller.popupLayerController
                  .hideAllPopups(), // Hide popup when the map is tapped.
            ),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate:
                      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425',
                ),
              ),
              PopupMarkerLayerWidget(
                options: PopupMarkerLayerOptions(
                    popupController: controller.popupLayerController,
                    markers: controller.markers,
                    markerRotateAlignment:
                        PopupMarkerLayerOptions.rotationAlignmentFor(
                            AnchorAlign.top),
                    popupBuilder: (BuildContext context, Marker marker) {
                      controller.getTaskToMap(marker.point);
                      return const MapAlert();
                    }),
              ),
            ],
          );
        }
      }),
    );
  }
}
