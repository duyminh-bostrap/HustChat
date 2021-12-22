import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

String link =
"http://wikicraze.com/wp-content/uploads/2018/08/alone-boy-5.jpg";
class FriendsList extends StatefulWidget {
  final UserData userData;
  final bool isRequest;

  const FriendsList({
    Key? key,
    required this.userData,
    required this.isRequest,
  }) : super(key: key);

  @override
  _FriendsList createState() =>_FriendsList(userData: userData, isRequest: isRequest);
}
class _FriendsList extends State<FriendsList> {
  final UserData userData;
  final bool isRequest;

  _FriendsList({
    Key? key,
    required this.userData,
    required this.isRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => {}, //_showProfile(post, context),
            child: link != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(imageUrl: link),
                    ))
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
                  onTap: () => {}, //_showProfile(post, context),
                  child: ProfileAvatar(
                    imageUrl: link,
                    hasBorder: true,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => {}, //_showProfile(post, context),
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
                          }
                          ;
                        },
                      )
                    : FloatingActionButton(
                        mini: true,
                        child: Icon(
                          MdiIcons.facebookMessenger,
                          color: blueColor,
                          size: 26.0,
                        ),
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                        onPressed: () async {
                          print("message");
                        },
                      ),
                SizedBox(width: 3.0),
                isRequest
                    ? FloatingActionButton(
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
                :  FloatingActionButton(
                  mini: true,
                  child: Icon(Icons.person_off, color: pinkColor, size: 26.0),
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
                          }
                          ;
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_showProfile(PostData post, BuildContext context) {
  print("profile");
  Navigator.pushNamed(context, '/mytimeline');
}
