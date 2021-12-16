import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/NewsFeed/post_view.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/main_page.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expandable_text/expandable_text.dart';

class FriendRequest extends StatelessWidget {
  final Post post;
  final User user;
  final bool isPersonalPost;

  const FriendRequest({
    Key? key,
    required this.post,
    required this.user,
    required this.isPersonalPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _showProfile(post, context),
            child:
            post.imageUrl != null ?
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(imageUrl: post.imageUrl),
                )
            )
                : const SizedBox.shrink(),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                color: Colors.black26,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showProfile(post, context),
                      child:ProfileAvatar( imageUrl: isPersonalPost? user.imageUrl : post.user.imageUrl, hasBorder: true,),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () => _showProfile(post, context),
                              child: showName(color: Colors.white, size: 15, fontWeight: FontWeight.w600,)
                            // Text(
                            //   post.user.name,
                            //   style: const TextStyle(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text(
                                'Đã gửi lời mời kết bạn',
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
                      child: Icon(Icons.done, color: Color.fromRGBO(
                          98, 182, 52, 1.0), size: 30.0, ),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                      onPressed: () => print('accept'),
                    ),
                    SizedBox(width: 3.0),
                    FloatingActionButton(
                      mini: true,
                      child: Icon(Icons.close, color: Colors.red, size: 30.0),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                      onPressed: () => print('unaccept'),
                    ),
                  ],
                ),
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
