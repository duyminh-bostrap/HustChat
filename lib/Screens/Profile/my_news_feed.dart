import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget//color.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';

class MyNewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: showName(color: Colors.black87, size: 20),
          backgroundColor: pinkColor,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: currentUser),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final Post post = posts[index];
                  final User user = currentUser;
                  return PostContainer(post: post, user: user, isPersonalPost: true,);
                },
                childCount: posts.length,
              ),
            ),
          ],
        ),
    );
  }
}