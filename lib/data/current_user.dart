import 'dart:convert';

import 'package:hust_chat/models/models.dart';
import 'package:flutter/material.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final User currentUser = User(
  id: 0,
  name: "Duy Minh",
  email: "duyminh@facebook.com",
  imageUrl:
    "https://scontent.fhan14-1.fna.fbcdn.net/v/t39.30808-1/c364.828.909.909a/s160x160/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=7206a8&_nc_ohc=uDg0Jhmowo8AX-EoNMg&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan14-1.fna&oh=00_AT9Ap7blZFuWqUX7WzNjRbGrbet7ZlvSCiPLgA7EsGlNcQ&oe=61C23708"
);

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

Future<String> getInfo() async {
  var username = await storage.read(key: "username");
  if (username != null) {
    return username;
  }
  return "";
}