import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/rounded_button.dart';
import 'package:hust_chat/Screens/Widget/rounded_input_field.dart';
import '../../network_handler.dart';
import '../Widget/boxwidget.dart';
import '../Widget/color.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyTimeLineScreen extends StatefulWidget {
  const MyTimeLineScreen({Key? key}) : super(key: key);

  @override
  _MyTimeLineScreenState createState() => _MyTimeLineScreenState();
}

class _MyTimeLineScreenState extends State<MyTimeLineScreen> {
  final storage = new FlutterSecureStorage();
  TextEditingController inputController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  List<int> bottom = <int>[];
  @override
  Widget build(BuildContext context) {
    // const Key centerKey = ValueKey<String>('bottom-sliver-list');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topRight,
                      colors: colorsGradient1),
                ),
                // color: pinkColor,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.red,
                      // width: 200,
                      child: Image.asset(
                        'assets/IMG_8114.JPG',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: whiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                      top: 150,
                      child: Container(
                        // width: 150,
                        // height: 150,
                        // color: Colors.red,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/IMG_9119.JPG'),
                          radius: 75,
                        ),
                      )),
                  Positioned(
                    top: 310,
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 50,
                        // ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Hoài Thu",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: BoxWidget(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/newsfeed');
                                    },
                                    text1: "Bài viết của tôi",
                                    text2: "Xem dòng thời gian của tôi",
                                  ),
                                ),
                                BoxWidget(
                                    onTap: () {},
                                    text1: "Ảnh của tôi",
                                    text2: "Xem tất cả ảnh và video đã đăng"),
                                BoxWidget(
                                  onTap: () {},
                                  text1: "Video của tôi",
                                  text2: "Xem các video đã đăng",
                                ),
                                // BoxWidget()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: 500,
                  //   child: Column(children: [
                  //     Row(
                  //       children: [
                  //         Container(
                  //           height: 50,
                  //           width: 50,
                  //           // color: Colors.red,
                  //           child: CircleAvatar(
                  //             backgroundImage: AssetImage('assets/IMG_9119.JPG'),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 5,
                  //         ),
                  //         rounded_input_field(
                  //             size: Size(size.width * 0.8, size.height),
                  //             text: "Hôm nay bạn nghĩ gì?",
                  //             inputController: inputController),
                  //         GestureDetector(
                  //           onTap: () async {
                  //             String? userId = await storage.read(key: "id");
                  //             String? token = await storage.read(key: "token");
                  //             if (userId != null && token != null) {
                  //               Map<String, String> data = {
                  //                 "id": userId,
                  //                 "described": inputController.text,
                  //               };
                  //               var response = await networkHandler.postAuth(
                  //                   "/posts/create", data, token);
                  //               Map output = json.decode(response.body);

                  //               if (response.statusCode < 300) {
                  //                 inputController.text = "";
                  //                 print(output);
                  //                 setState(() {
                  //                   bottom.add(bottom.length);
                  //                 });
                  //               }
                  //             }
                  //           },
                  //           child: Container(
                  //             height: 50,
                  //             width: 50,
                  //             // color: Colors.red,
                  //             child: Image.asset(
                  //               'assets/watermelon2.png',
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ]),
                  // ),
                ]),
              )),
        ));
  }
}