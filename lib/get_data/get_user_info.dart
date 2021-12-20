import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';

import 'package:hust_chat/models/models.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class UsersApi {
  static Future<List<UserData>> getUsersData(
      TextEditingController textcontroller) async {
    String? token = await storage.read(key: "token");
    // print(token);
    if (token != null) {
      Map<String, String> data = {
        "keyword": textcontroller.text,
      };
      print(data);
      var response =
          await networkHandler.postAuth("/users/search", data, token);
      debugPrint(response.body);
      final users = searchUserFromJson(response.body);
      debugPrint(response.body);
      final List<UserData> user = users.data;
      // debugPrint(response.body);
      return user;
    }
    return [];
  }

  static Future<List<UserData>> getUsers() async {
    String? token = await storage.read(key: "token");
    // print(token);
    if (token != null) {
      Map<String, String> data = {
        "keyword": "",
      };
      print(data);
      var response =
          await networkHandler.postAuth("/users/search", data, token);
      // debugPrint(response.body);
      final users = searchUserFromJson(response.body);
      // debugPrint(response.body);
      final List<UserData> user = users.data;
      // debugPrint(response.body);
      return user;
    }
    return [];
  }
}
