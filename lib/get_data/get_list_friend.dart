import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';

import 'package:hust_chat/models/models.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class FriendsApi {
  static Future<List<UserData>> getListFriendsRequested() async {
    String? token = await storage.read(key: "token");
    // print(token);
    if (token != null) {
      var response = await networkHandler.postAuthWithoutBody(
          "/friends/get-requested-friend", token);
      // debugPrint(response.body);
      final users = friendRequestsFromJson(response.body);
      // debugPrint(response.body);
      final List<UserData> user = users.data.friends;
      // debugPrint(response.body);
      return user;
    }
    return [];
  }
}

class ShowListFriendsRequested extends StatelessWidget {
  ShowListFriendsRequested({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserData>>(
        future: FriendsApi.getListFriendsRequested(),
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
            subtitle: Text(user.gender),
          );
        },
      );
}
