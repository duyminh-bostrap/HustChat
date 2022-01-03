import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/Screens/Comment/comments_container.dart';
import 'package:hust_chat/Screens/NewsFeed/edit_post_screen.dart';
import 'package:hust_chat/Screens/Widget/hero_tag.dart';
import 'package:hust_chat/Screens/Widget/hero_widget.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/get_data/get_info.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/models/comment_list.dart';
import 'package:hust_chat/models/img_model.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/network_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

String link = dotenv.env['link'] ?? "";
String link2 = dotenv.env['link2'] ?? "";
String host = dotenv.env['host'] ?? "";
NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

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
  bool viewAll = false;
  TextEditingController writeComment = TextEditingController();
  int pageIndex = 0;
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  _PostView({
    required this.post,
    required this.animation,
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<ImageModel> img = post.images;
    final pageController = PageController(viewportFraction: 1);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: pinkColor,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 35,
              color: Colors.black87,
            ),
            onPressed: Navigator.of(context).pop,
          ),
          title: Row(
            children: [
              ProfileAvatar(
                imageUrl: link,
                minSize: 20,
                maxSize: 22,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                post.username,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_horiz,
                size: 28,
                color: Colors.black87,
              ),
              onPressed: () async {
                String? userID = await storage.read(key: "id");

                showModalBottomSheet(
                  isScrollControlled: false,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
                  context: context,
                  builder: (BuildContext bcx) {
                    Size size = MediaQuery.of(context).size;
                    return post.userID.toString() == userID.toString()
                        ? Container(
                            margin: EdgeInsets.fromLTRB(
                                10.0, size.height * 0.5 - 195, 10.0, 115),
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext bcx) => EditPostScreen(post: post)
                                  );
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
                                      child: Icon(Icons.edit,
                                          size: 30, color: Colors.black87),
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
                              Divider(
                                height: size.height * 0.01,
                                color: Colors.black54,
                                thickness: 1.2,
                                indent: 20,
                                endIndent: 20,
                              ),
                              GestureDetector(
                                onTap: () => RemovePost(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 50,
                                      child: Icon(Icons.delete,
                                          size: 30, color: Colors.black87),
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
                            ]))
                        : Container(
                            margin: EdgeInsets.fromLTRB(10.0,
                                size.height * 0.255, 10.0, size.height * 0.145),
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Column(children: [
                              GestureDetector(
                                onTap: () async {
                                  String? userID =
                                      await storage.read(key: "id");
                                  print(post.userID.toString() +
                                      "___" +
                                      userID.toString());
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
                                      child: Icon(Icons.report_gmailerrorred,
                                          size: 30, color: Colors.black87),
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
                              Divider(
                                height: size.height * 0.01,
                                color: Colors.black54,
                                thickness: 1.2,
                                indent: 20,
                                endIndent: 20,
                              ),
                              GestureDetector(
                                onTap: () => BlockPost(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 50,
                                      child: Icon(Icons.cancel_presentation,
                                          size: 30, color: Colors.black87),
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
                            ]));
                  },
                );
              },
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
        body: Stack(children: [
          ListView(
            shrinkWrap: true,
            children: [
              Column(children: [
                Container(
                  // width: size.width,
                  // height: size.width*4.5/3,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  child: link != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: HeroWidget(
                            tag: HeroTag.image(link),
                            child:
                            img.length != 0?
                            Container(
                              height: 300,
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: img.length,
                                itemBuilder: (context, index) {
                                  final image = img[index];
                                  return image != null
                                      ? CachedNetworkImage(
                                          imageUrl: "$host${image.name}",
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          height: 10,
                                        );
                                },
                                onPageChanged: (index) => setState(() {
                                  pageIndex = index;
                                  print(index);
                                }),
                              ),
                            )
                            : Container(height: 0,),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder<PostData>(
                  future: PostsApi.getAPost(post.id),
                  builder: (context, snapshot) {
                    final onlyPost = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return onlyPost != null
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      onlyPost.isLike
                                          ? Icon(
                                              Icons.favorite,
                                              color: pinkColor,
                                              size: 25.0,
                                            )
                                          : Icon(Icons.favorite_outline,
                                              color: Colors.grey[600],
                                              size: 25.0),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                            onTap: () =>
                                                {}, // _seeComment(post, context),
                                            child: Icon(
                                              MdiIcons.commentOutline,
                                              color: Colors.grey[600],
                                              size: 25.0,
                                            )),
                                      ),
                                      Expanded(
                                        child: img.length > 1
                                            ? Center(
                                                child: AnimatedSmoothIndicator(
                                                  count: img.length,
                                                  activeIndex: pageIndex,
                                                  effect: ExpandingDotsEffect(
                                                    dotHeight: 8,
                                                    dotWidth: 8,
                                                    expansionFactor: 2.3,
                                                    activeDotColor: pinkColor,
                                                    dotColor: Colors.black26,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 10,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Icon(
                                        Icons.bookmark_border,
                                        color: Colors.grey[600],
                                        size: 28.0,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                  Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.username,
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              post.createAt.toString(),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ])),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: ExpandableText(
                                        post.content,
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
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 0),
                                      child: Row(children: [
                                        Text(
                                          '${onlyPost.like.length}',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'lượt thích',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ])),
                                ],
                              )
                            : Container(
                                height: 10,
                              );
                      default:
                        if (snapshot.hasError) {
                          return Center(child: Text('Some error occurred!'));
                        } else {
                          return onlyPost != null
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              print("_______________________");
                                              setState(() {
                                                onlyPost.isLike =
                                                    onlyPost.isLike
                                                        ? false
                                                        : true;

                                                print(
                                                    "_______________________");
                                              });
                                              PostsApi.likePost(onlyPost);
                                            },
                                            child: onlyPost.isLike
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: pinkColor,
                                                    size: 25.0,
                                                  )
                                                : Icon(Icons.favorite_outline,
                                                    color: Colors.grey[600],
                                                    size: 25.0)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                              onTap: () =>
                                                  {}, // _seeComment(post, context),
                                              child: Icon(
                                                MdiIcons.commentOutline,
                                                color: Colors.grey[600],
                                                size: 25.0,
                                              )),
                                        ),
                                        Expanded(
                                            child: img.length > 1
                                                ? Center(
                                                    child:
                                                        AnimatedSmoothIndicator(
                                                      count: img.length,
                                                      activeIndex: pageIndex,
                                                      effect:
                                                          ExpandingDotsEffect(
                                                        dotHeight: 8,
                                                        dotWidth: 8,
                                                        expansionFactor: 2.3,
                                                        activeDotColor:
                                                            pinkColor,
                                                        dotColor:
                                                            Colors.black26,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 10,
                                                  )),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        InkWell(
                                            onTap: () =>
                                                _whoShare(post, context),
                                            child: Icon(
                                              Icons.bookmark_border,
                                              color: Colors.grey[600],
                                              size: 28.0,
                                            )),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                    Container(
                                        height: 30,
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                post.username,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                post.createAt.toString(),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ])),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: ExpandableText(
                                          post.content,
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
                                    GestureDetector(
                                      onTap: () => _whoLike(onlyPost, context),
                                      child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 0),
                                          child: Row(children: [
                                            Text(
                                              '${onlyPost.like.length}',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'lượt thích',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ])),
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 10,
                                );
                        }
                    }
                  },
                ),
                FutureBuilder<List<CommentData>>(
                  future: PostsApi.getPostComments(post),
                  builder: (context, snapshot) {
                    final comments = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return comments != null
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        viewAll = viewAll ? false : true;
                                      });
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 5, 15, 0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                comments.length != 0
                                                    ? viewAll
                                                        ? 'Rút gọn'
                                                        : 'Xem tất cả ${comments.length} bình luận'
                                                    : 'Chưa có bình luận',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                            ])),
                                  ),
                                  comments.length != 0
                                      ? viewAll
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: comments.length,
                                              itemBuilder: (context, index) {
                                                final comment = comments[
                                                    comments.length -
                                                        1 -
                                                        index];
                                                return CommentsWidget(
                                                    comment: comment);
                                              })
                                          : CommentsWidget(
                                              comment:
                                                  comments[comments.length - 1])
                                      : SizedBox(
                                          height: 5,
                                        ),
                                ],
                              )
                            : Container(
                                height: 10,
                              );
                      default:
                        if (snapshot.hasError) {
                          return Center(child: Text('Some error occurred!'));
                        } else {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    viewAll = viewAll ? false : true;
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            comments!.length != 0
                                                ? viewAll
                                                    ? 'Rút gọn'
                                                    : 'Xem tất cả ${comments.length} bình luận'
                                                : 'Chưa có bình luận',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ])),
                              ),
                              comments.length != 0
                                  ? viewAll
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: comments.length,
                                          itemBuilder: (context, index) {
                                            final comment = comments[
                                                comments.length - 1 - index];
                                            return CommentsWidget(
                                                comment: comment);
                                          })
                                      : CommentsWidget(
                                          comment:
                                              comments[comments.length - 1])
                                  : SizedBox(
                                      height: 5,
                                    ),
                            ],
                          );
                        }
                    }
                  },
                ),
                SizedBox(
                  height: 55,
                ),
              ]),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: size.width,
                  height: 55,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(27, 27, 27, 1.0),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        ProfileAvatar(imageUrl: link, maxSize: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: writeComment,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black87,
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: 'Viết bình luận...',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300),
                                border: InputBorder.none

                                // contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5)
                                ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(MdiIcons.send),
                          onPressed: () {
                            PostsApi.commentPost(post, writeComment);
                            Future.delayed(Duration(milliseconds: 1000), () {
                              writeComment.text = '';
                              FocusScope.of(context).unfocus();
                            });
                          },
                        ),
                      ],
                    ),
                  )))
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black87,
          child: Container(
            height: 0,
          ),
        ),
      ),
    );
  }

  Future RemovePost() async {
    Size size = MediaQuery.of(context).size;
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 130,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Container(
                width: size.width * 0.6,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  'Bạn có chắc chắn muốn xoá bài viết?',
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
                        String postID = post.id;
                        String url = "posts/delete/" + postID;
                        var response =
                            await networkHandler.getWithAuth(url, token);
                        Map output = json.decode(response.body);

                        if (response.statusCode < 300) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
                      margin: EdgeInsets.fromLTRB(10, 5, 4, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Xoá bài viết',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
                      margin: EdgeInsets.fromLTRB(4, 5, 10, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                        ),
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

  Future BlockPost() async {
    Size size = MediaQuery.of(context).size;
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 130,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Container(
                width: size.width * 0.6,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  'Bạn có chắc chắn muốn chặn bài viết?',
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
                    onTap: () async {},
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
                      margin: EdgeInsets.fromLTRB(10, 5, 4, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Chặn bài viết',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
                      margin: EdgeInsets.fromLTRB(4, 5, 10, 5),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                        ),
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

_whoLike(PostData post, BuildContext context) {
  print("${post.like.length} người thích bài viết");
}

_whoShare(PostData post, BuildContext context) {}
