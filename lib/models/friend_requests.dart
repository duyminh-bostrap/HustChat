// To parse required this JSON data, do
//
//     final friendRequests = friendRequestsFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

FriendRequests friendRequestsFromJson(String str) =>
    FriendRequests.fromJson(json.decode(str));

String friendRequestsToJson(FriendRequests data) => json.encode(data.toJson());

class FriendRequests {
  FriendRequests({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory FriendRequests.fromJson(Map<String, dynamic> json) => FriendRequests(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.friends,
  });

  List<UserData> friends;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        friends: List<UserData>.from(
            json["friends"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
      };
}
