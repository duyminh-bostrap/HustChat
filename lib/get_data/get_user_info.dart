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
}

class ShowUserSearchInfo extends StatelessWidget {
  ShowUserSearchInfo({
    Key? key,
    required this.textcontroller,
  }) : super(key: key);
  TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserData>>(
        future: UsersApi.getUsersData(textcontroller),
        builder: (context, snapshot) {
          final users = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                color: pinkColor,
              ));
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                return buildUsers(users!);
              }
          }
        },
      ),
    );
  }

  Widget buildUsers(List<UserData> users) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return ListTile(
            title: Text(user.username),
            subtitle: Text(user.phonenumber),
          );
        },
      );
}
