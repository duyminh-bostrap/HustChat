import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';

String link = 'https://scontent.fhan2-3.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&cb=c578a115-7e291d1f&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=pM4MixqT8AcAX-taJAh&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan2-3.fna&oh=d6547146bd71ff7d889c319978570933&oe=61BB95AF';

class FriendsList extends StatelessWidget {
  final UserData userData;
  final bool isRequest;

  const FriendsList({
    Key? key,
    required this.userData,
    required this.isRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => {}, //_showProfile(post, context),
            child:
            link != null ?
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(imageUrl: link),
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
                  onTap: () => {}, //_showProfile(post, context),
                  child:ProfileAvatar( imageUrl: link, hasBorder: true,),
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
                            'Có thể bạn biết người này',
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

                FloatingActionButton(
                  mini: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child:
                      isRequest?
                      Icon(Icons.done, color: Color.fromRGBO(78, 212, 63, 1.0), size: 28.0, )
                      : Icon(Icons.person_add_alt_1, color: Color.fromRGBO(78, 212, 63, 1.0), size: 26.0, ),
                  ),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                  onPressed: () => print('accept'),
                ),
                SizedBox(width: 3.0),
                FloatingActionButton(
                  mini: true,
                  child: Icon(Icons.close, color: Colors.red, size: 26.0),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                  onPressed: () => print('unaccept'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


_showProfile(Post post, BuildContext context) {
  print("profile");
  Navigator.pushNamed(context, '/mytimeline');
}
