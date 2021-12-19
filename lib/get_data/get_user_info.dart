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
      appBar: AppBar(
        backgroundColor: pinkColor,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tìm kiếm',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
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
                return users != null
                    ? buildUsers(users)
                    : Text('Không có kết quả phù hợp',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ));
                ;
              }
          }
        },
      ),
    );
  }

  Widget buildUsers(List<UserData> users) {
    var listView = ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return GestureDetector(
          onTap: () async {
            String? token = await storage.read(key: "token");

            if (token != null) {
              Map<String, String> data = {
                "user_id": user.id,
              };
              var response = await networkHandler.postAuth(
                  "/friends/set-request-friend", data, token);
              debugPrint(response.body);
            }
            ;
          },
          child: ListTile(
            title: Text(user.username),
            subtitle: Text(user.phonenumber),
          ),
        );
      },
    );
    return listView;
  }
}
