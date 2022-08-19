import 'dart:convert';

DetectionResultResponse detectionResultResponse(String str) =>
    DetectionResultResponse.fromJson(json.decode(str));

class DetectionResultResponse {
  DetectionResultResponse({
    required this.id,
    required this.images,
    this.description,
    required this.date,
    required this.video,
    required this.returnError,
    required this.inProcessing,
    required this.creator,
  });
  late final int id;
  late final List<Images> images;
  late final Null description;
  late final String date;
  late final String video;
  late final bool returnError;
  late final bool inProcessing;
  late final int creator;

  DetectionResultResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    description = null;
    date = json['date'];
    video = json['video'];
    returnError = json['return_error'];
    inProcessing = json['in_processing'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images.map((e)=>e.toJson()).toList();
    data['description'] = description;
    data['date'] = date;
    data['video'] = video;
    data['return_error'] = returnError;
    data['in_processing'] = inProcessing;
    data['creator'] = creator;
    return data;
  }
}

class Images {
  Images({
    required this.id,
    required this.url,
    required this.latitude,
    required this.longitude,
    required this.countObjects,
    required this.dateTableId,
  });
  late final int id;
  late final String url;
  late final double latitude;
  late final double longitude;
  late final int countObjects;
  late final int dateTableId;

  Images.fromJson(Map<String, dynamic> json){
    id = json['id'];
    url = json['url'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countObjects = json['count_objects'];
    dateTableId = json['date_table_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['count_objects'] = countObjects;
    data['date_table_id'] = dateTableId;
    return data;
  }
}
