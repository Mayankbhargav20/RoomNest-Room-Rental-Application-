import 'package:dio/dio.dart';
import 'package:roomnest/models/auth_response.dart';
import 'package:roomnest/models/login_request.dart';
import 'package:roomnest/models/register_request.dart';
import 'package:roomnest/services/dio_client.dart';

class AuthService {
  AuthService() {
    print("AuthService Created");
  }
  final Dio _dio = DioClient().dio;

  // Register
  Future<String> register(RegisterRequest request) async {
    print(request.toJson());
    try {
      final response = await _dio.post(
        "/auth/register",
        data: request.toJson(),
      );

      return response.data["message"];
    } on DioException catch (e) {
      print("Type: ${e.type}");
      print("Error: ${e.error}");
      print("Message: ${e.message}");
      print("Base URL: ${_dio.options.baseUrl}");
      print("URI: ${e.requestOptions.uri}");

      rethrow;
    }
  }

  // Login
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post("/auth/login", data: request.toJson());

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data is Map
          ? e.response?.data["message"]
          : e.message;

      throw Exception(message ?? "Login Failed");
    }
  }
}
