import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/friends_request.dart';
import 'package:hust_chat/Screens/Friends/suggest_request.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/models.dart';


class FriendRequestContainer extends StatefulWidget {
  FriendRequestContainer(
      {Key? key}) : super(key: key);

  @override
  _FriendRequestContainer createState() => _FriendRequestContainer();
}

class _FriendRequestContainer extends State<FriendRequestContainer>{
  bool isSuggest = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
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
                        onTap: () async => setState(() => isSuggest = false),
                        child: Container(
                          width: (size.width-40)*0.5,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          decoration: BoxDecoration(
                            color: isSuggest? pinkColor: greenColor,
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
                      GestureDetector(
                        onTap: () async => setState(() => isSuggest = true),
                        child: Container(
                          width: (size.width-40)*0.5,
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:  !isSuggest? pinkColor : greenColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            'Gợi ý kết bạn',
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
          // posts.length != 0?
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final Post post = posts[index];
                final User user = currentUser;
                return isSuggest?
                     posts.length != 0?
                      SuggestRequest(post: post, user: user, isPersonalPost: false,)
                     :  Center(
                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text(
                             'Không có lời mời kết bạn nào',
                             style: TextStyle(
                               color: Colors.black87,
                               fontSize: 18,
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                         ))
                    :  FriendRequest(post: post, user: user, isPersonalPost: false,);
              },
              childCount: posts.length,
            ),
          // )
          // : SliverToBoxAdapter(
          //   child:
          //     Center(
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Text(
          //         'Không có lời mời kết bạn nào',
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //         ),
          //     ),
          //       )),
          )
        ],
      ),
    );
  }
}

_showProfile(post, BuildContext context) {
}
