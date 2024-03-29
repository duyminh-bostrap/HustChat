import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Scaffold(
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
                  passwordController: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return "Password cannot be empty";
                    if (value.length <= 5) {
                      return "Độ dài mật khẩu phải lớn hơn hoặc bằng 6 kí tự";
                    }
                    return null;
                  },
                ),
                rounded_password_field(
                  size: size,
                  text: "Nhập mật khẩu mới",
                  passwordController: passwordController2,
                  validator: (value) {
                    if (value!.isEmpty) return "Password cannot be empty";
                    if (value.length <= 5) {
                      return "Độ dài mật khẩu phải lớn hơn hoặc bằng 6 kí tự";
                    }
                    return null;
                  },
                ),
                rounded_password_field(
                  size: size,
                  text: "Nhập lại mật khẩu",
                  passwordController: passwordController3,
                  validator: (value) {
                    if (value!.isEmpty) return "Password cannot be empty";
                    if (value.length <= 5) {
                      return "Độ dài mật khẩu phải lớn hơn hoặc bằng 6 kí tự";
                    }
                    return null;
                  },
                ),
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
                          if (formKey.currentState!.validate()) {
                            String? token = await storage.read(key: "token");
                            if (token != null) {
                              Map<String, String> data = {
                                "currentPassword": passwordController.text,
                                "newPassword": passwordController2.text
                              };
                              var response = await networkHandler.postAuth(
                                  "/users/change-password", data, token);
                              Map output = json.decode(response.body);
                              print(output);
                              if (output['code'] ==
                                  "CURRENT_PASSWORD_INCORRECT") {
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Mật khẩu cũ không đúng hoặc xác nhận mật khẩu không khớp",
                                      fontSize: 18);
                                });
                                // Navigator.pop(context);
                              } else {
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "Đổi mật khẩu thành công",
                                      fontSize: 18);
                                });
                                Navigator.pop(context);
                              }
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
      ),
    );
  }
}
