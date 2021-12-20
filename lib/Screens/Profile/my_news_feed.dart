import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget//color.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/posts_data.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';

class MyNewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: showName(color: Colors.black87, size: 20, fontWeight: FontWeight.w600,),
          backgroundColor: pinkColor,
        ),
        body: FutureBuilder<List<PostData>>(
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
                          child: CreatePostContainer(currentUser: currentUser),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final PostData post = posts![index];
                              return PostContainer(post: post, isPersonalPost: false,);
                            },
                            childCount: posts!.length,
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