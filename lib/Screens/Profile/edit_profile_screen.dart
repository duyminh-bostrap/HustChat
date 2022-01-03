import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/Screens/NewsFeed/new_post_screen.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/Widget/rounded_input_field.dart';
import 'package:hust_chat/get_data/get_user_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:image_picker/image_picker.dart';

import '../../network_handler.dart';


String link = dotenv.env['link']??"";
String link2 = dotenv.env['link2']??"";
String host = dotenv.env['host'] ?? "";

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

// class EditProfilePage extends StatefulWidget {
//
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   TextEditingController gender = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) => ThemeSwitchingArea(
//     child: Builder(
//       builder: (context) => Scaffold(
//         body: ListView(
//           padding: EdgeInsets.symmetric(horizontal: 32),
//           physics: BouncingScrollPhysics(),
//           children: [
//             ProfileAvatar(
//               imageUrl: '',
//             ),
//             const SizedBox(height: 24),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Giới tính',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: gender,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     ),
//   );
// }
class EditProfilePage extends StatefulWidget {
  EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  XFile? coverImage;
  XFile? avatarImage;
  bool isListIcons = false;
  int? selectGender = 0;
  String? gender;
  File? image;
  TextEditingController status = TextEditingController();
  TextEditingController textGender = TextEditingController();
  TextEditingController Username = TextEditingController();
  TextEditingController phone = TextEditingController();

  pickCoverImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        coverImage = pickedFile;
      });
    }
    Navigator.pop(context);
  }
  pickAvatarImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        avatarImage = pickedFile;
      });
    }
    Navigator.pop(context);
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

  _EditProfilePageState({
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
                  height: size.height * 0.123,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ảnh bìa',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          changeCoverPhoto(context);
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17 ,color: blueColor),
                        ),
                      ),

                    ],
                  ),
                ),
                FutureBuilder<UserData>(
                  future: UsersApi.getCurrentUserData(),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return user != null?
                        GestureDetector(
                          onTap: () {
                            changeCoverPhoto(context);
                          },
                          child: Container(
                            height: 250,
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child:
                              coverImage != null?
                              Image.file(
                                File(coverImage!.path),
                                fit: BoxFit.cover,
                              )
                                  : CachedNetworkImage(imageUrl: "$host${user.coverImage.fileName}"),

                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            changeCoverPhoto(context);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: CachedNetworkImage(imageUrl: link2),
                            ),
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(child: Text('Some error occurred!'));
                        } else {
                          if (user != null) {
                            return GestureDetector(
                              onTap: () {
                                changeCoverPhoto(context);
                              },
                              child: Container(
                                height: 250,
                                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child:
                                  coverImage != null?
                                  Image.file(
                                      File(coverImage!.path),
                                      fit: BoxFit.cover,
                                  )
                                  : CachedNetworkImage(imageUrl: "$host${user.coverImage.fileName}"),

                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                                    onTap: () {
                                      changeCoverPhoto(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: CachedNetworkImage(imageUrl: link2),
                                      ),
                                    ),
                                  );
                          }
                        }
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0,0.0),
                  height: 10.0,
                  child:
                  Divider(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ảnh đại diện',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          changeAvatar(context);
                        },
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17 ,color: blueColor),
                        ),
                      ),

                    ],
                  ),
                ),
                FutureBuilder<UserData>(
                  future: UsersApi.getCurrentUserData(),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return user != null?
                        GestureDetector(
                          onTap: () {
                            changeAvatar(context);
                          },
                          child: Center(
                            child:
                            avatarImage != null?
                            Container(
                              width: 170,
                              height: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(85.0),
                                child: Image.file(
                                  File(avatarImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                                : ProfileAvatar(
                              imageUrl: "$host${user.avatar.fileName}",
                              maxSize: 85,
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            changeAvatar(context);
                          },
                          child: Center(
                            child: ProfileAvatar(
                              imageUrl: link,
                              maxSize: 85,
                            ),
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(child: Text('Some error occurred!'));
                        } else {
                          return
                            user != null?
                            GestureDetector(
                              onTap: () {
                                changeAvatar(context);
                              },
                              child: Center(
                                child: avatarImage != null?
                                Container(
                                  width: 170,
                                  height: 170,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(85.0),
                                    child: Image.file(
                                      File(avatarImage!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : ProfileAvatar(
                                  imageUrl: "$host${user.avatar.fileName}",
                                  maxSize: 85,
                                ),
                              ),
                            )
                                : GestureDetector(
                              onTap: () {
                                changeAvatar(context);
                              },
                              child: Center(
                                child: ProfileAvatar(
                                  imageUrl: link,
                                  maxSize: 85,
                                ),
                              ),
                            );
                        }
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0,0.0),
                  height: 10.0,
                  child:
                  Divider(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Chi tiết',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<UserData>(
                  future: UsersApi.getCurrentUserData(),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return user != null?
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Tên hiện tại: ${user.username}',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              child: rounded_input_field(
                                size: size*1.2,
                                text: "Tên",
                                inputController: Username,
                                validator: (value) {
                                  if (value!.isEmpty) return user.username;
                                  if (value.length <= 2) {
                                    return "Tên của bạn tối thiểu 2 kí tự";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 5.0),
                              child: Text(
                                'Số điện thoại hiện tại: ${user.phonenumber}',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              child: rounded_input_field(
                                size: size*1.2,
                                text: "Số điện thoại",
                                inputController: phone,
                                validator: (value) {
                                  if (value!.isEmpty) return user.phonenumber;
                                  if (value.length < 2 || !RegExp(r'^[+]*[(]{0,1}[0-9]+$').hasMatch(value)) {
                                    return "Số điện thoại tối thiểu 2 kí tự";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                            : Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Tên hiện tại: ',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              child: rounded_input_field(
                                size: size*1.2,
                                text: "Tên",
                                inputController: Username,
                                validator: (value) {
                                  if (value!.isEmpty) return '';
                                  if (value.length <= 2) {
                                    return "Tên của bạn tối thiểu 2 kí tự";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 5.0),
                              child: Text(
                                'Số điện thoại hiện tại: ',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              child: rounded_input_field(
                                size: size*1.2,
                                text: "Số điện thoại",
                                inputController: phone,
                                validator: (value) {
                                  if (value!.isEmpty) return '';
                                  if (value.length < 2 || !RegExp(r'^[+]*[(]{0,1}[0-9]+$').hasMatch(value)) {
                                    return "Số điện thoại tối thiểu 2 kí tự";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(child: Text('Some error occurred!'));
                        } else {
                          return user != null?
                          Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Tên hiện tại: ${user.username}',
                                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: rounded_input_field(
                                    size: size*1.2,
                                    text: "Tên",
                                    inputController: Username,
                                    validator: (value) {
                                      if (value!.isEmpty) return user.username;
                                      if (value.length <= 2) {
                                        return "Tên của bạn tối thiểu 2 kí tự";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 5.0),
                                  child: Text(
                                    'Số điện thoại hiện tại: ${user.phonenumber}',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: rounded_input_field(
                                    size: size*1.2,
                                    text: "Số điện thoại",
                                    inputController: phone,
                                    validator: (value) {
                                      if (value!.isEmpty) return user.phonenumber;
                                      if (value.length < 2 || !RegExp(r'^[+]*[(]{0,1}[0-9]+$').hasMatch(value)) {
                                        return "Số điện thoại tối thiểu 2 kí tự";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                      )
                            : Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Tên hiện tại: ',
                                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: rounded_input_field(
                                    size: size*1.2,
                                    text: "Tên",
                                    inputController: Username,
                                    validator: (value) {
                                      if (value!.isEmpty) return '';
                                      if (value.length <= 2) {
                                        return "Tên của bạn tối thiểu 2 kí tự";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 5.0),
                                  child: Text(
                                    'Số điện thoại hiện tại: ',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: rounded_input_field(
                                    size: size*1.2,
                                    text: "Số điện thoại",
                                    inputController: phone,
                                    validator: (value) {
                                      if (value!.isEmpty) return '';
                                      if (value.length < 2 || !RegExp(r'^[+]*[(]{0,1}[0-9]+$').hasMatch(value)) {
                                        return "Số điện thoại tối thiểu 2 kí tự";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            );
                        }
                    }
                  },
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: Text(
                    'Giới tính',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.fromLTRB(7.0, 0.0, 20.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(value: 0, groupValue: selectGender,
                        onChanged: (value) {
                          setState(() {
                            selectGender = value as int?;
                            gender = 'Nam';
                          });
                        },
                      ),
                      Text(
                        'Nam',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(width: 10,),
                      Radio(value: 1, groupValue: selectGender,
                        onChanged: (value) {
                          setState(() {
                            selectGender = value as int?;
                            gender = 'Nữ';
                          });
                        },),
                      Text(
                        'Nữ',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(width: 40,),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) async {gender = value;},
                          cursorColor: Colors.black87,
                          controller: textGender,
                          validator: (value) {
                            if (value!.isEmpty) return "Password cannot be empty";
                            if (value.length <= 8) {
                              return "Password length must have >=8";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 1.5)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,)),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: 'Khác',
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    print('save');
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      'Lưu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                )
              ],
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.123,
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
                              width: size.width * 0.7,
                              child: Center(
                                child: Text(
                                  'Chỉnh sửa trang cá nhân',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: GestureDetector(
            //       onTap: () async {
            //         setState(() {
            //           if (isOpenKeyboard) {
            //             FocusScope.of(context).unfocus();
            //             isListIcons = true;
            //           } else {
            //             isListIcons = isListIcons ? false : true;
            //           }
            //           ;
            //         });
            //       },
            //       child: isListIcons
            //           ? Container(
            //           width: size.width,
            //           height: 210,
            //           padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            //           alignment: Alignment.centerLeft,
            //           decoration: BoxDecoration(
            //             color: Colors.black,
            //             borderRadius:
            //             BorderRadius.vertical(top: Radius.circular(20)),
            //           ),
            //           child: Column(
            //             children: [
            //               Expanded(
            //                 child: GestureDetector(
            //                   onTap: () => _pickImage(),
            //                   child: Row(
            //                     children: [
            //                       Icon(Icons.collections,
            //                           size: 28,
            //                           color: Color.fromRGBO(
            //                               74, 198, 104, 1.0)),
            //                       SizedBox(width: 15),
            //                       Text('Chọn ảnh từ thư viện',
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 17,
            //                               fontWeight: FontWeight.w400)),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               Divider(
            //                 height: 10,
            //                 color: Colors.white,
            //                 thickness: 1.2,
            //               ),
            //               Expanded(
            //                 child: GestureDetector(
            //                   onTap: () => pickImage(ImageSource.camera),
            //                   child: Row(
            //                     children: [
            //                       Icon(Icons.photo_camera,
            //                           size: 28, color: blueColor),
            //                       SizedBox(width: 15),
            //                       Text('Chụp ảnh / Quay video',
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 17,
            //                               fontWeight: FontWeight.w400)),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               Divider(
            //                 height: 10,
            //                 color: Colors.white,
            //                 thickness: 1.2,
            //               ),
            //               Expanded(
            //                 child: GestureDetector(
            //                   onTap: () => _pickVideo(),
            //                   child: Row(
            //                     children: [
            //                       Icon(Icons.videocam,
            //                           size: 28, color: Colors.redAccent),
            //                       SizedBox(width: 15),
            //                       Text('Chọn video từ thư viện',
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 17,
            //                               fontWeight: FontWeight.w400)),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ))
            //           : Container(
            //           width: size.width,
            //           height: 60,
            //           padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //             color: Colors.black,
            //             borderRadius:
            //             BorderRadius.vertical(top: Radius.circular(20)),
            //           ),
            //           child: Row(
            //             children: [
            //               SizedBox(
            //                 width: 15,
            //               ),
            //               Expanded(
            //                 child: Text(
            //                   'Thêm vào bài viết của bạn',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 17,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Icon(Icons.collections,
            //                   size: 28,
            //                   color: Color.fromRGBO(74, 198, 104, 1.0)),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Icon(Icons.photo_camera,
            //                   size: 28, color: blueColor),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Icon(Icons.videocam,
            //                   size: 28, color: Colors.redAccent),
            //               SizedBox(
            //                 width: 15,
            //               ),
            //             ],
            //           )),
            //     ))
          ],
        ),

      ),
    );
  }
  changeCoverPhoto(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      context: context,
      builder: (BuildContext bcx) {
        Size size = MediaQuery.of(context).size;
        return  Container(
            margin: EdgeInsets.fromLTRB(
                0.0, 320, 0.0, 0),
            padding: EdgeInsets.fromLTRB(30.0, 8.0, 30.0,30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(17.0)),
            ),
            child: Column(children: [
              Container(
                width: 50,
                height: 5,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              GestureDetector(
                onTap: () => pickCoverImage(ImageSource.gallery),
                child: Row(
                  children: [
                    Icon(Icons.collections,
                        size: 28,
                        color: Color.fromRGBO(74, 198, 104, 1.0)),
                    SizedBox(width: 15),
                    Text('Chọn ảnh từ thư viện',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Divider(
                height: size.height * 0.03,
                color: Colors.black54,
                thickness: 1.2,
              ),
              GestureDetector(
                onTap: () => pickImage(ImageSource.camera),
                child: Row(
                  children: [
                    Icon(Icons.photo_camera,
                        size: 28, color: blueColor),
                    SizedBox(width: 15),
                    Text('Chụp ảnh',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ]));
      },
    );
  }

  changeAvatar(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      context: context,
      builder: (BuildContext bcx) {
        Size size = MediaQuery.of(context).size;
        return  Container(
            margin: EdgeInsets.fromLTRB(
                0.0, 320, 0.0, 0),
            padding: EdgeInsets.fromLTRB(30.0, 8.0, 30.0,30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(17.0)),
            ),
            child: Column(children: [
              Container(
                width: 50,
                height: 5,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              GestureDetector(
                onTap: () => pickAvatarImage(ImageSource.gallery),
                child: Row(
                  children: [
                    Icon(Icons.collections,
                        size: 28,
                        color: Color.fromRGBO(74, 198, 104, 1.0)),
                    SizedBox(width: 15),
                    Text('Chọn ảnh từ thư viện',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Divider(
                height: size.height * 0.03,
                color: Colors.black54,
                thickness: 1.2,
              ),
              GestureDetector(
                onTap: () => pickImage(ImageSource.camera),
                child: Row(
                  children: [
                    Icon(Icons.photo_camera,
                        size: 28, color: blueColor),
                    SizedBox(width: 15),
                    Text('Chụp ảnh',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ]));
      },
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

_createPost(String described, List<XFile> imageFileList, XFile? video, context) async {
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