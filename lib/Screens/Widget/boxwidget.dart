import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    Key? key,
    required this.text1,
    required this.text2,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colorsGradient1),
          ),
          height: 80,
          width: 190,

          // color: greenColor,
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Flexible(
                      child: Text(
                        text1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      )),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                      child: Text(
                        text2,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}