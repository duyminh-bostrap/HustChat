import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/friends_request.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/models/models.dart';


class FriendRequestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final Post post = posts[index];
                final User user = currentUser;
                return FriendRequest(post: post, user: user, isPersonalPost: false,);
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
