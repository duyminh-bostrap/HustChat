// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';

class rounded_input_field extends StatelessWidget {
  rounded_input_field({
    Key? key,
    required this.size,
    required this.text,
    required this.inputController,
    required this.validator,
  }) : super(key: key);

  final Size size;
  final String text;
  TextEditingController inputController = TextEditingController();
  String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: size.height * 0.095,
      width: size.width * 0.8,
      child: TextFormField(
        cursorColor: Colors.black87,
        controller: inputController,
        validator: validator,
        // validator(value) {
        //   if (value!.isEmpty) return "Password cannot be empty";
        //   if (value.length <= 8) {
        //     return "Password length must have >=8";
        //   }
        //   return null;
        // },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                    color: greenColor,
                    style: BorderStyle.solid,
                    width: 4)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black,)),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: text,
            fillColor: Colors.white70),
      ),
    );
  }
}
