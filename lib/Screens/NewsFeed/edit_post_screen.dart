import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hust_chat/Screens/NewsFeed/new_post_screen.dart';
import 'package:hust_chat/Screens/NewsFeed/post_view.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/img_model.dart';
import 'package:hust_chat/models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/network_handler.dart';

String link = dotenv.env['link'] ?? "";
NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class EditPostScreen extends StatefulWidget {
  final PostData post;

  EditPostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _EditPostScreen createState() => _EditPostScreen(post: post);
}

class _EditPostScreen extends State<EditPostScreen> {
  final PostData post;
  List<XFile> _imageFileList = List<XFile>.empty(growable: true);
  List<ImageModel> imageOldList = List<ImageModel>.empty(growable: true);
  XFile? _videoFile;
  bool isListIcons = false;
  File? image;
  TextEditingController status = TextEditingController();
  bool setAtStart = true;

  _EditPostScreen({
    Key? key,
    required this.post,
  });

  _pickImage() async {
    final pickedFileList =
        await ImagePicker().pickMultiImage(maxHeight: 120, maxWidth: 120);
    if (pickedFileList!.isNotEmpty) {
      setState(() {
        _imageFileList = pickedFileList;
      });
    }
  }

  _pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        _videoFile = pickedVideo;
      });
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 200, maxHeight: 200);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isOpenKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    if (setAtStart) {
      status.text = post.content;
      imageOldList.addAll(post.images);
      setAtStart = false;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                                  'Chỉnh sửa bài viết',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: RaisedButton(
                                    onPressed: () => _editPost(
                                        status.text,
                                        _imageFileList,
                                        imageOldList,
                                        _videoFile,
                                        context,post),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
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
                            onTap: () {},
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.username,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
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
                imageOldList != null
                    ? Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                        height: 480,
                        child: ListView.builder(
                            itemCount: _imageFileList != null
                                ? _imageFileList.length + imageOldList.length
                                : imageOldList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      index < _imageFileList.length
                                          ? Container(
                                              width: size.width,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Image.file(
                                                  File(_imageFileList[index]
                                                      .path),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: size.width,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$host${post.images[index - _imageFileList.length].name}",
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              print(index -
                                                  _imageFileList.length);
                                              index < _imageFileList.length
                                                  ? _imageFileList.removeAt(
                                                      index)
                                                  : imageOldList.removeAt(
                                                      index -
                                                          _imageFileList
                                                              .length);
                                            });
                                          },
                                          child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 23,
                                                color: Colors.white,
                                              )))),
                                ],
                              );
                            }),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                // Container(
                //     width: size.width,
                //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                //     // alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(30)),
                //     ),
                //     child:
                //         image != null ?
                //       Image.file(image!, width: size.width, fit: BoxFit.fitWidth,)
                //       : SizedBox(height: 10,),
                // ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      if (isOpenKeyboard) {
                        FocusScope.of(context).unfocus();
                        isListIcons = true;
                      } else {
                        isListIcons = isListIcons ? false : true;
                      }
                      ;
                    });
                  },
                  child: isListIcons
                      ? Container(
                          width: size.width,
                          height: 200,
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(54, 54, 54, 1.0),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: Row(
                                    children: [
                                      Icon(Icons.collections,
                                          size: 28,
                                          color: Color.fromRGBO(
                                              74, 198, 104, 1.0)),
                                      SizedBox(width: 15),
                                      Text('Chọn ảnh từ thư viện',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.white,
                                thickness: 1.2,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => pickImage(ImageSource.camera),
                                  child: Row(
                                    children: [
                                      Icon(Icons.photo_camera,
                                          size: 28, color: blueColor),
                                      SizedBox(width: 15),
                                      Text('Chụp ảnh / Quay video',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.white,
                                thickness: 1.2,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _pickVideo(),
                                  child: Row(
                                    children: [
                                      Icon(Icons.videocam,
                                          size: 28, color: Colors.redAccent),
                                      SizedBox(width: 15),
                                      Text('Chọn video từ thư viện',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                      : Container(
                          width: size.width,
                          height: 65,
                          padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(54, 54, 54, 1.0),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 5,
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Thêm vào bài viết của bạn',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.collections,
                                      size: 28,
                                      color: Color.fromRGBO(74, 198, 104, 1.0)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.photo_camera,
                                      size: 28, color: blueColor),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.videocam,
                                      size: 28, color: Colors.redAccent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ],
                          )),
                ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(54, 54, 54, 1.0),
          child: Container(
            height: 0,
          ),
        ),
      ),
    );
  }
}

_editPost(
    String described,
    List<XFile> imageFileList,
    List<ImageModel> imageOldList,
    XFile? videoFile,
    BuildContext context,
    PostData post) async {
  final token = await storage.read(key: "token") ?? "";

  List<String> imagesByte = List<String>.empty(growable: true);

  if (imageFileList.isNotEmpty) {
    List<File> listFile =
        imageFileList.map((image) => File(image.path)).toList();
    imagesByte.addAll(listFile
        .map((e) =>
            "data:image/jpeg;base64," + base64.encode(e.readAsBytesSync()))
        .toList());
  }

  File videoFile;
  String url = "/posts/edit/" + post.id;
  Map data = {
    "described": described,
    "images": imagesByte.isEmpty ? [] : imagesByte,
    "videos": []
  };

  var response = await networkHandler.postAuth1(url, data, token);
  if (response.statusCode < 300) {
    print("success");
    Navigator.pop(context);
  } else {
    print("failed");
  }
}
