import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:road_work_front_end/pages/map/models/geo_json_response.dart';
import 'package:road_work_front_end/pages/map/models/get_task_to_map_response.dart';
import 'package:road_work_front_end/service/api_service.dart';

class MapPageController extends GetxController {
  final isLoading = false.obs;
  final PopupController popupLayerController = PopupController();
  late GeoJsonResponse? geoJsonResponse;
  final markers = <Marker>[].obs;

  final isLoadTask = false.obs;
  List<GetTaskToMapResponse>? tasks = [];

  LatLng? newMarker;
  LatLng oldMarker = LatLng(0, 0);

  @override
  void onInit() {
    getGeoJson();
    super.onInit();
  }

  void getGeoJson() async {
    isLoading(true);
    geoJsonResponse = await ApiService().getGeoJson();

    for (var element in geoJsonResponse!.coordinates!) {
      markers.add(
        Marker(
            point: LatLng(element[0], element[1]),
            builder: (ctx) =>
            const MouseRegion(
              cursor: SystemMouseCursors.click,
              child:
              Icon(Icons.location_on, size: 50.0, color: Colors.indigo),
            )),
      );
    }
    isLoading(false);
  }

  void getTaskToMap(LatLng latLng) async {
    newMarker = latLng;
    if (newMarker!=oldMarker) {
      isLoadTask(true);
      oldMarker = newMarker!;
      tasks = await ApiService().getTaskToMap(latLng);
      isLoadTask(false);
    }
  }
}
