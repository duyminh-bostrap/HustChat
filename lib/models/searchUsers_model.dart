// To parse this JSON data, do
//
//     final searchUser = searchUserFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SearchUser searchUserFromJson(String str) =>
    SearchUser.fromJson(json.decode(str));

UserData UserFromJson(String str) =>
    UserData.fromJson(json.decode(str));

String searchUserToJson(SearchUser data) => json.encode(data.toJson());

class SearchUser {
  SearchUser({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<UserData> data;

  factory SearchUser.fromJson(Map<String, dynamic> json) => SearchUser(
        code: json["code"],
        message: json["message"],
        data:
            List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserData {
  UserData({
    required this.gender,
    required this.blockedInbox,
    required this.blockedDiary,
    required this.id,
    required this.phonenumber,
    required this.password,
    required this.username,
    required this.avatar,
    required this.coverImage,
  });

  String gender;
  List<dynamic> blockedInbox;
  List<dynamic> blockedDiary;
  String id;
  String phonenumber;
  String password;
  String username;
  Avatar avatar;
  CoverIMG coverImage;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        gender: json["gender"],
        blockedInbox: List<dynamic>.from(json["blocked_inbox"].map((x) => x)),
        blockedDiary: List<dynamic>.from(json["blocked_diary"].map((x) => x)),
        id: json["_id"],
        phonenumber: json["phonenumber"],
        password: json["password"],
        username: json["username"],
        avatar: Avatar.fromJson(json["avatar"]),
        coverImage: CoverIMG.fromJson(json["cover_image"]),
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "blocked_inbox": List<dynamic>.from(blockedInbox.map((x) => x)),
        "blocked_diary": List<dynamic>.from(blockedDiary.map((x) => x)),
        "_id": id,
        "phonenumber": phonenumber,
        "password": password,
        "username": username,
        "avatar": avatar.toJson(),
        "cover_image": coverImage.toJson(),
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
      };
}

class Avatar {
  Avatar({
    required this.type,
    required this.id,
    required this.fileName,
  });

  String type;
  String id;
  String fileName;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        type: json["type"],
        id: json["_id"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "fileName": fileName,
      };
}

class CoverIMG {
  CoverIMG({
    required this.type,
    required this.id,
    required this.fileName,
  });

  String type;
  String id;
  String fileName;

  factory CoverIMG.fromJson(Map<String, dynamic> json) => CoverIMG(
        type: json["type"],
        id: json["_id"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "fileName": fileName,
      };
}
