// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
    Posts({
        required this.data,
    });

    List<PostData> data;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        data: List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}
List<PostData> postFromJson(String str) => List<PostData>.from(json.decode(str).map((x) => PostData.fromJson(x)));
class PostData {
    PostData({
        required this.images,
        required this.videos,
        required this.like,
        required this.countComments,
        required this.isLike,
        required this.id,
        required this.author,
        required this.described,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    List<dynamic> images;
    List<dynamic> videos;
    List<dynamic> like;
    int countComments;
    bool isLike;
    String id;
    Author author;
    String described;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        like: List<dynamic>.from(json["like"].map((x) => x)),
        countComments: json["countComments"],
        isLike: json["isLike"],
        id: json["_id"],
        author: Author.fromJson(json["author"]),
        described: json["described"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "like": List<dynamic>.from(like.map((x) => x)),
        "countComments": countComments,
        "isLike": isLike,
        "_id": id,
        "author": author.toJson(),
        "described": described,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Author {
    Author({
        required this.id,
        required this.phonenumber,
        required this.username,
        required this.avatar,
    });

    String id;
    String phonenumber;
    String username;
    Avatar avatar;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        phonenumber: json["phonenumber"],
        username: json["username"],
        avatar: Avatar.fromJson(json["avatar"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phonenumber": phonenumber,
        "username": username,
        "avatar": avatar.toJson(),
    };
}

class Avatar {
    Avatar({
        required this.id,
        required this.fileName,
    });

    String id;
    String fileName;

    factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        id: json["_id"],
        fileName: json["fileName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fileName": fileName,
    };
}
