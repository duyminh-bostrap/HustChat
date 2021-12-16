import 'dart:convert';

import 'package:hust_chat/models/models.dart';
import 'package:flutter/material.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final User currentUser = User(
  id: 0,
  name: "Name",
  email: "markzuckerberg@facebook.com",
  imageUrl:
  "https://scontent.fhan2-3.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&cb=c578a115-7e291d1f&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=pM4MixqT8AcAX-taJAh&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan2-3.fna&oh=d6547146bd71ff7d889c319978570933&oe=61BB95AF",
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