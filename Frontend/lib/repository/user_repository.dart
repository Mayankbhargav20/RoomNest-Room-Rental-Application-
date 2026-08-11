import 'package:roomnest/models/user_profile.dart';
import 'package:roomnest/services/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  Future<UserProfile> getCurrentUser() async {
    return await _userService.getCurrentUser();
  }
}
