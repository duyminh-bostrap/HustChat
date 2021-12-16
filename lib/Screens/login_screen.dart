import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'package:hust_chat/Screens/Widget/rounded_input_field.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/network_handler.dart';

import 'Widget/rounded_password_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(
          0xffff8a84,
        ),
        title: Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 21),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: BackGround(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              rounded_input_field(
                size: size,
                text: "Số điện thoại",
                inputController: phoneController,
              ),
              rounded_password_field(
                size: size,
                text: "Mật khẩu",
                passwordController: passwordController,
              ),
              SizedBox(
                // width: size.width * 0.3,
                height: size.height * 0.07,
              ),
              Row(
                children: [
                  SizedBox(
                    // height: size.height * 0.8,
                    width: size.width * 0.1,
                  ),
                  rounded_button(
                      onPressed: () async {
                        Map<String, String> data = {
                          "phonenumber": phoneController.text,
                          "password": passwordController.text
                        };
                        var response =
                            await networkHandler.post("/users/login", data);
                        Map output = json.decode(response.body);
                        String token = "bearer " + output['token'];

                        if (response.statusCode < 300) {
                          // getInfo();
                          print(output);
                          await storage.write(
                              key: "id", value: output["data"]["id"]);
                          await storage.write(key: "token", value: token);
                          await storage.write(
                              key: "username",
                              value: output["data"]["username"]);
                          Navigator.pushNamed(context, '/mainpage');
                        }
                        // Navigator.pushNamed(context, '/mainpage');
                      },
                      text: "Đăng nhập"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
