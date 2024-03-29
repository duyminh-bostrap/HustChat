import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hust_chat/Screens/Friends/friends_profile.dart';
import 'package:hust_chat/Screens/Message/chat_detail.dart';
import 'package:hust_chat/Screens/Profile/edit_profile_screen.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hust_chat/Screens/Message/database_firebase.dart';

import '../../network_handler.dart';

String link = dotenv.env['link'] ?? "";
String link2 = dotenv.env['link2'] ?? "";
String host = dotenv.env['host'] ?? "";

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class FriendsList extends StatefulWidget {
  final UserData userData;
  final bool isRequest;

  const FriendsList({
    Key? key,
    required this.userData,
    required this.isRequest,
  }) : super(key: key);

  @override
  _FriendsList createState() =>
      _FriendsList(userData: userData, isRequest: isRequest);
}

class _FriendsList extends State<FriendsList> {
  final UserData userData;
  final bool isRequest;

  _FriendsList({
    Key? key,
    required this.userData,
    required this.isRequest,
  });

  var friendChatUid;

  Future getUserIdByUserPhoneNumber(String phone)async {
    CollectionReference user= FirebaseFirestore.instance.collection('users');
    await user.where('phone_nummber',isEqualTo: phone)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((element) {
          setState(() {
            friendChatUid = element["uid"];
          });
        });
      }
    }
    ).catchError((error){});

  }

  void callChatDetailScreen(BuildContext context, String name, String uid){
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => ChatDetail(
            friendName: name, friendUid: uid)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => showProfile(userData, context),
            child: userData.coverImage != null
                ? Container(
                height: 220,
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(imageUrl: "$host${userData.coverImage.fileName}", fit: BoxFit.fitWidth),
                  )
                )
                : const SizedBox.shrink(),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => showProfile(userData, context),
                  child: ProfileAvatar(
                    imageUrl: userData.avatar != null? "$host${userData.avatar.fileName}" : link,
                    hasBorder: true,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => showProfile(userData, context),
                        child:
                        // showName(color: Colors.white, size: 15, fontWeight: FontWeight.w600,)
                        Text(
                          userData.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Text(
                            userData.phonenumber,
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                isRequest
                    ? FloatingActionButton(
                  heroTag: '1',
                  mini: true,
                  child: Icon(
                    Icons.done,
                    color: Color.fromRGBO(78, 212, 63, 1.0),
                    size: 28.0,
                  ),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                  onPressed: () async {
                    String? token = await storage.read(key: "token");

                    if (token != null) {
                      Map<String, String> data = {
                        "user_id": userData.id,
                        "is_accept": "1"
                      };
                      var response = await networkHandler.postAuth(
                          "/friends/set-accept", data, token);
                      debugPrint(response.body);
                    };
                    setState(() {
                      Fluttertoast.showToast(msg: "Kết bạn thành công", fontSize: 18);
                    });
                  },
                )
                    : FloatingActionButton(
                    heroTag: '2',
                    mini: true,
                    child: Icon(
                      MdiIcons.facebookMessenger,
                      color: blueColor,
                      size: 26.0,
                    ),
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                    onPressed: () async {
                      print(userData.phonenumber);

                      // chuyen qua man hinh tin nhan voi so dien thoai
                      await getUserIdByUserPhoneNumber(userData.phonenumber);
                      callChatDetailScreen(
                          context, userData.username, friendChatUid);
                    }
                ),
                SizedBox(width: 3.0),
                isRequest
                    ? FloatingActionButton(
                  heroTag: '3',
                  mini: true,
                  child: Icon(Icons.close, color: Colors.red, size: 26.0),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                  onPressed: () async {
                    String? token = await storage.read(key: "token");

                    if (token != null) {
                      Map<String, String> data = {
                        "user_id": userData.id,
                        "is_accept": "2"
                      };
                      var response = await networkHandler.postAuth(
                          "/friends/set-accept", data, token);
                      debugPrint(response.body);
                      // friends.removeWhere((element) => element.id == friends.id);
                    }
                    ;
                  },
                )
                    : FloatingActionButton(
                  heroTag: '4',
                  mini: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Icon(Icons.person_remove,   // Icons.no_accounts,
                        color: pinkColor, size: 26.0),
                  ),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                  onPressed: ()  {
                    RemoveFriend();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future RemoveFriend() async {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 130,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black87,),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Container(
                width: size.width*0.6,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  'Bạn có chắc chắn muốn xoá bạn bè?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String? token = await storage.read(key: "token");

                      if (token != null) {
                        Map<String, String> data = {
                          "user_id": userData.id,
                        };
                        var response = await networkHandler.postAuth(
                            "/friends/set-remove", data, token);
                        debugPrint(response.body);
                      };
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width*0.3,
                      margin: EdgeInsets.fromLTRB(9, 5, 4, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        // border: Border.all(color: Colors.black87,),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Huỷ kết bạn',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width*0.3,
                      margin: EdgeInsets.fromLTRB(4, 5, 9, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87,),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Trở lại',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,

                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

showProfile(UserData user, BuildContext context) {
  print("profile");
  Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => FriendsProfile(userId: user.id, userName: user.username,))
  );
}

