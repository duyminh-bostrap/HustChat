import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/friends_list.dart';
import 'package:hust_chat/Screens/Friends/friends_suggest.dart';
import 'package:hust_chat/Screens/Friends/friends_suggest_container.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/get_data/get_list_friend.dart';
import 'package:hust_chat/models/models.dart';


class FriendListContainer extends StatefulWidget {
  FriendListContainer(
      {Key? key}) : super(key: key);

  @override
  _FriendListContainer createState() => _FriendListContainer();
}

class _FriendListContainer extends State<FriendListContainer>{
  bool isRequest = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body:
            // danh sách kết bạn và gợi ý kết bạn
          FutureBuilder<List<UserData>>(
            future: isRequest? FriendsApi.getListFriendsRequested(): FriendsApi.getListFriends(),
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
                                        onTap: () async => setState(() => isRequest = false),
                                        child: Container(
                                          width: (size.width-40)*0.5,
                                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:  !isRequest? Color.fromRGBO(204, 248, 171, 1.0): pinkColor,
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
                                        onTap: () async => setState(() => isRequest = true),
                                        child: Container(
                                          width: (size.width-40)*0.5,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                          decoration: BoxDecoration(
                                            color: isRequest? Color.fromRGBO(204, 248, 171, 1.0): pinkColor,
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
                              final UserData userData = friends[index];
                              return isRequest?
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
                                isRequest? 'Bạn hiện chưa lời mời kết bạn nào'
                                : 'Bạn hiện chưa có bạn bè nào',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ),
                        // SliverToBoxAdapter(
                        //     child:
                        //     FriendSuggestContainer(),
                        // ),
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
            // gợi ý kết bạn
          // SliverToBoxAdapter(
          //   child:
          //   FutureBuilder<List<UserData>>(
          //     future: UsersApi.getUsers(),
          //     builder: (context, snapshot) {
          //       final users = snapshot.data;
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return Center(
          //               child: CircularProgressIndicator(
          //                 color: pinkColor,
          //               ));
          //         default:
          //           if (snapshot.hasError) {
          //             return Center(child: Text('Some error occurred!'));
          //           } else {
          //             return
          //               CustomScrollView(
          //                 slivers: [
          //                   users!.length != 0?
          //                   SliverList(
          //                     delegate: SliverChildBuilderDelegate(
          //                           (context, index) {
          //                         final UserData userData = users[index];
          //                         return FriendRequest(userData: userData,);
          //                       },
          //                       childCount: users.length,
          //                     ),
          //                   )
          //                   : SliverToBoxAdapter(
          //                     child:
          //                     Container(
          //                       margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          //                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          //                       alignment: Alignment.center,
          //                       decoration: BoxDecoration(
          //                         color: Colors.black12,
          //                         borderRadius: BorderRadius.all(Radius.circular(15)),
          //                       ),
          //                       child: Text(
          //                         'Không có gợi ý nào cho bạn',
          //                         style: TextStyle(
          //                           color: Colors.black87,
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w400,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               );
          //           }
          //       }
          //     },
          //   ),
          // )

    );
  }
}

_showProfile(post, BuildContext context) {
}
