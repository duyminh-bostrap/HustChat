import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/NewsFeed/create_post_container.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/post_model_2.dart';
import 'package:hust_chat/models/user_model.dart';


class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder<List<PostData>>(
        future: PostsApi.getPosts(),
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
