import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/Screens/Block/block_list.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/new_post_screen.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/Profile/edit_profile_screen.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/Message/auth_firebase.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/get_data/get_user_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/network_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hust_chat/Screens/Message/auth_firebase.dart';


import '../../get_data/get_info.dart';

String link =dotenv.env['link']??"";
String link2 =dotenv.env['link2']??"";
String host = dotenv.env['host'] ?? "";

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {
  bool isProfile;
  ProfileScreen({
    Key? key,
    required this.isProfile,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(isProfile: isProfile);
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isProfile = false;
  AuthMethods authMethods = new AuthMethods();

  _ProfileScreenState({
    Key? key,
    required this.isProfile,
  });


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return isProfile?
      Scaffold(
        appBar: null,
        body: ListView(
            shrinkWrap: true,
            children: [
              // Stack(
              //   children: [
              //     Container(
              //       width: size.width,
              //       height: 230,
              //       child: GestureDetector(
              //         onTap: () {print('coverimage');}, //_showProfile(post, context),
              //         child: link2 != null
              //             ? CachedNetworkImage(imageUrl: link2, fit: BoxFit.fitWidth,)
              //             : const SizedBox.shrink(),
              //       ),
              //     ),
              //     Container(
              //       width: size.width,
              //       height: 310,
              //       alignment: Alignment.bottomCenter,
              //       child: GestureDetector(
              //         onTap: () {print('avatar');}, //_showProfile(post, context),
              //         child: ProfileAvatar(
              //           imageUrl: link,
              //           hasBorder: true,
              //           minSize: 75,
              //           maxSize: 80,
              //         ),
              //       ),
              //     ),
              //     Column(
              //       children: [
              //         SizedBox(height: 310.0,),
              //         Container(
              //           alignment: Alignment.bottomCenter,
              //           height: 40.0,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: <Widget>[
              //               SizedBox(width: 10.0,),
              //               Text(
              //                   userName,
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.bold
              //                   )
              //               ),
              //               SizedBox(width: 10.0,),
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 5.0),
              //                 child: Icon(Icons.check_circle, color: Colors.blueAccent,),
              //               )
              //             ],
              //           ),
              //         ),
              //         SizedBox(height: 10.0,),
              //         SizedBox(height: 10.0,),
              //         Container(
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: <Widget>[
              //               Column(
              //                 children: <Widget>[
              //                   IconButton(
              //                     icon: Icon(MdiIcons.facebookMessenger, size: 28, color: blueColor),
              //                     onPressed: () {
              //                       print('mes');
              //                     },
              //                   ),
              //                   Text('Nhắn tin', style: TextStyle(color: blueColor),)
              //                 ],
              //               ),
              //               Column(
              //                 children: <Widget>[
              //                   IconButton(
              //                     icon: Icon(Icons.person_remove, color: Colors.black),
              //                     onPressed: () {
              //                       RemoveFriend();
              //                     },
              //                   ),
              //                   Text('Huỷ kết bạn', style: TextStyle(
              //                       color: Colors.black
              //                   ),)
              //                 ],
              //               ),
              //               Column(
              //                 children: <Widget>[
              //                   IconButton(
              //                     icon: Icon(Icons.block, color: Colors.black),
              //                     onPressed: () {
              //                       BlockFriend();
              //                     },
              //                   ),
              //                   Text('Chặn', style: TextStyle(
              //                       color: Colors.black
              //                   ),)
              //                 ],
              //               )
              //             ],
              //           ),
              //         ),
              //         SizedBox(height: 20.0,),
              //         Container(
              //           padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //           child: Column(
              //             children: <Widget>[
              //               Row(children: <Widget>[
              //                 Icon(Icons.home),
              //                 SizedBox(width: 5.0,),
              //                 Text('Sống tại', style: TextStyle(
              //                     fontSize: 16.0
              //                 ),),
              //                 SizedBox(width: 5.0,),
              //                 Text('Hà  Nội', style: TextStyle(
              //                     fontSize: 16.0,
              //                     fontWeight: FontWeight.w600
              //                 ),)
              //               ],),
              //
              //
              //               SizedBox(height: 10.0,),
              //               Row(children: <Widget>[
              //                 Icon(
              //                     user.gender != ''?
              //                     user.gender == 'nữ' || user.gender == 'female'?
              //                     Icons.female
              //                         : Icons.male
              //                         : Icons.transgender
              //                 ), //female
              //                 SizedBox(width: 5.0,),
              //                 Text('Giới tính', style: TextStyle(
              //                     fontSize: 16.0
              //                 ),),
              //                 SizedBox(width: 5.0,),
              //                 Text(
              //                   user.gender != ''?
              //                   user.gender == 'nữ' || user.gender == 'female'?
              //                   "Nữ"
              //                       : "Nam"
              //                       : "Chưa rõ",
              //                   style: TextStyle(
              //                       fontSize: 16.0,
              //                       fontWeight: FontWeight.w600
              //                   ),)
              //               ],),
              //
              //
              //               SizedBox(height: 10.0,),
              //               Row(children: <Widget>[
              //                 Icon(Icons.people),
              //                 SizedBox(width: 5.0,),
              //                 Text('Bạn bè', style: TextStyle(
              //                     fontSize: 16.0
              //                 ),),
              //                 SizedBox(width: 5.0,),
              //                 Text('100k người bạn', style: TextStyle(
              //                     fontSize: 16.0,
              //                     fontWeight: FontWeight.w600
              //                 ),)
              //               ],),
              //               SizedBox(height: 20.0,),
              //               Row(children: <Widget>[
              //                 Expanded(
              //                   child: RaisedButton(
              //                     color: pinkColor,
              //                     onPressed: () {
              //                       print("collections");
              //                     },
              //                     child: Text('Xem thêm vể '),
              //                   ),
              //                 )
              //               ],),
              //
              //               Container(
              //                 height: 10.0,
              //                 child:
              //                 Divider(
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //
              //               Container(
              //                   height: 40,
              //                   alignment: Alignment.centerLeft,
              //                   child: Row(
              //                     children: [
              //                       Icon(Icons.photo_library, color: greenColor, size: 25.0),
              //                       SizedBox(width: 10,),
              //                       Text('Ảnh', style: TextStyle(
              //                         fontSize: 20.0,
              //                         fontWeight: FontWeight.bold,
              //                       ),),
              //                     ],
              //                   )
              //               ),
              //
              //               Container(child:
              //               Column(
              //                 children: <Widget>[
              //                   Row(children: <Widget>[
              //                     Expanded(
              //                         child: Card(
              //                           child:
              //                           Image.network(link2),
              //                         )
              //                     ),
              //                     Expanded(
              //                         child: Card(
              //                           child:
              //                           Image.network(link2),
              //                         )
              //                     )
              //                   ],),
              //                   Row(children: <Widget>[
              //                     Expanded(
              //                         child: Card(
              //                           child:
              //                           Image.network(link2),
              //                         )
              //                     ),
              //                     Expanded(
              //                         child: Card(
              //                           child:
              //                           Image.network(link2),
              //                         )
              //                     ),
              //                     Expanded(
              //                         child: Card(
              //                           child:
              //                           Image.network(link2),
              //                         )
              //                     )
              //                   ],)
              //                 ],
              //               )
              //                 ,),
              //
              //               Container(
              //                 height: 10.0,
              //                 child:
              //                 Divider(
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //
              //               Container(
              //                   height: 40,
              //                   color: Colors.white,
              //                   alignment: Alignment.centerLeft,
              //                   child: Row(
              //                     children: [
              //                       Icon(Icons.style, color: blueColor, size: 25.0),
              //                       SizedBox(width: 10,),
              //                       Text('Bài viết', style: TextStyle(
              //                         fontSize: 20.0,
              //                         fontWeight: FontWeight.bold,
              //                       ),),
              //                     ],
              //                   )
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              FutureBuilder<UserData>(
                future: UsersApi.getCurrentUserData(),
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(height: 60,);
                    default:
                      if (snapshot.hasError) {
                        return Center(child: Text('Some error occurred!'));
                      } else {
                        return
                          user != null?
                          Stack(
                            children: [
                              Container(
                                width: size.width,
                                height: 230,
                                child: GestureDetector(
                                    onTap: () {print('coverimage');}, //_showProfile(post, context),
                                    child:CachedNetworkImage(
                                      imageUrl: user != null? "$host${user.coverImage.fileName}" :link2,
                                      fit: BoxFit.fitWidth,
                                    )
                                ),
                              ),
                              Container(
                                width: size.width,
                                height: 310,
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {print('avatar');}, //_showProfile(post, context),
                                  child: ProfileAvatar(
                                    imageUrl: user != null? "$host${user.avatar.fileName}" : link,
                                    hasBorder: true,
                                    minSize: 75,
                                    maxSize: 80,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(225, 250, 0, 0), //top: 210, left: size.width*0.55
                                child: Container(
                                    width: 48,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(35, 35, 35, 0.9),
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.225)),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.photo_camera, color: Colors.white, size: 32,),
                                      onPressed: () => createPost(context),
                                    )
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 310.0,),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 40.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(width: 10.0,),
                                        Text(
                                            user!= null? user.username: '',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        // showName(color: Colors.black,
                                        //     size: 20,
                                        //     fontWeight: FontWeight.bold),
                                        SizedBox(width: 10.0,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Icon(Icons.check_circle, color: Colors.blueAccent,),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.add_photo_alternate, size: 28, color: blueColor),
                                              onPressed: () {
                                                createPost(context);
                                              },
                                            ),
                                            Text('Thêm ảnh', style: TextStyle(color: blueColor),)
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.edit, color: Colors.black),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder: (BuildContext context) => EditProfilePage()
                                                );
                                              },
                                            ),
                                            Text('Chỉnh sửa', style: TextStyle(
                                                color: Colors.black
                                            ),)
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.more_vert, color: Colors.black),
                                              onPressed: () {
                                                _showMoreOption(context);
                                              },
                                            ),
                                            Text('Thêm', style: TextStyle(
                                                color: Colors.black
                                            ),)
                                          ],
                                        )
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //   children: <Widget>[
                                    //     Column(
                                    //       children: <Widget>[
                                    //         IconButton(
                                    //           icon: Icon(Icons.person, size: 28, color: Colors.black),
                                    //           onPressed: () {
                                    //             print("collections");
                                    //           },
                                    //         ),
                                    //         Text('Bạn bè', style: TextStyle(color: Colors.black),)
                                    //       ],
                                    //     ),
                                    //     Column(
                                    //       children: <Widget>[
                                    //         IconButton(
                                    //           icon: Icon(MdiIcons.facebookMessenger, color: Colors.black),
                                    //           onPressed: () {
                                    //             print("collections");
                                    //           },
                                    //         ),
                                    //         Text('Nhắn tin', style: TextStyle(
                                    //             color: Colors.black
                                    //         ),)
                                    //       ],
                                    //     ),
                                    //     Column(
                                    //       children: <Widget>[
                                    //         IconButton(
                                    //           icon: Icon(Icons.more_vert, color: Colors.black),
                                    //           onPressed: () {
                                    //             _showMoreOption(context);
                                    //           },
                                    //         ),
                                    //         Text('Thêm', style: TextStyle(
                                    //             color: Colors.black
                                    //         ),)
                                    //       ],
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                  SizedBox(height: 20.0,),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(children: <Widget>[
                                          Icon(Icons.home),
                                          SizedBox(width: 5.0,),
                                          Text('Sống tại', style: TextStyle(
                                              fontSize: 16.0
                                          ),),
                                          SizedBox(width: 5.0,),
                                          Text('Chưa rõ', style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600
                                          ),)
                                        ],),


                                        SizedBox(height: 10.0,),
                                        Row(children: <Widget>[
                                          Icon(Icons.male), //female
                                          SizedBox(width: 5.0,),
                                          Text('Giới tính', style: TextStyle(
                                              fontSize: 16.0
                                          ),),
                                          SizedBox(width: 5.0,),
                                          Text(user.gender, style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600
                                          ),)
                                        ],),


                                        SizedBox(height: 10.0,),
                                        Row(children: <Widget>[
                                          Icon(Icons.people),
                                          SizedBox(width: 5.0,),
                                          Text('Bạn bè', style: TextStyle(
                                              fontSize: 16.0
                                          ),),
                                          SizedBox(width: 5.0,),
                                          Text('10 người bạn', style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600
                                          ),)
                                        ],),
                                        SizedBox(height: 20.0,),
                                        Row(children: <Widget>[
                                          Expanded(
                                            child: RaisedButton(
                                              color: pinkColor,
                                              onPressed: () {
                                                print("collections");
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('Xem thêm vể ' + user.username),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],),

                                        Container(
                                          height: 10.0,
                                          child:
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                        ),

                                        Container(
                                            height: 40,
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Icon(Icons.photo_library, color: greenColor, size: 25.0),
                                                SizedBox(width: 10,),
                                                Text('Ảnh', style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                              ],
                                            )
                                        ),

                                        Container(child:
                                        Column(
                                          children: <Widget>[
                                            Row(children: <Widget>[
                                              Expanded(
                                                  child: Card(
                                                    child:
                                                    Image.network(user.coverImage != null? "$host${user.coverImage.fileName}" : link2),
                                                  )
                                              ),
                                              Expanded(
                                                  child: Card(
                                                    child:
                                                    Image.network(user.coverImage != null? "$host${user.coverImage.fileName}" : link2),
                                                  )
                                              )
                                            ],),
                                            Row(children: <Widget>[
                                              Expanded(
                                                  child: Card(
                                                    child:
                                                    Image.network(user.coverImage != null? "$host${user.coverImage.fileName}" : link2),
                                                  )
                                              ),
                                              Expanded(
                                                  child: Card(
                                                    child:
                                                    Image.network(user.coverImage != null? "$host${user.coverImage.fileName}" : link2),
                                                  )
                                              ),
                                              Expanded(
                                                  child: Card(
                                                    child:
                                                    Image.network(user.coverImage != null? "$host${user.coverImage.fileName}" : link2),
                                                  )
                                              )
                                            ],)
                                          ],
                                        )
                                          ,),

                                        Container(
                                          height: 10.0,
                                          child:
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                        ),

                                        Container(
                                            height: 40,
                                            color: Colors.white,
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Icon(Icons.style, color: blueColor, size: 25.0),
                                                SizedBox(width: 10,),
                                                Text('Bài viết', style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  CreatePostContainer(),
                                ],
                              ),
                            ],
                          )
                              : Container(height: 10,);
                      }
                  }
                },
              ),
              FutureBuilder<List<PostData>>(
                future: PostsApi.getMyPosts(),
                builder: (context, snapshot) {
                  final posts = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(height: 60,);
                    default:
                      if (snapshot.hasError) {
                        return Center(child: Text('Some error occurred!'));
                      } else {
                        return posts!.length != 0?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[posts.length - 1 - index];
                              return PostContainer(post: post, isPersonalPost: false,);
                            })
                            : Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            'Bạn chưa có bài viết nào',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }
                  }
                },
              )
            ]
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton:
        IconButton(
          icon: Icon(Icons.chevron_left,size: 35,color: Colors.white60,),
          onPressed: () {setState(() { isProfile = false;});},
        ),
      )
      : SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<UserData>(
                future: UsersApi.getCurrentUserData(),
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(
                        margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async{
                                setState(() {
                                  isProfile = true;
                                });
                              },
                              child: Container(
                                // color: Colors.red,
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                // color: Colors.red,
                                child: ProfileAvatar(
                                  imageUrl: link,
                                  maxSize: 40,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    setState(() {
                                      isProfile = true;
                                    });
                                  },
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        showName(
                                          color: Colors.black87,
                                          size: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Xem trang cá nhân của bạn',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                          // fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(child: Text('Some error occurred!'));
                      } else {
                        return Container(
                          margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  setState(() {
                                    isProfile = true;
                                  });
                                },
                                child: Container(
                                  // color: Colors.red,
                                  height: 60,
                                  width: 60,
                                  alignment: Alignment.center,
                                  // color: Colors.red,
                                  child: ProfileAvatar(
                                    imageUrl: user!=null? "$host${user.avatar.fileName}" : link,
                                    maxSize: 40,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                      setState(() {
                                        isProfile = true;
                                      });
                                    },
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user!.username,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            )
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Xem trang cá nhân của bạn',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                            // fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ]),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                  }
                },
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  padding: EdgeInsets.fromLTRB(1.0, 10.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) => EditProfilePage()
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: size.width * 0.12,
                            height: size.height * 0.05,
                            child: Icon(Icons.edit,
                                size: 30, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Chỉnh sửa trang cá nhân',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black54,
                      thickness: 1.2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/changepass'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: size.width * 0.12,
                            height: size.height * 0.05,
                            child: Icon(MdiIcons.keyVariant,
                                size: 30, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Đổi mật khẩu',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black54,
                      thickness: 1.2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/block'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: size.width * 0.12,
                            height: size.height * 0.05,
                            // color: Colors.green,
                            child:
                                Icon(Icons.block, size: 30, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Người bị chặn',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                        height: 10,
                        color: Colors.black54,
                        thickness: 1.2,
                        indent: 20,
                        endIndent: 20),
                    GestureDetector(
                      onTap: () async {

                        // logout Firebase
                        authMethods.signOut();

                        Navigator.pushNamed(context, '/');
                        await storage.deleteAll();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: size.width * 0.12,
                            height: size.height * 0.05,
                            // color: Colors.green,
                            child:
                                Icon(Icons.logout, size: 30, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Đăng xuất',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ])),
              SizedBox(
                height: size.width * 0.50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Image.asset(
                      'assets/watermelon2.png',
                      width: size.width * 0.25,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.width * 0.1,
          ),
        ],
      ),
    ));
  }
}

_showMoreOption(cx) {

  showModalBottomSheet(
    context: cx,
    builder: (BuildContext bcx) {

      return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child:
            Row(children: <Widget>[
              Icon(Icons.feedback,
                color: Colors.black,),
              SizedBox(width: 10.0,),
              Text('Give feedback or report this profile',
                style: TextStyle(
                    fontSize: 18.0
                ),)
            ],),),


          Container(
            padding: EdgeInsets.all(10.0),
            child:
            Row(children: <Widget>[
              Icon(Icons.block,
                color: Colors.black,),
              SizedBox(width: 10.0,),
              Text('Block',
                style: TextStyle(
                    fontSize: 18.0
                ),)
            ],),),



          Container(
            padding: EdgeInsets.all(10.0),
            child:
            Row(children: <Widget>[
              Icon(Icons.link,
                color: Colors.black,),
              SizedBox(width: 10.0,),
              Text('Copy link to profile',
                style: TextStyle(
                    fontSize: 18.0
                ),)
            ],),),



          Container(
            padding: EdgeInsets.all(10.0),
            child:
            Row(children: <Widget>[
              Icon(Icons.search,
                color: Colors.black,),
              SizedBox(width: 10.0,),
              Text('Search Profile',
                style: TextStyle(
                    fontSize: 18.0
                ),)
            ],),)






        ],
      );

    },


  );


}