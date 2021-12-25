import 'dart:convert';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/comment_list.dart';
import 'package:hust_chat/models/post_model.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class PostsApi {
  static Future<List<PostData>> getPosts() async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      var response = await networkHandler.getWithAuth("/posts/list", token);
      final parsed =
          json.decode(response.body)["data"].cast<Map<String, dynamic>>();
      return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<PostData>> getMyPosts() async {
    String? token = await storage.read(key: "token");
    String? userID = await storage.read(key: "id");
    if (token != null && userID != null) {
      // print(userID);
      String url = "/posts/list?userId=" + userID;
      var response = await networkHandler.getWithAuth(url, token);
      // final posts = postsFromJson(response.body);
      final parsed =
          json.decode(response.body)["data"].cast<Map<String, dynamic>>();
      return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<PostData>> getFriendPosts(String friendID) async {
    String? token = await storage.read(key: "token");
    // String? userID = await storage.read(key: "id");
    if (token != null && friendID != null) {
      print(friendID);
      String url = "/posts/list?userId=" + friendID;
      var response = await networkHandler.getWithAuth(url, token);
      final parsed =
          json.decode(response.body)["data"].cast<Map<String, dynamic>>();
      return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
    }
    return [];
  }

  static void likePost(PostData post) async {
    String? token = await storage.read(key: "token");
    String postId = post.id;
    if (token != null) {
      String url = "/postLike/action/" + postId;
      var response = await networkHandler.postAuthWithoutBody(url, token);
      debugPrint(response.body);
    }
  }

  static void commentPost(
      PostData post, TextEditingController commentController) async {
    String? token = await storage.read(key: "token");
    String postId = post.id;
    if (token != null) {
      String url = "/postComment/create/" + postId;
      Map<String, String> data = {
        "content": commentController.text,
      };
      var response = await networkHandler.postAuth(url, data, token);
      debugPrint(response.body);
    }
  }

  static Future<List<CommentData>> getPostComments(PostData post) async {
    String? token = await storage.read(key: "token");
    String postId = post.id;
    if (token != null) {
      String url = "/postComment/list/" + postId;
      var response = await networkHandler.getWithAuth(url, token);
      final comments = commentListFromJson(response.body);
      final List<CommentData> comment = comments.data;

      return comment;
    }
    return [];
  }

  static Future<PostData> getAPost(String id) async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      // print(userID);
      String url = "/posts/show/" + id;
      var response = await networkHandler.getWithAuth(url, token);
      // final posts = postsFromJson(response.body);
      final parsed =
      json.decode(response.body)["data"].cast<Map<String, dynamic>>();
      return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
    }
    return new PostData(username: '', userID: '', content: '', id: '', images: [], like: [], createAt: '', updateAt: '', isLike: false, countComments: 0);
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
            title: Text(post.username),
            subtitle: Text(post.content),
          );
        },
      );
}
