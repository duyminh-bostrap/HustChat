import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hust_chat/Screens/Comment/comments_container.dart';
import 'package:hust_chat/Screens/Widget/hero_tag.dart';
import 'package:hust_chat/Screens/Widget/hero_widget.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expandable_text/expandable_text.dart';

class PostView extends StatefulWidget {
  final Post post;
  final User currentUser;
  final Animation animation;

  const PostView({
    required this.post,
    required this.currentUser,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  _PostView createState() => _PostView(post: post,currentUser: currentUser, animation: animation);
}
class _PostView extends State<PostView> {
  final Post post;
  final User currentUser;
  final Animation animation;

  _PostView({
    required this.post,
    required this.currentUser,
    required this.animation,
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isLiked = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pinkColor,
        leading:
          IconButton(
            icon: Icon(Icons.chevron_left, size: 35, color: Colors.black87,),
            onPressed: Navigator.of(context).pop,
          ),
        title: Row(
          children: [
            ProfileAvatar(imageUrl: post.user.imageUrl, minSize: 20, maxSize: 22,),
            SizedBox(width: 15,),
            showName(color: Colors.black87, size: 17, fontWeight: FontWeight.w500,),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, size: 28, color: Colors.black87,),
            onPressed: () => _showMore(currentUser, post, context),
          ),
          SizedBox(width: 5,)
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: size.width*0.263,
                  color: Colors.transparent,
                ),
                Container(
                  // width: size.width,
                  // height: size.width*4.5/3,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  child: GestureDetector(
                    onTap: () => openImage(post, context),
                    child:
                    post.imageUrl != null ?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: HeroWidget(
                        tag: HeroTag.image(post.imageUrl),
                        child: CachedNetworkImage(imageUrl: post.imageUrl),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                  height: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("aaa");
                                },
                                child: isLiked ?
                                  Icon(
                                  Icons.favorite,
                                  color: pinkColor,
                                  size: 25.0,
                                ):Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey[600],
                                  size: 25.0,
                                ),
                            ),
                            const SizedBox(width: 10.0),
                            InkWell(
                                onTap: () => _whoComment(post, context),
                                child: Icon(
                                  MdiIcons.commentOutline,
                                  color: Colors.grey[600],
                                  size: 25.0,
                                )
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () => _whoShare(post, context),
                          child: Icon(
                            MdiIcons.send,
                            color: Colors.grey[600],
                            size: 25.0,
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      showName(color: Colors.black87, size: 16, fontWeight: FontWeight.w500,),
                      SizedBox(width: 10,),
                      Text(post.timeAgo, style: TextStyle(fontSize: 15),),
                    ]
                  )
                ),
                Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ExpandableText(
                          post.caption,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          expandText: 'Xem thêm',
                          collapseText: 'Rút gọn',
                          maxLines: 3,
                          linkColor: Colors.black54,
                        ),
                      ),
                    ),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(post.likeList.length.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                          SizedBox(width: 10,),
                          Text('lượt thích', style: TextStyle(fontSize: 15),),
                        ]
                    )
                ),


              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final Comment comment = post.commentList[index];
                return CommentsWidget(comment: comment);
              },
              childCount: post.commentList.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 40,),
          ),
        ]
      ),
    );
  }
}

_whoLike(Post post, BuildContext context) {
}

_whoComment(Post post, BuildContext context) {
}

_whoShare(Post post, BuildContext context) {
}

openImage(Post post, BuildContext context) {
  print("open image");
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
          margin: EdgeInsets.fromLTRB(10.0, size.height*0.365, 10.0, size.height*0.04),
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
          margin: EdgeInsets.fromLTRB(10.0, size.height*0.365, 10.0, size.height*0.04),
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