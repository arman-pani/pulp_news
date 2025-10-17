// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:get_it/get_it.dart';
// import 'package:odiya_news_app/services/auth_service.dart';

// final getIt = GetIt.instance;
// class DioHandler {
//   final Dio dio;
//   DioHandler._internal()
//       : dio = Dio(BaseOptions(
//           baseUrl: "http://127.0.0.1:5001/odiya-news-application/us-central1/",
//           connectTimeout: Duration(milliseconds: 10000),
//           receiveTimeout: Duration(milliseconds: 10000),
//         )) {
    
//     // Add auth interceptor
//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         try {
//           final token = await AuthService.to.getIdToken();
//           if (token != null) {
//             options.headers['Authorization'] = 'Bearer $token';
//             print('Added auth token to request');
//           } else {
//             print('No auth token available');
//           }
//         } catch (e) {
//           print('Error getting auth token: $e');
//         }
//         handler.next(options);
//       },
//       onError: (error, handler) async {
//         if (error.response?.statusCode == 401) {
//           // Token might be expired, try to refresh
//           try {
//             final freshToken = await AuthService.to.getFreshIdToken();
//             if (freshToken != null) {
//               error.requestOptions.headers['Authorization'] = 'Bearer $freshToken';
//               print('Refreshed auth token, retrying request');
              
//               // Retry the request
//               final response = await dio.fetch(error.requestOptions);
//               handler.resolve(response);
//               return;
//             }
//           } catch (e) {
//             print('Error refreshing token: $e');
//           }
//         }
//         handler.next(error);
//       },
//     ));
    
//     // Add logging interceptor
//     dio.interceptors.add(PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: false,
//       responseBody: true,
//       error: true,
//       compact: true,
//     ));
//   }
//   static void setup() {
//     getIt.registerLazySingleton(() => DioHandler._internal());
//   }
// }