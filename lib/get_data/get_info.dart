import 'dart:convert';
import 'package:flutter/material.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();
// void getInfo() async {
//   String? token = await storage.read(key: "token");
//   if (token != null) {
//     var response =
//         await networkHandler.getWithAuth("/users/login", token);
//     Map output = json.decode(response.body);
//     print(output["data"]["username"]);
//   }
// }

showUsername() async {
  var username = await storage.read(key: "username");
  if (username != null) {
    return username;
  }
  return "";
}

class showName extends StatelessWidget {
  final Color color;
  final double size;
  final FontWeight fontWeight;

  const showName({
    Key? key,
    required this.color,
    required this.size,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: showUsername(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //                       if (snapshot.connectionState == ConnectionState.waiting) {
          // return CircularProgressIndicator();
          // }
          if (snapshot.hasData) {
            return Text(
              snapshot.data,
              style: TextStyle(
                  color: color,
                  fontSize: size,
                  fontWeight: fontWeight),
            );
          }
          return Container();
        });
  }
}
