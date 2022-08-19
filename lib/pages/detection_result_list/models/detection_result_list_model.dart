import 'dart:convert';

DetectionResultListResponse detectionResultListResponse(String str) =>
    DetectionResultListResponse.fromJson(json.decode(str));

class DetectionResultListResponse {
  DetectionResultListResponse({
    required this.id,
    required this.date,
    required this.countImg,
    this.description,
    required this.video,
    required this.returnError,
    required this.inProcessing,
    required this.creator,
  });

  late final int id;
  late final String date;
  late final int countImg;
  late final Null description;
  late final String video;
  late final bool returnError;
  late final bool inProcessing;
  late final int creator;

  DetectionResultListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    countImg = json['count_img'];
    description = null;
    video = json['video'];
    returnError = json['return_error'];
    inProcessing = json['in_processing'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['count_img'] = countImg;
    data['description'] = description;
    data['video'] = video;
    data['return_error'] = returnError;
    data['in_processing'] = inProcessing;
    data['creator'] = creator;
    return data;
  }
}
