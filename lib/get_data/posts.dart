import 'dart:convert';
import 'package:flutter/material.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();
void getInfo() async {
  String? token = await storage.read(key: "token");
  if (token != null) {
    var response =
    await networkHandler.getWithAuth("/users/change-password", token);
    Map output = json.decode(response.body);
    print(output["data"]["username"]);
  }
}

class Posts {
  final String username;
  final String described;
  final String timeAgo;
  Posts(
      {required this.username, required this.described, required this.timeAgo});
}
