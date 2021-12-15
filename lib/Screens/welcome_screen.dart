import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'Widget/background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/top_logo.png',
              width: size.width,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            rounded_button(
              text: "Đăng nhập",
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            SizedBox(
              height: 10,
            ),
            rounded_button(
              text: "Đăng ký",
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            )
          ],
        ),
      ),
    );
  }
}
