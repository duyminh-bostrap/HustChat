import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/network_handler.dart';

String link = "http://wikicraze.com/wp-content/uploads/2018/08/alone-boy-5.jpg";

class ImagePostElement extends StatelessWidget {
  const ImagePostElement(
      {Key? key, required this.image, required this.iconButton})
      : super(key: key);
  final Image image;
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: image,
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              child: iconButton,
            ))
      ],
    );
  }
}

class CreatePost extends StatefulWidget {
  CreatePost({
    Key? key,
  }) : super(key: key);

  @override
  _CreatePost createState() => _CreatePost();
}

class _CreatePost extends State<CreatePost> {
  List<XFile> _imageFileList = List<XFile>.empty(growable: true);
  XFile? _videoFile;
  bool isListIcons = false;
  File? image;
  TextEditingController status = TextEditingController();

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

  _CreatePost({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isOpenKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

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
                                  'Tạo bài viết',
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
                                    onPressed: () => _createPost(status.text,
                                        _imageFileList, _videoFile, context),
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
                  height: 200,
                  child: Expanded(
                      child: _imageFileList == null
                          ? Container()
                          : GridView.builder(
                              itemCount: _imageFileList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return ImagePostElement(
                                    image: Image.file(
                                      File(_imageFileList[index].path),
                                      fit: BoxFit.contain,
                                    ),
                                    iconButton: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _imageFileList.removeAt(index);
                                        });
                                      },
                                      icon: Icon(Icons.close),
                                      iconSize: 20,
                                    ));
                              })),
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
                          height: 210,
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
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
                          height: 60,
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Row(
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
                          )),
                ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: 0,
          ),
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

_createPost(
    String described, List<XFile> imageFileList, XFile? video, context) async {
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

  Map data = {
    "described": described,
    "images": imagesByte.isEmpty ? [] : imagesByte,
    "videos": []
  };

  var response = await networkHandler.postAuth1("/posts/create", data, token);
  if (response.statusCode < 300) {
    print("success");
    Navigator.pop(context);
  } else {
    print("failed");
  }
}
