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

  static Future<UserData> getUserData(String id) async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      // print(userID);
      String url = "/users/show/" + id;
      var response = await networkHandler.getWithAuth(url, token);
      debugPrint(response.body);
      // final posts = postsFromJson(response.body);
      final json1 = json.decode(response.body)["data"];
      String a = json.encode(json1);
      final UserData user = UserFromJson(a);
      debugPrint(user.phonenumber);
      // debugPrint(post.content);
      // debugPrint(parsed);
      return user;
    }
    return new UserData(
      gender: "",
      blockedInbox: [],
      blockedDiary: [],
      id: "",
      phonenumber: "",
      password: "",
      username: "",
      avatar: Avatar(type: "", id: "", fileName: ""),
      coverImage: CoverIMG(type: "", id: "", fileName: ""),
    );
  }
  static Future<UserData> getCurrentUserData() async {
    String? userID = await storage.read(key: "id");
    String? token = await storage.read(key: "token");
    if (token != null && userID != null) {
      // print(userID);
      String url = "/users/show/" + userID;
      var response = await networkHandler.getWithAuth(url, token);
      debugPrint(response.body);
      // final posts = postsFromJson(response.body);
      final json1 = json.decode(response.body)["data"];
      String a = json.encode(json1);
      final UserData user = UserFromJson(a);
      debugPrint(user.phonenumber);
      // debugPrint(post.content);
      // debugPrint(parsed);
      return user;
    }
    return new UserData(
      gender: "",
      blockedInbox: [],
      blockedDiary: [],
      id: "",
      phonenumber: "",
      password: "",
      username: "",
      avatar: Avatar(type: "", id: "", fileName: ""),
      coverImage: CoverIMG(type: "", id: "", fileName: ""),
    );
  }
}
