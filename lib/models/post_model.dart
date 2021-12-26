// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:hust_chat/models/searchUsers_model.dart';

import 'img_model.dart';

PostData postFromJson(String str) => PostData.fromJson(json.decode(str));

class PostData {
  final String username;
  final String userID;
  final String content;
  final String id;
  final List<ImageModel> images;
  // final List<dynamic> videos;
  final List like;
  final String createAt;
  final String updateAt;
  bool isLike;
  final int countComments;

  PostData(
      {required this.username,
      required this.userID,
      required this.content,
      required this.id,
      required this.images,
      // required this.videos,
      required this.like,
      required this.createAt,
      required this.updateAt,
      required this.isLike,
      required this.countComments});

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
      username: json["author"]["username"],
      userID: json["author"]['_id'],
      content: json["described"] == null ? "" : json["described"],
      id: json["_id"],
      images: List<ImageModel>.from(
          json["images"].map((x) => ImageModel.fromJson(x))),
      // videos: json["videos"],
      like: json["like"],
      createAt: json["createdAt"], //timeAgo(json["createdAt"]),
      updateAt: json["updatedAt"], //timeAgo(json["updatedAt"]),
      isLike: json["isLike"],
      countComments: json["countComments"]);
}

// String timeAgo(DateTime dateTime) {
//   final diff = DateTime.now().difference(dateTime);
//
//   if (diff.inDays >8) return DateFormat("dd-MM-yyyy").format(dateTime);
//   else if((diff.inDays / 7).floor() >= 1) return 'Tuần tước';
//   else if(diff.inDays >= 1) return '${diff.inDays} ngày trước';
//   else if(diff.inHours >= 1) return '${diff.inHours} giớ trước';
//   else if(diff.inMinutes >= 1) return '${diff.inMinutes} phút trước';
//   else if(diff.inSeconds >= 1) return '${diff.inSeconds} giây trước';
//   else return 'Vừa xong';
// }
