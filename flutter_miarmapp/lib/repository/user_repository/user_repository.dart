import 'package:flutter_miarmapp/models/user.dart';

abstract class UserRepository {
  Future<User> fetchUsers(String type);
}