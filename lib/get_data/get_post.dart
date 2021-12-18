import 'dart:convert';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/post_model_2.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class PostsApi {
  static Future<List<PostData>> getPosts() async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      var response = await networkHandler.getWithAuth("/posts/list", token);
      final posts = postsFromJson(response.body);
      final List<PostData> post = posts.data;

      return post;
    }
    return [];
  }
}

class ShowPostInfo extends StatelessWidget {
  const ShowPostInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PostData>>(
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
                return buildPosts(posts!);
              }
          }
        },
      ),
    );
  }

  Widget buildPosts(List<PostData> posts) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return ListTile(
            title: Text(post.author.username),
            subtitle: Text(post.described),
          );
        },
      );
}
