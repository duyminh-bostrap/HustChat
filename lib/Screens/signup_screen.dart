import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'package:hust_chat/Screens/Widget/rounded_input_field.dart';
import 'package:hust_chat/network_handler.dart';
import 'dart:convert';
import 'Widget/rounded_password_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xffff8a84),
        title: Text(
          'Đăng ký',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: BackGround(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              rounded_input_field(
                size: size,
                text: "Tên",
                inputController: nameController,
              ),
              rounded_input_field(
                size: size,
                text: "Số điện thoại",
                inputController: phoneController,
              ),
              rounded_password_field(
                  size: size,
                  text: "Mật khẩu",
                  passwordController: passwordController),
              rounded_password_field(
                size: size,
                text: "Nhập lại mật khẩu",
                passwordController: passwordController2,
              ),
              SizedBox(
                height: size.height * 0.065,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  rounded_button(
                      onPressed: () async {
                        Map<String, String> data = {
                          "username": nameController.text,
                          "phonenumber": phoneController.text,
                          "password": passwordController.text
                        };
                        // print(data);

                        var response =
                        await networkHandler.post("/users/register", data);
                        Map output = json.decode(response.body);
                        if (response.statusCode < 300) {
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                      text: "Đăng ký"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}