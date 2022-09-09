// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import '../pages/login/models/refresh_response.dart';
// import '../pages/login/service/login_cache.dart';
// import '../utils/constants.dart';

// class TApi with LoginCache {
//   final Dio api = Dio();
//
//   TApi() {
//     api.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) async {
//       final token = await getToken();
//       options.headers["Authorization"] = "Bearer $token";
//       return handler.next(options);
//     }, onError: (DioError error, handler) async {
//       print(error.response?.statusCode);
//       if (error.response?.statusCode == 401) {
//         if (await refreshToken()) {
//           return handler.resolve(await _retry(error.requestOptions));
//         }
//       }
//     }));
//   }
//
//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return api.request<dynamic>(requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: options);
//   }
//
//   Future<bool> refreshToken() async {
//     final refresh = await getRefreshToken();
//
//     if (refresh != null) {
//       final response =
//           await api.post(ApiUrl.refreshToken, data: {"refresh": refresh});
//
//       if (response.statusCode == HttpStatus.created) {
//         var result = RefreshResponse.fromJson(response.data);
//         updateToken(result.access!);
//         return true;
//       } else {
//         await logout();
//         return false;
//       }
//     }
//     return false;
//   }
// }
