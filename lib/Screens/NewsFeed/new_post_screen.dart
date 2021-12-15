import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/main_page.dart';

class CreatePost extends StatelessWidget {
  File? image;
  final User currentUser;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e){
      print("Failed to pick image: $e");
    }
  }

  CreatePost({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController status = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
        body:  Column(
          children: [
            Container(
              color: pinkColor,
              child: Column(
                children: [
                  Container(
                    height: size.height*0.06,
                    color: pinkColor,
                  ),
                  Container(
                    height: size.height*0.063,
                    color: pinkColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width*0.15,
                          child: IconButton(
                            icon: Icon(Icons.chevron_left, size: 32,),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MainPage(2))
                            ),
                          ),
                        ),
                        SizedBox(width: size.width*0.15,),
                        SizedBox(
                          width: size.width*0.4,
                          child: Center(
                            child: Text(
                              'Tạo bài viết',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width*0.3,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child:RaisedButton(
                                onPressed: () => AddNewPost(status, context),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                child: Text(
                                  'Đăng',
                                  style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                              )
                          ),
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
                    child:
                    ProfileAvatar(imageUrl: currentUser.imageUrl,),
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
                              Text(
                                currentUser.name,
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
                                      fontSize: 14,),
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
                            ]
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child:
              TextFormField(
                controller: status,
                cursorColor: Colors.black45,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: 'Bạn đang nghĩ gì?',
                    hintStyle: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w300),
                    border: InputBorder.none),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => pickImage(ImageSource.gallery),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20,),
                            Container(
                              width: 20,
                              height: 50,
                              child: Icon(
                                  Icons.collections,
                                  size: 30,
                                  color: Color.fromRGBO(74, 198, 104, 1.0)),
                            ),
                            SizedBox(width: 25,),
                            Text(
                              'Chọn ảnh từ thư viện',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Divider(height: 10, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
                      GestureDetector(
                        onTap: () => pickImage(ImageSource.camera),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 20,
                              height: 50,
                              child: Icon(Icons.photo_camera, size: 30,color: blueColor),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Chụp ảnh',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Divider(height: 10, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
                      GestureDetector(
                        onTap: () => pickImage(ImageSource.gallery),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 20,
                              height: 50,
                              child: Icon(Icons.videocam, size: 30,color: Colors.redAccent),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Chọn video từ thư viện',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ]
                )
            ),
          ],
        )
    );
  }
}


// CreatePost(User currentUser, context) {
//   File? image;
//   TextEditingController status = TextEditingController();
//   Size size = MediaQuery.of(context).size;
//
//   Future pickImage(ImageSource source) async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//
//       final imageTemporary = File(image.path);
//       this.image = imageTemporary;
//     } on PlatformException catch (e){
//       print("Failed to pick image: $e");
//     }
//   }
//
//   showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext bcx) {
//
//         return  Scaffold(
//             body:  Column(
//               children: [
//                 Container(
//                   color: pinkColor,
//                   child: Column(
//                     children: [
//                       Container(
//                           height: size.height*0.06,
//                           color: pinkColor,
//                       ),
//                       Container(
//                         height: size.height*0.063,
//                         color: pinkColor,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: size.width*0.15,
//                               child: IconButton(
//                                 icon: Icon(Icons.chevron_left, size: 32,),
//                                 onPressed: () => Navigator.pushNamed(context, '/mainpage'),
//                               ),
//                             ),
//                             SizedBox(width: size.width*0.15,),
//                             SizedBox(
//                               width: size.width*0.4,
//                               child: Center(
//                                 child: Text(
//                                   'Tạo bài viết',
//                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: size.width*0.3,
//                               child: Padding(
//                                   padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                                   child:RaisedButton(
//                                     onPressed: () => AddNewPost(status, context),
//                                     color: Colors.white,
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//                                     child: Text(
//                                       'Đăng',
//                                       style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
//                                     ),
//                                   )
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/mytimeline');
//                         },
//                         child:
//                         ProfileAvatar(imageUrl: currentUser.imageUrl,),
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context, '/mytimeline');
//                             },
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     currentUser.name,
//                                     style: TextStyle(
//                                         color: Colors.black87,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'Công khai',
//                                         style: TextStyle(
//                                           color: Colors.black87,
//                                           fontSize: 14,),
//                                         // fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Icon(
//                                         Icons.public,
//                                         color: Colors.grey[600],
//                                         size: 16,
//                                       )
//                                     ],
//                                   ),
//                                 ]
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child:
//                   TextFormField(
//                     controller: status,
//                     cursorColor: Colors.black45,
//                     maxLines: 10,
//                     decoration: InputDecoration(
//                         hintText: 'Bạn đang nghĩ gì?',
//                         hintStyle: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w300),
//                         border: InputBorder.none),
//                   ),
//                 ),
//                 Container(
//                     margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//                     padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                     decoration: BoxDecoration(
//                       color: Colors.black12,
//                       borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     ),
//                     child: Column(
//                         children: [
//                           GestureDetector(
//                             onTap: () => pickImage(),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Container(
//                                   width: 20,
//                                   height: 50,
//                                   child: Icon(Icons.collections, size: 30,color: Color.fromRGBO(
//                                       74, 198, 104, 1.0)),
//                                 ),
//                                 SizedBox(
//                                   width: 25,
//                                 ),
//                                 Text(
//                                   'Chọn ảnh từ thư viện',
//                                   style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(height: 10, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
//                           GestureDetector(
//                             onTap: () => print("Chụp ảnh"),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Container(
//                                   width: 20,
//                                   height: 50,
//                                   child: Icon(Icons.photo_camera, size: 30,color: blueColor),
//                                 ),
//                                 SizedBox(
//                                   width: 25,
//                                 ),
//                                 Text(
//                                   'Chụp ảnh',
//                                   style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(height: 10, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
//                           GestureDetector(
//                             onTap: () => print("Video"),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Container(
//                                   width: 20,
//                                   height: 50,
//                                   child: Icon(Icons.videocam, size: 30,color: Colors.redAccent),
//                                 ),
//                                 SizedBox(
//                                   width: 25,
//                                 ),
//                                 Text(
//                                   'Chọn video từ thư viện',
//                                   style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ]
//                     )
//                 ),
//               ],
//             )
//         );
//       }
//   );
// }


AddNewPost(TextEditingController status,context) {
  print(status.text);
  status.text = '';
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MainPage(2))
  );
}