import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_view.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/data/posts_data.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FriendsProfile extends StatefulWidget {
  final User user;
  FriendsProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _FriendsProfile createState() => _FriendsProfile(user: user);
}

class _FriendsProfile extends State<FriendsProfile> {
  final User user;

  _FriendsProfile({
    Key? key,
    required this.user,
  });

  @override
  Widget build(BuildContext cx) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body:
      FutureBuilder<List<PostData>>(
        future: PostsApi.getMyPosts(),
        builder: (context, snapshot) {
          final posts = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                    color: pinkColor,
                  ));
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                return
                  // buildPosts(posts!);
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Container(
                                    width: size.width,
                                    height: 200.0,
                                    child: GestureDetector(
                                      onTap: () => {},  //_openPost(post, context),
                                      child: CachedNetworkImage(imageUrl: 'https://scontent.fhan14-1.fna.fbcdn.net/v/t39.30808-6/s960x960/260082159_1310567392723464_5260172184812387673_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=e3f864&_nc_ohc=SUKdopftlokAX9d9jul&_nc_ht=scontent.fhan14-1.fna&oh=00_AT8FiAhqkd8GIfA8Iq2as5BXnkyaYsLSAACAdERvu_6V1A&oe=61C0BC9A'),

                                    ),
                                  ),
                                  Positioned(
                                    top: 150.0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                          onTap: () => print("avatar"),  //_openPost(post, context),
                                          child: ProfileAvatar(imageUrl: user.imageUrl, minSize: 62, maxSize: 65, hasBorder: true,)
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 240,
                                    left: size.width*0.55,
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(size.width*0.225)),
                                        ),
                                        child: Icon(Icons.photo_camera, color: Colors.white, size: 28,)
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              alignment: Alignment.bottomCenter,
                              height: 130.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10.0,),
                                  // Text(
                                  //   user.name,
                                  //   style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold
                                  //   )
                                  // ),
                                  showName(color: Colors.black,
                                      size: 20,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(width: 10.0,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(Icons.check_circle, color: Colors.blueAccent,),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            // Container(
                            //     child: Text(
                            //       'Signbox software', style: TextStyle(fontSize: 18.0),)
                            // ),
                            SizedBox(height: 10.0,),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                            Icons.person, size: 28, color: Colors.blueAccent),
                                        onPressed: () {
                                          print("collections");
                                        },
                                      ),
                                      Text('Bạn bè', style: TextStyle(
                                          color: Colors.blueAccent
                                      ),)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(MdiIcons.facebookMessenger, color: Colors.black),
                                        onPressed: () {
                                          print("collections");
                                        },
                                      ),
                                      Text('Nhắn tin', style: TextStyle(
                                          color: Colors.black
                                      ),)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.more_vert, color: Colors.black),
                                        onPressed: () {
                                          _showMoreOption(cx);
                                        },
                                      ),
                                      Text('Thêm', style: TextStyle(
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
                                    Text('Hà  Nội', style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600
                                    ),)
                                  ],),


                                  SizedBox(height: 10.0,),
                                  Row(children: <Widget>[
                                    Icon(Icons.location_on),
                                    SizedBox(width: 5.0,),
                                    Text('Đến từ', style: TextStyle(
                                        fontSize: 16.0
                                    ),),
                                    SizedBox(width: 5.0,),
                                    Text('Hà Nội', style: TextStyle(
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
                                    Text('100K người bạn', style: TextStyle(
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
                                        child: Text('Xem thêm vể '+ user.name),
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
                                              Image.network(postimgs[1].imageUrl),
                                            )
                                        ),
                                        Expanded(
                                            child: Card(
                                              child:
                                              Image.network(postimgs[3].imageUrl),
                                            )
                                        )
                                      ],),
                                      Row(children: <Widget>[
                                        Expanded(
                                            child: Card(
                                              child:
                                              Image.network(postimgs[2].imageUrl),
                                            )
                                        ),
                                        Expanded(
                                            child: Card(
                                              child:
                                              Image.network(postimgs[2].imageUrl),
                                            )
                                        ),
                                        Expanded(
                                            child: Card(
                                              child:
                                              Image.network(postimgs[2].imageUrl),
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
                            CreatePostContainer(currentUser: currentUser),
                          ],
                        ),
                      ),
                      posts!.length != 0?
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final PostData post = posts[posts.length-index-1];
                            return PostContainer(post: post, isPersonalPost: false,);
                          },
                          childCount: posts.length,
                        ),
                      )
                      : SliverToBoxAdapter(
                        child:
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            'Bạn và bạn bè chưa có bài viết nào',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
          }
        },
      ),
      // ListView(
      //   children: <Widget>[
      //     Column(
      //       children: <Widget>[
      //         Container(
      //           child: Stack(
      //             alignment: Alignment.bottomCenter,
      //             overflow: Overflow.visible,
      //             children: <Widget>[
      //               Container(
      //                 width: size.width,
      //                 height: 200.0,
      //                 child: GestureDetector(
      //                   onTap: () => {},  //_openPost(post, context),
      //                   child: CachedNetworkImage(imageUrl: 'https://scontent.fhan14-1.fna.fbcdn.net/v/t39.30808-6/s960x960/260082159_1310567392723464_5260172184812387673_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=e3f864&_nc_ohc=SUKdopftlokAX9d9jul&_nc_ht=scontent.fhan14-1.fna&oh=00_AT8FiAhqkd8GIfA8Iq2as5BXnkyaYsLSAACAdERvu_6V1A&oe=61C0BC9A'),
      //
      //                   ),
      //                 ),
      //               Positioned(
      //                 top: 150.0,
      //                 child: Container(
      //                   alignment: Alignment.center,
      //                   child: GestureDetector(
      //                     onTap: () => print("avatar"),  //_openPost(post, context),
      //                     child: ProfileAvatar(imageUrl: user.imageUrl, minSize: 62, maxSize: 65, hasBorder: true,)
      //                   ),
      //                 ),
      //               ),
      //               Positioned(
      //                 top: 240,
      //                 left: size.width*0.55,
      //                 child: Container(
      //                     padding: EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.all(Radius.circular(size.width*0.225)),
      //                     ),
      //                     child: Icon(Icons.photo_camera, color: Colors.white, size: 28,)
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //
      //         Container(
      //           alignment: Alignment.bottomCenter,
      //           height: 130.0,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[
      //               SizedBox(width: 10.0,),
      //               showName(color: Colors.black,
      //                   size: 20,
      //                   fontWeight: FontWeight.bold),
      //               SizedBox(width: 10.0,),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 5.0),
      //                 child: Icon(Icons.check_circle, color: Colors.blueAccent,),
      //               )
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 10.0,),
      //         // Container(
      //         //     child: Text(
      //         //       'Signbox software', style: TextStyle(fontSize: 18.0),)
      //         // ),
      //         SizedBox(height: 10.0,),
      //         Container(
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: <Widget>[
      //               Column(
      //                 children: <Widget>[
      //                   IconButton(
      //                     icon: Icon(
      //                         Icons.person, size: 28, color: Colors.blueAccent),
      //                     onPressed: () {
      //                       print("collections");
      //                     },
      //                   ),
      //                   Text('Bạn bè', style: TextStyle(
      //                       color: Colors.blueAccent
      //                   ),)
      //                 ],
      //               ),
      //               Column(
      //                 children: <Widget>[
      //                   IconButton(
      //                     icon: Icon(MdiIcons.facebookMessenger, color: Colors.black),
      //                     onPressed: () {
      //                       print("collections");
      //                     },
      //                   ),
      //                   Text('Nhắn tin', style: TextStyle(
      //                       color: Colors.black
      //                   ),)
      //                 ],
      //               ),
      //               Column(
      //                 children: <Widget>[
      //                   IconButton(
      //                     icon: Icon(Icons.more_vert, color: Colors.black),
      //                     onPressed: () {
      //                       _showMoreOption(cx);
      //                     },
      //                   ),
      //                   Text('Thêm', style: TextStyle(
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
      //                 Icon(Icons.location_on),
      //                 SizedBox(width: 5.0,),
      //                 Text('Đến từ', style: TextStyle(
      //                     fontSize: 16.0
      //                 ),),
      //                 SizedBox(width: 5.0,),
      //                 Text('Hà Nội', style: TextStyle(
      //                     fontSize: 16.0,
      //                     fontWeight: FontWeight.w600
      //                 ),)
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
      //                 Text('100K người bạn', style: TextStyle(
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
      //                     child: Text('Xem thêm vể '+ user.name),
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
      //                 height: 40,
      //                   alignment: Alignment.centerLeft,
      //                   child: Text('Ảnh', style: TextStyle(
      //                     fontSize: 28.0,
      //                     fontWeight: FontWeight.bold,
      //                   ),)),
      //
      //               Container(child:
      //               Column(
      //                 children: <Widget>[
      //                   Row(children: <Widget>[
      //                     Expanded(
      //                         child: Card(
      //                           child:
      //                           Image.network(posts[1].imageUrl),
      //                         )
      //                     ),
      //                     Expanded(
      //                         child: Card(
      //                           child:
      //                           Image.network(posts[3].imageUrl),
      //                         )
      //                     )
      //                   ],),
      //                   Row(children: <Widget>[
      //                     Expanded(
      //                         child: Card(
      //                           child:
      //                           Image.network(posts[2].imageUrl),
      //                         )
      //                     ),
      //                     Expanded(
      //                         child: Card(
      //                           child:
      //                           Image.network(posts[2].imageUrl),
      //                         )
      //                     ),
      //                     Expanded(
      //                         child: Card(
      //                           child:
      //                           Image.network(posts[2].imageUrl),
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
      //             ],
      //           ),
      //         ),
      //         // SliverList(
      //         //   delegate: SliverChildBuilderDelegate(
      //         //         (context, index) {
      //         //       final Post post = posts[index];
      //         //       final User user = currentUser;
      //         //       return PostContainer(post: post, user: user, isPersonalPost: false,);
      //         //     },
      //         //     childCount: posts.length,
      //         //   ),
      //         // ),
      //
      //       ],
      //     ),
      //   ],
      // ),
    );
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

_openPost(PostData post, BuildContext context) {
  print("open Post");
  Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Interval(0, 0.5));
          return FadeTransition(
              opacity: curvedAnimation,
              child: PostView(animation: animation, post: post)
          );
        },
      )
  );
}