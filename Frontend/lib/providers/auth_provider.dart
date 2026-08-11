import 'package:flutter/material.dart';
import 'package:roomnest/models/auth_response.dart';
import 'package:roomnest/models/login_request.dart';
import 'package:roomnest/models/register_request.dart';
import 'package:roomnest/repository/auth_repository.dart';
import 'package:roomnest/services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  final StorageService _storageService = StorageService();

  bool _isLoading = false;
  String? _errorMessage;
  AuthResponse? _authResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthResponse? get authResponse => _authResponse;

  // ================= Register =================

  Future<bool> register(RegisterRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.register(request);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  // ================= Login =================

  Future<bool> login(LoginRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _authResponse = await _repository.login(request);

      // Save JWT Token
      await _storageService.saveToken(_authResponse!.token);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  // ================= Get Saved Token =================

  Future<String?> getToken() async {
    return await _storageService.getToken();
  }

  // ================= Logout =================

  Future<void> logout() async {
    await _storageService.deleteToken();

    _authResponse = null;

    notifyListeners();
  }
}
