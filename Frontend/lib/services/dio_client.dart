import 'package:dio/dio.dart';
import 'package:roomnest/config/api/api_constants.dart';
import 'package:roomnest/services/storage_service.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    print("ApiConstants.baseUrl = ${ApiConstants.baseUrl}");
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    print("Dio Base URL = ${dio.options.baseUrl}");
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService().getToken();

          print("Saved Token = $token");

          if (!options.path.startsWith("/auth")) {
            if (token != null && token.isNotEmpty) {
              options.headers["Authorization"] = "Bearer $token";
            }
          }

          print("REQUEST => ${options.method} ${options.uri}");
          print("HEADERS => ${options.headers}");

          handler.next(options);
        },

        onResponse: (response, handler) {
          print("RESPONSE => ${response.statusCode}");
          print(response.data);

          handler.next(response);
        },

        onError: (DioException e, handler) {
          print("ERROR => ${e.response?.statusCode}");
          print(e.response?.data);

          handler.next(e);
        },
      ),
    );
  }
}
