import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/search_users.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/get_data/get_user_info.dart';
import 'package:hust_chat/models/models.dart';


class FriendSuggestContainer extends StatefulWidget {
  FriendSuggestContainer(
      {Key? key}) : super(key: key);

  @override
  _FriendSuggestContainer createState() => _FriendSuggestContainer();
}

class _FriendSuggestContainer extends State<FriendSuggestContainer>{
  bool isRequest = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body:FutureBuilder<List<UserData>>(
            future: UsersApi.getUsers(),
            builder: (context, snapshot) {
              final users = snapshot.data;
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
                          users!.length != 0?
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                final UserData userData = users[index];
                                return SearchUsers(userData: userData,);
                              },
                              childCount: users.length,
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
                                'Không có gợi ý nào cho bạn',
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

_showProfile(post, BuildContext context) {
}
