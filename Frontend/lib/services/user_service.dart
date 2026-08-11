import 'package:dio/dio.dart';
import 'package:roomnest/models/user_profile.dart';
import 'package:roomnest/services/dio_client.dart';

class UserService {
  final Dio _dio = DioClient().dio;

  Future<UserProfile> getCurrentUser() async {
    try {
      final response = await _dio.get("/users/me");

      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data is Map
          ? e.response?.data["message"]
          : e.message;

      throw Exception(message ?? "Failed to fetch user profile");
    }
  }
}
