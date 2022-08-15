import 'dart:html';

import 'package:large_file_uploader/large_file_uploader.dart';

import '../../service/web_service.dart';

class WebHelpers {
  static webSelectFile() {
    LargeFileUploader().pick(
        type: FileTypes.video,
        callback: (file) {
          return file;
        });
  }
  static webRunDetection(DateTime dateTime, File videoFile, Function(int) progress){
    WebService().uploadDetection(dateTime, videoFile, (p) => progress, (responce) => null, () => null);
  }
}
