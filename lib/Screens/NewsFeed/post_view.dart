import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hust_chat/Screens/Comment/comments_container.dart';
import 'package:hust_chat/Screens/Widget/hero_tag.dart';
import 'package:hust_chat/Screens/Widget/hero_widget.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/data/comments.dart';
import 'package:hust_chat/data/posts_data.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expandable_text/expandable_text.dart';

String link =
    "https://scontent.fhan14-1.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=uDg0Jhmowo8AX-EoNMg&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan14-1.fna&oh=00_AT8fIEil90ej5dlYMlzA-x03ESLqV3A6vlz1YNaAVz1WGQ&oe=61C1846F";

class PostView extends StatefulWidget {
  final PostData post;
  final Animation animation;

  const PostView({
    required this.post,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  _PostView createState() => _PostView(post: post, animation: animation);
}
class _PostView extends State<PostView> {
  final PostData post;
  final Animation animation;

  _PostView({
    required this.post,
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
            ProfileAvatar(imageUrl: post.images[0], minSize: 20, maxSize: 22,),
            SizedBox(width: 15,),
            Text(
              post.author.username,
              style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w500,),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, size: 28, color: Colors.black87,),
            onPressed: () => _showMore(post, context),
          ),
          SizedBox(width: 5,)
        ],
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Container(
                    // width: size.width,
                    // height: size.width*4.5/3,
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    child: GestureDetector(
                      onTap: () => openImage(post, context),
                      child:
                      // post.images[0] != null ?
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 0.0),
                      //   child: HeroWidget(
                      //     tag: HeroTag.image(post.images[0]),
                      //     child: CachedNetworkImage(imageUrl: post.images[0]),
                      //   ),
                      // )
                      //     : const SizedBox.shrink(),
                      link != null ?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: HeroWidget(
                          tag: HeroTag.image(link),
                          child: CachedNetworkImage(imageUrl: link),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15,),
                      GestureDetector(
                        onTap: () async {
                          print("tap");
                          setState(() {
                            isLiked = isLiked? false:true;
                          });
                        },
                        child: isLiked ?
                        Icon(
                          Icons.favorite,
                          color: pinkColor,
                          size: 25.0,
                        ): Icon(
                          Icons.favorite_border,
                          color: Colors.grey[600],
                          size: 25.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () => _whoComment(post, context),
                              child: Icon(
                                MdiIcons.commentOutline,
                                color: Colors.grey[600],
                                size: 25.0,
                              )
                          ),
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
                      SizedBox(width: 15,),
                    ],
                  ),
                  Container(
                      height: 30,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              post.author.username,
                              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500,),
                            ),
                            SizedBox(width: 10,),
                            Text(post.createdAt.toString(), style: TextStyle(fontSize: 15),),
                          ]
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ExpandableText(
                        post.described,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
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
                          children: [
                            Text(post.like.length.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                            SizedBox(width: 5,),
                            Text('lượt thích', style: TextStyle(fontSize: 15),),
                          ]
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              post.countComments == 0 ?
                              'Xem tất cả ${post.countComments} bình luận'
                              : 'Chưa có bình luận',
                              style: TextStyle(fontSize: 15),
                            ),
                          ]
                      )
                  ),
                  post.countComments == 0 ?
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: Comments.allComments.length,
                      itemBuilder: (context, index) {
                        final comment = Comments.allComments[index];
                        return CommentsWidget(comment: comment);
                      }
                  )
                  : SizedBox(height: 5,),
                  ],
                ),
            ]
          ),
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: BouncingScrollPhysics(),
          //     itemCount: Comments.allComments.length,
          //     itemBuilder: (context, index) {
          //       final comment = Comments.allComments[index];
          //       return CommentsWidget(comment: comment);
          //     }
          // ),

          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     height: 60,
          //     margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          //     decoration: BoxDecoration(
          //       color: Colors.black26,
          //       borderRadius: BorderRadius.all(Radius.circular(20)),
          //     ),
          //     child: Row(
          //       children: [
          //         // ProfileAvatar(imageUrl: link, maxSize: 25, hasBorder: true,),
          //         Container(
          //           height: 60,
          //           child: TextFormField(
          //             textAlign: TextAlign.left,
          //             maxLines: 2,
          //             decoration: InputDecoration(
          //               hintText: "Viết bình luận...",
          //               // contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5)
          //             ),
          //           ),
          //         )
          //       ]
          //     )
          //   )
          // ),
        ],
      ),
    );
  }
}

_whoLike(PostData post, BuildContext context) {
}

_whoComment(PostData post, BuildContext context) {
}

_whoShare(PostData post, BuildContext context) {
}

openImage(PostData post, BuildContext context) {
  print("open image");
}


_showMore(PostData post, context) async {

  String? userID = await storage.read(key: "id");

  showModalBottomSheet(
    isScrollControlled: false,
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
    context: context,
    builder: (BuildContext bcx) {
      Size size = MediaQuery.of(context).size;
      return post.author.id.toString() == userID.toString()?
      Container(
          margin: EdgeInsets.fromLTRB(10.0, size.height*0.5-170, 10.0, 90),
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
              children: [
                GestureDetector(
                  onTap: () => print(post.author.id.toString() + "___" + userID.toString()),
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
                  onTap: () async {
                    String? userID = await storage.read(key: "id");
                    print(post.author.id.toString() + "___" + userID.toString());
                  },
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