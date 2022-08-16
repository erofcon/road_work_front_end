import 'package:large_file_uploader/large_file_uploader.dart';

import '../pages/login/service/login_cache.dart';
import '../utils/constants.dart';

class WebService with LoginCache {
  Future<void> uploadDetection(
      DateTime dateTime,
      dynamic file,
      Function(dynamic progress) uploadProgress,
      Function(dynamic responce) uploadComplete,
      Function() uploadFailure) async {
    final token = await getToken();

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      LargeFileUploader().upload(
          headers: headers,
          uploadUrl: ApiUrl.uploadDetection,
          onSendProgress: uploadProgress,
          onComplete: uploadComplete,
          onFailure: uploadFailure,
          data: {
            'date': dateTime.toString(),
            'video': file,
          });
    }
  }
}
