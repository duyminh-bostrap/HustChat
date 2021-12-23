import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/friends_list.dart';
import 'package:hust_chat/Screens/Friends/friends_suggest.dart';
import 'package:hust_chat/Screens/Friends/friends_suggest_container.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/get_data/get_list_friend.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/models.dart';

String link ="http://wikicraze.com/wp-content/uploads/2018/08/alone-boy-5.jpg";

class FriendListContainer extends StatefulWidget {
  bool isRequest = false;
  bool isProfile = false;
  UserData userData = new UserData(gender: '', blockedInbox: [], blockedDiary: [], id: '', phonenumber: '', password: '', username: '', avatar: Avatar(type: '', fileName: '', id: ''), coverImage: CoverIMG(id: '', type: '', fileName: ''), createdAt: DateTime.now(), updatedAt: DateTime.now(), v: 0);
  FriendListContainer(
      {Key? key}) : super(key: key);

  @override
  _FriendListContainer createState() => _FriendListContainer();
}

class _FriendListContainer extends State<FriendListContainer>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: (widget.isProfile && widget.userData.id != '')?
          Scaffold(
            appBar: null,
            body:
            FutureBuilder<List<PostData>>(
              future: PostsApi.getFriendPosts(widget.userData.id),
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
                                        //   post.name,
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
            floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
            floatingActionButton:
            IconButton(
              icon: Icon(Icons.chevron_left,size: 35,color: Colors.black54,),
              onPressed: () {setState(() { widget.isProfile = false;});},
            ),
          )
            // danh sách kết bạn và gợi ý kết bạn
          : FutureBuilder<List<UserData>>(
            future: widget.isRequest? FriendsApi.getListFriendsRequested(): FriendsApi.getListFriends(),
            builder: (context, snapshot) {
              final friends = snapshot.data;
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
                      CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child:
                          Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  // padding: const EdgeInsets.fromLTRB(20, 15, 25, 15),
                                  decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async => setState(() => widget.isRequest = false),
                                        child: Container(
                                          width: (size.width-40)*0.5,
                                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:  !widget.isRequest? Color.fromRGBO(204, 248, 171, 1.0): pinkColor,
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: Text(
                                            'Danh sách bạn bè',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async => setState(() => widget.isRequest = true),
                                        child: Container(
                                          width: (size.width-40)*0.5,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                          decoration: BoxDecoration(
                                            color: widget.isRequest? Color.fromRGBO(204, 248, 171, 1.0): pinkColor,
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: Text(
                                            'Lời mời kết bạn',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                          ),
                        ),
                        friends!.length != 0?
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final UserData userData = friends[friends.length-index-1];
                              return widget.isRequest?
                                FriendsList(userData: userData, isRequest: true,)
                              : FriendsList(userData: userData, isRequest: false,);
                            },
                            childCount: friends.length,
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
                                widget.isRequest? 'Bạn hiện chưa lời mời kết bạn nào'
                                : 'Bạn hiện chưa có bạn bè nào',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ),
                        SliverToBoxAdapter(
                            child:
                            SizedBox(height: 20,)
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