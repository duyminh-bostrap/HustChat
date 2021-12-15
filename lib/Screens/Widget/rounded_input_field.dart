// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

class rounded_input_field extends StatelessWidget {
  rounded_input_field({
    Key? key,
    required this.size,
    required this.text,
    required this.inputController,
  }) : super(key: key);

  final Size size;
  final String text;
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: size.height * 0.095,
      width: size.width * 0.8,
      child: TextField(
        controller: inputController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                    color: Color(0xffaedd94),
                    style: BorderStyle.solid,
                    width: 4)),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: text,
            fillColor: Colors.white70),
      ),
    );
  }
}
