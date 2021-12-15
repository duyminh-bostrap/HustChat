import 'package:flutter/material.dart';

class rounded_button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  rounded_button({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: SizedBox(
              width: 180,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),

                // style: ButtonStyle(

                //     padding:
                //         MaterialStateProperty.all(const EdgeInsets.all(10)),
                //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(40),
                //         ))),
                child:  Row(
                  children: [
                    SizedBox(width: 40,),
                    Text(
                      text,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                onPressed: onPressed,
              ),
            ),
          ),
          Positioned(
              left: 0,
              child: Image.asset(
                'assets/watermelon2.png',
                height: 60,
              )),
        ],
      ),
    );
  }
}
