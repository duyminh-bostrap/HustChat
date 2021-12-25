import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/network_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

String link =dotenv.env['link']??"";
NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class ProfileView extends StatefulWidget {
  final UserData user;
  ProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileView createState() => _ProfileView(user: user);
}

class _ProfileView extends State<ProfileView> {
  final UserData user;

  _ProfileView({
    Key? key,
    required this.user,
  });

  @override
  Widget build(BuildContext cx) {
    Size size = MediaQuery.of(context).size;
    return
      Scaffold(
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
                          child: Stack(
                            children: [
                              Container(
                                width: size.width,
                                height: 230,
                                child: GestureDetector(
                                  onTap: () {print('coverimage');}, //_showProfile(post, context),
                                  child: link != null
                                      ? CachedNetworkImage(imageUrl: link, fit: BoxFit.fitWidth,)
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
                                    imageUrl: link,
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
                                      onPressed: () {print('Đổi avatar');},
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                height: 40.0,
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
                                    Text(
                                      user.username,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                          icon: Icon(Icons.add_photo_alternate, size: 28, color: blueColor),
                                          onPressed: () {;
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
                                            print("collections");
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
                                      Icon(Icons.male), //female
                                      SizedBox(width: 5.0,),
                                      Text('Giới tính', style: TextStyle(
                                          fontSize: 16.0
                                      ),),
                                      SizedBox(width: 5.0,),
                                      Text('Nam', style: TextStyle(
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
                                          child: Text('Xem thêm vể '),
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
                                                Image.network(link),
                                              )
                                          ),
                                          Expanded(
                                              child: Card(
                                                child:
                                                Image.network(link),
                                              )
                                          )
                                        ],),
                                        Row(children: <Widget>[
                                          Expanded(
                                              child: Card(
                                                child:
                                                Image.network(link),
                                              )
                                          ),
                                          Expanded(
                                              child: Card(
                                                child:
                                                Image.network(link),
                                              )
                                          ),
                                          Expanded(
                                              child: Card(
                                                child:
                                                Image.network(link),
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
                              'Bạn chưa có bài viết nào',
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
      );
  }
}
