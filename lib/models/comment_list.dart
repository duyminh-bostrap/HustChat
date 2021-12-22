// To parse this JSON data, do
//
//     final commentList = commentListFromJson(jsonString);

import 'dart:convert';

CommentList commentListFromJson(String str) => CommentList.fromJson(json.decode(str));

String commentListToJson(CommentList data) => json.encode(data.toJson());

class CommentList {
    CommentList({
        required this.data,
    });

    List<CommentData> data;

    factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
        data: List<CommentData>.from(json["data"].map((x) => CommentData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CommentData {
    CommentData({
        required this.id,
        required this.user,
        required this.post,
        required this.content,
        required this.commentAnswered,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    User user;
    String post;
    String content;
    dynamic commentAnswered;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        post: json["post"],
        content: json["content"],
        commentAnswered: json["commentAnswered"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "post": post,
        "content": content,
        "commentAnswered": commentAnswered,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class User {
    User({
        required this.id,
        required this.phonenumber,
        required this.username,
    });

    String id;
    String phonenumber;
    String username;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        phonenumber: json["phonenumber"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phonenumber": phonenumber,
        "username": username,
    };
}
