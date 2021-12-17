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

class PostContainer extends StatelessWidget {
  final Post post;
  final User user;
  final bool isPersonalPost;

  const PostContainer({
    Key? key,
    required this.post,
    required this.user,
    required this.isPersonalPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post, user: currentUser, isPersonalPost: isPersonalPost, ),
                const SizedBox(height: 5.0),
                GestureDetector(
                  onTap: () => _openPost(post, context),
                  child:
                  ExpandableText(
                    post.caption,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400
                    ),
                    expandText: 'Xem thêm',
                    collapseText: 'Rút gọn',
                    maxLines: 3,
                    linkColor: Colors.black54,
                  ),
                  // ShowPostInfo()
                ),
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6.0),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _openPost(post, context),
            child:
              post.imageUrl != null ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(imageUrl: post.imageUrl),
                )
              )
                  : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: PostStats(post: post),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  final User user;
  final bool isPersonalPost;
  // bool _liked;

  const _PostHeader({
    Key? key,
    required this.post,
    required this.user,
    required this.isPersonalPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showProfile(post, context),
          child:ProfileAvatar( imageUrl: isPersonalPost? user.imageUrl : post.user.imageUrl),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _showProfile(post, context),
                child: showName(color: Colors.black87, size: 16, fontWeight: FontWeight.w600,)
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
                    '${post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 15.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => _showMore(user, post, context),
        ),
      ],
    );
  }
}

class PostStats extends StatefulWidget {
  final Post post;

  PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);
  @override
  _PostStatsState createState() => _PostStatsState(post: post);
}
class _PostStatsState extends State<PostStats> {
  final Post post;

  _PostStatsState({
    Key? key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 81, 82, 1.0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  size: 10.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: GestureDetector(
                  onTap: () => _openPost(post, context),
                  child: Text(
                    '${post.likeList.length}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _openPost(post, context),
                child: Text(
                  '${post.commentList.length} bình luận',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                  onTap: () => _openPost(post, context),
                child: Text(
                  '${post.shareList.length} chia sẻ',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                )
              ),
            ],
          ),
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    print("like");
                    post.isLiked? false : true;
                    // if (!post.isLiked) {
                    //   post.likeList.remove(currentUser);
                    // } else {
                    //   post.likeList.add(currentUser);
                    // };
                  });
                },
                child: Container(
                  height: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      post.isLiked?
                      Icon(
                        Icons.favorite,
                        color: pinkColor,
                        size: 20.0,
                      ): Icon(
                        Icons.favorite_border,
                        color: Colors.grey[600],
                        size: 20.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Thích'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _openPost(post, context),
                child: Container(
                  height: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.commentOutline,
                        color: Colors.grey[600],
                        size: 20.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Bình luận'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _share(post),
                child: Container(
                  height: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.send,
                        color: Colors.grey[600],
                        size: 25.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Chia sẻ'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

_showProfile(Post post, BuildContext context) {
  print("profile");
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => MainPage(3)),
  );
}

_openPost(Post post, BuildContext context) {
  print("open Post");
  Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Interval(0, 0.5));
          return FadeTransition(
            opacity: curvedAnimation,
            child: PostView(animation: animation, post: post, currentUser: currentUser,)
          );
        },
      )
  );
}

_like(Post post, User currentUser) {
    print("like");
    post.isLiked? false : true;
    if (!post.isLiked) {
      post.likeList.remove(currentUser);
    } else {
      post.likeList.add(currentUser);
    }
}

_share(Post post) {
  print("share");
}

_showMore(User currentUser, Post post, context) {

    showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      context: context,
      builder: (BuildContext bcx) {
        Size size = MediaQuery.of(context).size;
        return post.user.name == 'Duy Minh'?
        Container(
            margin: EdgeInsets.fromLTRB(10.0, size.height*0.255, 10.0, size.height*0.145),
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Column(
                children: [
                  GestureDetector(
                    onTap: () => print("Chỉnh sửa bài viết"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 20,
                          height: 50,
                          child: Icon(Icons.edit, size: 30,color: Colors.black87),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          'Chỉnh sửa bài viết',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Divider(height: size.height*0.01, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
                  GestureDetector(
                    onTap: () => print("Xoá bài viết"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 20,
                          height: 50,
                          child: Icon(Icons.delete, size: 30,color: Colors.black87),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          'Xoá bài viết',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ]
            )
        )
        : Container(
          margin: EdgeInsets.fromLTRB(10.0, size.height*0.255, 10.0, size.height*0.145),
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
              children: [
                GestureDetector(
                  onTap: () => print("Báo cáo bài viết"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 20,
                        height: 50,
                        child: Icon(Icons.report_gmailerrorred, size: 30,color: Colors.black87),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Báo cáo bài viết',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Divider(height: size.height*0.01, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
                GestureDetector(
                  onTap: () => print("Chặn bài viết"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 20,
                        height: 50,
                        child: Icon(Icons.cancel_presentation, size: 30,color: Colors.black87),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Chặn bài viết',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ]
          )
      );
    },
  );
}