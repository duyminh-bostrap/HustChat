import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'package:hust_chat/Screens/Widget/rounded_password_field.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/network_handler.dart';


class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController passwordController3 = TextEditingController();
  final storage = new FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: pinkColor,
        title: Text(
          'Đổi mật khẩu',
          style: TextStyle(fontSize: 21),
        ),
      ),
      body: Container(
        child: BackGround(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.10,
              ),
              rounded_password_field(
                  size: size,
                  text: "Mật khẩu hiện tại",
                  passwordController: passwordController),
              rounded_password_field(
                  size: size,
                  text: "Nhập mật khẩu mới",
                  passwordController: passwordController2),
              rounded_password_field(
                  size: size,
                  text: "Nhập lại mật khẩu",
                  passwordController: passwordController3),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  rounded_button(
                      onPressed: () async {
                        String? userId = await storage.read(key: "id");
                        String? token = await storage.read(key: "token");
                        if (userId != null && token != null) {
                          Map<String, String> data = {
                            "id": userId,
                            "currentPassword": passwordController.text,
                            "newPassword": passwordController2.text
                          };
                          var response = await networkHandler.postAuth(
                              "/users/change-password", data, token);
                          Map output = json.decode(response.body);
                          print(output);
                          if (response.statusCode < 300) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      text: "Cập nhật")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}