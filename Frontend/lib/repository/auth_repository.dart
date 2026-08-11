import 'package:roomnest/models/auth_response.dart';
import 'package:roomnest/models/login_request.dart';
import 'package:roomnest/models/register_request.dart';
import 'package:roomnest/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  // Register User
  Future<String> register(RegisterRequest request) async {
    return await _authService.register(request);
  }

  // Login User
  Future<AuthResponse> login(LoginRequest request) async {
    return await _authService.login(request);
  }
}
