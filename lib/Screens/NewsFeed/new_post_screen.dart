import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/main_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/network_handler.dart';

String link = currentUser.imageUrl;

class CreatePost extends StatefulWidget {
  CreatePost({
    Key? key,
  }) : super(key: key);

  @override
  _CreatePost createState() => _CreatePost();
}
class _CreatePost extends State<CreatePost> {
  bool isListIcons = false;
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  _CreatePost({
  Key? key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController status = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  color: pinkColor,
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        color: pinkColor,
                      ),
                      Container(
                        height: size.height * 0.063,
                        color: pinkColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.15,
                              child: IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  size: 32,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.15,
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Center(
                                child: Text(
                                  'Tạo bài viết',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: RaisedButton(
                                    onPressed: () => AddNewPost(status, context),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25))),
                                    child: Text(
                                      'Đăng',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/mytimeline');
                        },
                        child: ProfileAvatar(
                          imageUrl: link,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/mytimeline');
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  showName(
                                    color: Colors.black87,
                                    size: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // Text(
                                  //   currentUser.name,
                                  //   style: TextStyle(
                                  //       color: Colors.black87,
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        'Công khai',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                        // fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.public,
                                        color: Colors.grey[600],
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: status,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                        hintText: 'Bạn đang nghĩ gì?',
                        hintStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                    width: size.width,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child:
                        image != null ?
                      Image.file(image!, width: size.width, fit: BoxFit.fitWidth,)
                      : SizedBox(height: 10,),
                ),
                SizedBox(height: 100,)
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isListIcons = isListIcons? false : true;
                    });
                  },
                  child: isListIcons?
                  Container(
                      width: size.width,
                      height: 210,
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child:
                            GestureDetector(
                              onTap: () => pickImage(ImageSource.gallery),
                              child: Row(
                                children: [
                                  Icon(Icons.collections, size: 28, color: Color.fromRGBO(74, 198, 104, 1.0)),
                                  SizedBox(width: 15),
                                  Text('Chọn ảnh từ thư viện',
                                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 10, color: Colors.white, thickness: 1.2,),
                          Expanded(
                            child:
                            GestureDetector(
                              onTap: () => pickImage(ImageSource.camera),
                              child: Row(
                                children: [
                                  Icon(Icons.photo_camera, size: 28, color: blueColor),
                                  SizedBox(width: 15),
                                  Text('Chụp ảnh / Quay video',
                                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 10, color: Colors.white, thickness: 1.2,),
                          Expanded(
                            child:
                            GestureDetector(
                              onTap: () => pickImage(ImageSource.gallery),
                              child: Row(
                                children: [
                                  Icon(Icons.videocam, size: 28, color: Colors.redAccent),
                                  SizedBox(width: 15),
                                  Text('Chọn video từ thư viện',
                                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  )
                  : Container(
                      width: size.width,
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              'Thêm vào bài viết của bạn',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.collections, size: 28, color: Color.fromRGBO(74, 198, 104, 1.0)),
                          SizedBox(width: 5,),
                          Icon(Icons.photo_camera, size: 28, color: blueColor),
                          SizedBox(width: 5,),
                          Icon(Icons.videocam, size: 28, color: Colors.redAccent),
                          SizedBox(width: 15,),
                        ],
                      )
                  ),
                )
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
          height: 0,
        ),
      ),
    );
  }
}

AddNewPost(TextEditingController status, context) async {
  final storage = new FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String? userId = await storage.read(key: "id");
  String? token = await storage.read(key: "token");
  if (userId != null && token != null) {
    Map<String, String> data = {
      "id": userId,
      "described": status.text,
    };
    var response = await networkHandler.postAuth("/posts/create", data, token);
    Map output = json.decode(response.body);
    if (response.statusCode < 300) {
      print(output);
      Navigator.pop(context);
    }
  }
}
