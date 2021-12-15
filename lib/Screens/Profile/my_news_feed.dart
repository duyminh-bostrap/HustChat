import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget//color.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';

class MyNewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bài đăng của tôi"),
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
                  return PostContainer(post: post);
                },
                childCount: posts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}