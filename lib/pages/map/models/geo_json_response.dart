class GeoJsonResponse {
  GeoJsonResponse({required this.type, required this.coordinates});

  GeoJsonResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = List.castFrom<dynamic, List<dynamic>>(json['coordinates']);
  }

  late final String? type;
  late final List<List<dynamic>>? coordinates;
}
