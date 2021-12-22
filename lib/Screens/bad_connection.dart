import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'package:hust_chat/Screens/Widget/rounded_input_field.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/network_handler.dart';

import 'Widget/rounded_password_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BadConnection extends StatefulWidget {
  const BadConnection({Key? key}) : super(key: key);

  @override
  State<BadConnection> createState() => _BadConnection();
}

class _BadConnection extends State<BadConnection> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();
  final formKey = GlobalKey<FormState>();
  bool isIncorrect = false;


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
          'Lỗi kết nối',
          style: TextStyle(fontSize: 21),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: BackGround(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, color: pinkColor, size: 150,),
              Text(
                'Lỗi kết nối',
                style: TextStyle(
                  color: pinkColor,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 120,),
            ],
          ),
        ),
      ),
    );
  }
}
