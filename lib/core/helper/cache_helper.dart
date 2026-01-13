import 'dart:convert';

import 'package:Store/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  //get token
  static Future<String> getToken() async {
    return await storage.read(key: 'token') ?? "";
  }

  //save token
  static Future saveToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  //delete token
  static Future deleteToken() async {
    return await storage.delete(key: 'token');
  }

  // save user
  static Future saveUser(UserModel user) async {
    return await storage.write(key: 'user', value: jsonEncode(user.toJson()));
  }

  // get user
  static Future<UserModel?> getUser() async {
    final userString = await storage.read(key: 'user');
    if (userString == null) return null;

    return UserModel.fromJson(jsonDecode(userString));
  }

  // delete user
  static Future<void> deleteUser() async {
    await storage.delete(key: 'user');
    await storage.delete(key: 'token');
  }
}
