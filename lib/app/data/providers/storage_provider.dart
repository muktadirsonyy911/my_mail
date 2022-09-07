import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:my_mail/app/data/models/user_model.dart';

class StorageProvider {
  static StorageProvider object = StorageProvider._();

  StorageProvider._();

  ///---Access token
  Future<void> setUserToken(String token) async {
    GetStorage db = GetStorage(DbStrings.dbName);
    await db.write(DbStrings.userToken, token);
    await db.save();
  }

  String? getUserToken() {
    GetStorage db = GetStorage(DbStrings.dbName);
    String? token = db.read(
      DbStrings.userToken,
    );
    return token;
  }

  ///---User info
  Future<void> setUserData(UserModel user) async {
    String userString = jsonEncode(user);
    GetStorage db = GetStorage(DbStrings.dbName);
    await db.write(DbStrings.userData, userString);
    await db.save();
  }

  UserModel? getUserData() {
    GetStorage db = GetStorage(DbStrings.dbName);
    String userString = db.read(DbStrings.userData);
    return UserModel.fromJson(jsonDecode(userString));
  }

  ///---Log out
  Future<void> logout() async {
    GetStorage db = GetStorage(DbStrings.dbName);
    await db.remove(DbStrings.userToken);
    await db.remove(DbStrings.dbName);
    await db.remove(DbStrings.userData);
  }
}

class DbStrings {
  static const dbName = 'local_save';
  static const userToken = 'user_token';
  static const userData = 'user_data';
}
