import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'package:hust_chat/Screens/Widget/rounded_input_field.dart';
import 'package:hust_chat/network_handler.dart';
import 'Message/auth_firebase.dart';
import 'Message/database_firebase.dart';
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
  final formKey = GlobalKey<FormState>();
  bool isIncorrect = false;

  // for Firebase login
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Scaffold(
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
                  validator: (value) {
                    if (value!.isEmpty) return "Bạn chưa nhập số điện thoại";
                    if (value.length < 1 ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]+$').hasMatch(value) ||
                        isIncorrect) {
                      return "Số điện thoại không chính xác";
                    }
                    return null;
                  },
                ),
                rounded_password_field(
                  size: size,
                  text: "Mật khẩu",
                  passwordController: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return "Bạn chưa nhập mật khẩu";
                    if (value.length < 1 || isIncorrect) {
                      return "Mật khẩu không chính xác";
                    }
                    return null;
                  },
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
                          if (formKey.currentState!.validate()) {

                            // ------firebase --------//
                            /*
                            * Data User có dạng Map {
                            * "username":something
                            * "email": somthing@gmail.com
                            * }
                            * */
                            Map<String, String> userInforMap = {
                              "name": phoneController.text,
                              "email":passwordController.text
                            };
                            authMethods.signInWithPhoneNumberAndPassword(phoneController.text+"@gmail.com",
                                passwordController.text).then((value) {
                            });
                            // --- end Firebase -- //


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
                            if (response.statusCode > 300){
                              print('sai mk');
                              setState(() {
                                isIncorrect = true;
                              });
                            }
                          }
                        },
                        text: "Đăng nhập"),
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
