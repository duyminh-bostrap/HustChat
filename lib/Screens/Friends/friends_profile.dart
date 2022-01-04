import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/get_data/get_user_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/network_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

String link =dotenv.env['link']??"";
String link2 =dotenv.env['link2']??"";

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class FriendsProfile extends StatefulWidget {
  final String userId;
  final String userName;
  FriendsProfile({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  _FriendsProfile createState() => _FriendsProfile(userId: userId, userName: userName);
}

class _FriendsProfile extends State<FriendsProfile> {
  final String userId;
  final String userName;

  _FriendsProfile({
    Key? key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext cx) {
    Size size = MediaQuery.of(context).size;
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: pinkColor,
          leading: IconButton(
            icon: Icon(Icons.chevron_left,size: 35,color: Colors.black,),
            onPressed: () { Navigator.pop(context); },
          ),
          title: Text(
            userName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        body:
          ListView(
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
                  future: UsersApi.getUserData(userId),
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
                                    child: user.coverImage != null
                                        ? CachedNetworkImage(imageUrl: "$host${user.coverImage.fileName}", fit: BoxFit.fitWidth,)
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                                Container(
                                  width: size.width,
                                  height: 310,
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {print('avatar');}, //_showProfile(post, context),
                                    child: ProfileAvatar(
                                      imageUrl: user.avatar != null? "$host${user.avatar.fileName}" : link,
                                      hasBorder: true,
                                      minSize: 75,
                                      maxSize: 80,
                                    ),
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
                                              userName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
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
                                                icon: Icon(MdiIcons.facebookMessenger, size: 28, color: blueColor),
                                                onPressed: () {
                                                  print('mes');
                                                },
                                              ),
                                              Text('Nhắn tin', style: TextStyle(color: blueColor),)
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.person_remove, color: Colors.black),
                                                onPressed: () {
                                                  RemoveFriend();
                                                },
                                              ),
                                              Text('Huỷ kết bạn', style: TextStyle(
                                                  color: Colors.black
                                              ),)
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.block, color: Colors.black),
                                                onPressed: () {
                                                  BlockFriend();
                                                },
                                              ),
                                              Text('Chặn', style: TextStyle(
                                                  color: Colors.black
                                              ),)
                                            ],
                                          )
                                        ],
                                      ),
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
                                            Icon(
                                                user.gender != ''?
                                                user.gender == 'nữ' || user.gender == 'female'?
                                                Icons.female
                                                    : Icons.male
                                                    : Icons.transgender
                                            ), //female
                                            SizedBox(width: 5.0,),
                                            Text('Giới tính', style: TextStyle(
                                                fontSize: 16.0
                                            ),),
                                            SizedBox(width: 5.0,),
                                            Text(
                                              user.gender ,
                                              style: TextStyle(
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
                                            Text('0 bạn chung', style: TextStyle(
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
                                                child: Text('Xem thêm vể ' + userName),
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
                  future: PostsApi.getFriendPosts(userId),
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
                              'Bạn bè chưa có bài viết nào',
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
        // CustomScrollView(
        //   slivers: [
        //     SliverToBoxAdapter(
        //       child: Stack(
        //         children: [
        //           Container(
        //             width: size.width,
        //             height: 230,
        //             child: GestureDetector(
        //               onTap: () {print('coverimage');}, //_showProfile(post, context),
        //               child: link2 != null
        //                   ? CachedNetworkImage(imageUrl: link2, fit: BoxFit.fitWidth,)
        //                   : const SizedBox.shrink(),
        //             ),
        //           ),
        //           Container(
        //             width: size.width,
        //             height: 310,
        //             alignment: Alignment.bottomCenter,
        //             child: GestureDetector(
        //               onTap: () {print('avatar');}, //_showProfile(post, context),
        //               child: ProfileAvatar(
        //                 imageUrl: link,
        //                 hasBorder: true,
        //                 minSize: 75,
        //                 maxSize: 80,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Column(
        //         children: [
        //           Container(
        //             alignment: Alignment.bottomCenter,
        //             height: 40.0,
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: <Widget>[
        //                 SizedBox(width: 10.0,),
        //                 Text(
        //                     user.username,
        //                     style: TextStyle(
        //                         color: Colors.black,
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.bold
        //                     )
        //                 ),
        //                 SizedBox(width: 10.0,),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 5.0),
        //                   child: Icon(Icons.check_circle, color: Colors.blueAccent,),
        //                 )
        //               ],
        //             ),
        //           ),
        //           SizedBox(height: 10.0,),
        //           SizedBox(height: 10.0,),
        //           Container(
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: <Widget>[
        //                 Column(
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Icon(MdiIcons.facebookMessenger, size: 28, color: blueColor),
        //                       onPressed: () {
        //                         print('mes');
        //                       },
        //                     ),
        //                     Text('Nhắn tin', style: TextStyle(color: blueColor),)
        //                   ],
        //                 ),
        //                 Column(
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Icon(Icons.person_remove, color: Colors.black),
        //                       onPressed: () {
        //                         RemoveFriend();
        //                       },
        //                     ),
        //                     Text('Huỷ kết bạn', style: TextStyle(
        //                         color: Colors.black
        //                     ),)
        //                   ],
        //                 ),
        //                 Column(
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Icon(Icons.block, color: Colors.black),
        //                       onPressed: () {
        //                         BlockFriend();
        //                       },
        //                     ),
        //                     Text('Chặn', style: TextStyle(
        //                         color: Colors.black
        //                     ),)
        //                   ],
        //                 )
        //               ],
        //             ),
        //           ),
        //           SizedBox(height: 20.0,),
        //           Container(
        //             padding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             child: Column(
        //               children: <Widget>[
        //                 Row(children: <Widget>[
        //                   Icon(Icons.home),
        //                   SizedBox(width: 5.0,),
        //                   Text('Sống tại', style: TextStyle(
        //                       fontSize: 16.0
        //                   ),),
        //                   SizedBox(width: 5.0,),
        //                   Text('Hà  Nội', style: TextStyle(
        //                       fontSize: 16.0,
        //                       fontWeight: FontWeight.w600
        //                   ),)
        //                 ],),
        //
        //
        //                 SizedBox(height: 10.0,),
        //                 Row(children: <Widget>[
        //                   Icon(
        //                       user.gender != ''?
        //                       user.gender == 'nữ' || user.gender == 'female'?
        //                       Icons.female
        //                           : Icons.male
        //                           : Icons.transgender
        //                   ), //female
        //                   SizedBox(width: 5.0,),
        //                   Text('Giới tính', style: TextStyle(
        //                       fontSize: 16.0
        //                   ),),
        //                   SizedBox(width: 5.0,),
        //                   Text(
        //                     user.gender != ''?
        //                     user.gender == 'nữ' || user.gender == 'female'?
        //                     "Nữ"
        //                         : "Nam"
        //                         : "Chưa rõ",
        //                     style: TextStyle(
        //                         fontSize: 16.0,
        //                         fontWeight: FontWeight.w600
        //                     ),)
        //                 ],),
        //
        //
        //                 SizedBox(height: 10.0,),
        //                 Row(children: <Widget>[
        //                   Icon(Icons.people),
        //                   SizedBox(width: 5.0,),
        //                   Text('Bạn bè', style: TextStyle(
        //                       fontSize: 16.0
        //                   ),),
        //                   SizedBox(width: 5.0,),
        //                   Text('100k người bạn', style: TextStyle(
        //                       fontSize: 16.0,
        //                       fontWeight: FontWeight.w600
        //                   ),)
        //                 ],),
        //                 SizedBox(height: 20.0,),
        //                 Row(children: <Widget>[
        //                   Expanded(
        //                     child: RaisedButton(
        //                       color: pinkColor,
        //                       onPressed: () {
        //                         print("collections");
        //                       },
        //                       child: Text('Xem thêm vể '),
        //                     ),
        //                   )
        //                 ],),
        //
        //                 Container(
        //                   height: 10.0,
        //                   child:
        //                   Divider(
        //                     color: Colors.grey,
        //                   ),
        //                 ),
        //
        //                 Container(
        //                     height: 40,
        //                     alignment: Alignment.centerLeft,
        //                     child: Row(
        //                       children: [
        //                         Icon(Icons.photo_library, color: greenColor, size: 25.0),
        //                         SizedBox(width: 10,),
        //                         Text('Ảnh', style: TextStyle(
        //                           fontSize: 20.0,
        //                           fontWeight: FontWeight.bold,
        //                         ),),
        //                       ],
        //                     )
        //                 ),
        //
        //                 Container(child:
        //                 Column(
        //                   children: <Widget>[
        //                     Row(children: <Widget>[
        //                       Expanded(
        //                           child: Card(
        //                             child:
        //                             Image.network(link2),
        //                           )
        //                       ),
        //                       Expanded(
        //                           child: Card(
        //                             child:
        //                             Image.network(link2),
        //                           )
        //                       )
        //                     ],),
        //                     Row(children: <Widget>[
        //                       Expanded(
        //                           child: Card(
        //                             child:
        //                             Image.network(link2),
        //                           )
        //                       ),
        //                       Expanded(
        //                           child: Card(
        //                             child:
        //                             Image.network(link2),
        //                           )
        //                       ),
        //                       Expanded(
        //                           child: Card(
        //                             child:
        //                             Image.network(link2),
        //                           )
        //                       )
        //                     ],)
        //                   ],
        //                 )
        //                   ,),
        //
        //                 Container(
        //                   height: 10.0,
        //                   child:
        //                   Divider(
        //                     color: Colors.grey,
        //                   ),
        //                 ),
        //
        //                 Container(
        //                     height: 40,
        //                     color: Colors.white,
        //                     alignment: Alignment.centerLeft,
        //                     child: Row(
        //                       children: [
        //                         Icon(Icons.style, color: blueColor, size: 25.0),
        //                         SizedBox(width: 10,),
        //                         Text('Bài viết', style: TextStyle(
        //                           fontSize: 20.0,
        //                           fontWeight: FontWeight.bold,
        //                         ),),
        //                       ],
        //                     )
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     FutureBuilder<List<PostData>>(
        //               future: PostsApi.getFriendPosts(user.id),
        //               builder: (context, snapshot) {
        //                 final posts = snapshot.data;
        //                 switch (snapshot.connectionState) {
        //                   case ConnectionState.waiting:
        //                     return SliverToBoxAdapter(
        //                       child: Container(height: 60,),
        //                     );
        //                   default:
        //                     if (snapshot.hasError) {
        //                       return
        //                         SliverToBoxAdapter(
        //                             child: Center(child: Text('Some error occurred!'))
        //                         );
        //                     } else {
        //                       return posts!.length != 0?
        //                       SliverList(
        //                         delegate: SliverChildBuilderDelegate(
        //                               (context, index) {
        //                             final PostData post = posts[posts.length-index-1];
        //                             return
        //
        //                               PostContainer(post: post, isPersonalPost: false,);
        //                           },
        //                           childCount: posts.length,
        //                         ),
        //                       )
        //                           : Container(
        //                         margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        //                         padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        //                         alignment: Alignment.center,
        //                         decoration: BoxDecoration(
        //                           color: Colors.black12,
        //                           borderRadius: BorderRadius.all(Radius.circular(15)),
        //                         ),
        //                         child: Text(
        //                           'Bạn bè chưa có bài viết nào',
        //                           style: TextStyle(
        //                             color: Colors.black87,
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.w400,
        //                           ),
        //                         ),
        //                       );
        //                     }
        //                 }
        //               },
        //       ),
        //   ],
        // ),



        // FutureBuilder<List<PostData>>(
        //   future: PostsApi.getFriendPosts(user.id),
        //   builder: (context, snapshot) {
        //     final posts = snapshot.data;
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //         return Center(
        //             child: CircularProgressIndicator(
        //               color: pinkColor,
        //             ));
        //       default:
        //         if (snapshot.hasError) {
        //           return Center(child: Text('Some error occurred!'));
        //         } else {
        //           return
        //             CustomScrollView(
        //               slivers: [
        //                 SliverToBoxAdapter(
        //                   child: Stack(
        //                     children: [
        //                       Container(
        //                         width: size.width,
        //                         height: 230,
        //                         child: GestureDetector(
        //                           onTap: () {print('coverimage');}, //_showProfile(post, context),
        //                           child: link2 != null
        //                               ? CachedNetworkImage(imageUrl: link2, fit: BoxFit.fitWidth,)
        //                               : const SizedBox.shrink(),
        //                         ),
        //                       ),
        //                       Container(
        //                         width: size.width,
        //                         height: 310,
        //                         alignment: Alignment.bottomCenter,
        //                         child: GestureDetector(
        //                           onTap: () {print('avatar');}, //_showProfile(post, context),
        //                           child: ProfileAvatar(
        //                             imageUrl: link,
        //                             hasBorder: true,
        //                             minSize: 75,
        //                             maxSize: 80,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 SliverToBoxAdapter(
        //                   child: Column(
        //                     children: [
        //                       Container(
        //                         alignment: Alignment.bottomCenter,
        //                         height: 40.0,
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: <Widget>[
        //                             SizedBox(width: 10.0,),
        //                             Text(
        //                               user.username,
        //                               style: TextStyle(
        //                                   color: Colors.black,
        //                                   fontSize: 20,
        //                                   fontWeight: FontWeight.bold
        //                               )
        //                             ),
        //                             SizedBox(width: 10.0,),
        //                             Padding(
        //                               padding: const EdgeInsets.only(top: 5.0),
        //                               child: Icon(Icons.check_circle, color: Colors.blueAccent,),
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(height: 10.0,),
        //                       SizedBox(height: 10.0,),
        //                       Container(
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                           children: <Widget>[
        //                             Column(
        //                               children: <Widget>[
        //                                 IconButton(
        //                                   icon: Icon(MdiIcons.facebookMessenger, size: 28, color: blueColor),
        //                                   onPressed: () {
        //                                     print('mes');
        //                                   },
        //                                 ),
        //                                 Text('Nhắn tin', style: TextStyle(color: blueColor),)
        //                               ],
        //                             ),
        //                             Column(
        //                               children: <Widget>[
        //                                 IconButton(
        //                                   icon: Icon(Icons.person_remove, color: Colors.black),
        //                                   onPressed: () {
        //                                     RemoveFriend();
        //                                   },
        //                                 ),
        //                                 Text('Huỷ kết bạn', style: TextStyle(
        //                                     color: Colors.black
        //                                 ),)
        //                               ],
        //                             ),
        //                             Column(
        //                               children: <Widget>[
        //                                 IconButton(
        //                                   icon: Icon(Icons.block, color: Colors.black),
        //                                   onPressed: () {
        //                                     BlockFriend();
        //                                   },
        //                                 ),
        //                                 Text('Chặn', style: TextStyle(
        //                                     color: Colors.black
        //                                 ),)
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(height: 20.0,),
        //                       Container(
        //                         padding: EdgeInsets.only(left: 10.0, right: 10.0),
        //                         child: Column(
        //                           children: <Widget>[
        //                             Row(children: <Widget>[
        //                               Icon(Icons.home),
        //                               SizedBox(width: 5.0,),
        //                               Text('Sống tại', style: TextStyle(
        //                                   fontSize: 16.0
        //                               ),),
        //                               SizedBox(width: 5.0,),
        //                               Text('Hà  Nội', style: TextStyle(
        //                                   fontSize: 16.0,
        //                                   fontWeight: FontWeight.w600
        //                               ),)
        //                             ],),
        //
        //
        //                             SizedBox(height: 10.0,),
        //                             Row(children: <Widget>[
        //                               Icon(
        //                                 user.gender != ''?
        //                                   user.gender == 'nữ' || user.gender == 'female'?
        //                                     Icons.female
        //                                     : Icons.male
        //                                 : Icons.transgender
        //                               ), //female
        //                               SizedBox(width: 5.0,),
        //                               Text('Giới tính', style: TextStyle(
        //                                   fontSize: 16.0
        //                               ),),
        //                               SizedBox(width: 5.0,),
        //                               Text(
        //                                 user.gender != ''?
        //                                   user.gender == 'nữ' || user.gender == 'female'?
        //                                     "Nữ"
        //                                     : "Nam"
        //                                 : "Chưa rõ",
        //                                 style: TextStyle(
        //                                   fontSize: 16.0,
        //                                   fontWeight: FontWeight.w600
        //                               ),)
        //                             ],),
        //
        //
        //                             SizedBox(height: 10.0,),
        //                             Row(children: <Widget>[
        //                               Icon(Icons.people),
        //                               SizedBox(width: 5.0,),
        //                               Text('Bạn bè', style: TextStyle(
        //                                   fontSize: 16.0
        //                               ),),
        //                               SizedBox(width: 5.0,),
        //                               Text('100k người bạn', style: TextStyle(
        //                                   fontSize: 16.0,
        //                                   fontWeight: FontWeight.w600
        //                               ),)
        //                             ],),
        //                             SizedBox(height: 20.0,),
        //                             Row(children: <Widget>[
        //                               Expanded(
        //                                 child: RaisedButton(
        //                                   color: pinkColor,
        //                                   onPressed: () {
        //                                     print("collections");
        //                                   },
        //                                   child: Text('Xem thêm vể '),
        //                                 ),
        //                               )
        //                             ],),
        //
        //                             Container(
        //                               height: 10.0,
        //                               child:
        //                               Divider(
        //                                 color: Colors.grey,
        //                               ),
        //                             ),
        //
        //                             Container(
        //                                 height: 40,
        //                                 alignment: Alignment.centerLeft,
        //                                 child: Row(
        //                                   children: [
        //                                     Icon(Icons.photo_library, color: greenColor, size: 25.0),
        //                                     SizedBox(width: 10,),
        //                                     Text('Ảnh', style: TextStyle(
        //                                       fontSize: 20.0,
        //                                       fontWeight: FontWeight.bold,
        //                                     ),),
        //                                   ],
        //                                 )
        //                             ),
        //
        //                             Container(child:
        //                             Column(
        //                               children: <Widget>[
        //                                 Row(children: <Widget>[
        //                                   Expanded(
        //                                       child: Card(
        //                                         child:
        //                                         Image.network(link2),
        //                                       )
        //                                   ),
        //                                   Expanded(
        //                                       child: Card(
        //                                         child:
        //                                         Image.network(link2),
        //                                       )
        //                                   )
        //                                 ],),
        //                                 Row(children: <Widget>[
        //                                   Expanded(
        //                                       child: Card(
        //                                         child:
        //                                         Image.network(link2),
        //                                       )
        //                                   ),
        //                                   Expanded(
        //                                       child: Card(
        //                                         child:
        //                                         Image.network(link2),
        //                                       )
        //                                   ),
        //                                   Expanded(
        //                                       child: Card(
        //                                         child:
        //                                         Image.network(link2),
        //                                       )
        //                                   )
        //                                 ],)
        //                               ],
        //                             )
        //                               ,),
        //
        //                             Container(
        //                               height: 10.0,
        //                               child:
        //                               Divider(
        //                                 color: Colors.grey,
        //                               ),
        //                             ),
        //
        //                             Container(
        //                                 height: 40,
        //                                 color: Colors.white,
        //                                 alignment: Alignment.centerLeft,
        //                                 child: Row(
        //                                   children: [
        //                                     Icon(Icons.style, color: blueColor, size: 25.0),
        //                                     SizedBox(width: 10,),
        //                                     Text('Bài viết', style: TextStyle(
        //                                       fontSize: 20.0,
        //                                       fontWeight: FontWeight.bold,
        //                                     ),),
        //                                   ],
        //                                 )
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 posts!.length != 0?
        //                 SliverList(
        //                   delegate: SliverChildBuilderDelegate(
        //                         (context, index) {
        //                       final PostData post = posts[posts.length-index-1];
        //                       return PostContainer(post: post, isPersonalPost: false,);
        //                     },
        //                     childCount: posts.length,
        //                   ),
        //                 )
        //                     : SliverToBoxAdapter(
        //                   child:
        //                   Container(
        //                     margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        //                     padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        //                     alignment: Alignment.center,
        //                     decoration: BoxDecoration(
        //                       color: Colors.black12,
        //                       borderRadius: BorderRadius.all(Radius.circular(15)),
        //                     ),
        //                     child: Text(
        //                       'Bạn bè chưa có bài viết nào',
        //                       style: TextStyle(
        //                         color: Colors.black87,
        //                         fontSize: 16,
        //                         fontWeight: FontWeight.w400,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 SliverToBoxAdapter(
        //                   child: SizedBox(height: 40.0,),
        //                 ),
        //               ],
        //             );
        //         }
        //     }
        //   },
        // ),
      );
  }
  Future RemoveFriend() async {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 130,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black87,),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Container(
                width: size.width*0.6,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  'Bạn có chắc chắn muốn xoá bạn bè?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String? token = await storage.read(key: "token");

                      if (token != null) {
                        Map<String, String> data = {
                          "user_id": userId,
                        };
                        var response = await networkHandler.postAuth(
                            "/friends/set-remove", data, token);
                        debugPrint(response.body);
                      };
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width*0.3,
                      margin: EdgeInsets.fromLTRB(9, 5, 4, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        // border: Border.all(color: Colors.black87,),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Huỷ kết bạn',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width*0.3,
                      margin: EdgeInsets.fromLTRB(4, 5, 9, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87,),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Trở lại',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future BlockFriend() async {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 130,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black87,),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Container(
                width: size.width*0.6,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  'Bạn có chắc chắn muốn chặn người dùng này?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String? token = await storage.read(key: "token");

                      if (token != null) {
                        Map<String, String> data = {
                          "user_id": userId,
                        };
                        var response = await networkHandler.postAuth(
                            "/friends/set-remove", data, token);
                        debugPrint(response.body);
                      };
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width*0.3,
                      margin: EdgeInsets.fromLTRB(9, 5, 4, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        // border: Border.all(color: Colors.black87,),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Chặn',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width*0.3,
                      margin: EdgeInsets.fromLTRB(4, 5, 9, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87,),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Trở lại',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
