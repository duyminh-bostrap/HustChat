import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/Screens/Friends/friends_profile.dart';
import 'package:hust_chat/Screens/NewsFeed/post_view.dart';
import 'package:hust_chat/Screens/Profile/profile_screen.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/main_page.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';
import 'package:hust_chat/models/img_model.dart';
import 'package:hust_chat/models/post_model.dart';
import 'package:hust_chat/models/profile_model.dart';
import 'package:hust_chat/network_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

String link = dotenv.env['link'] ?? "";
String host = dotenv.env['host'] ?? "";

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

class PostContainer extends StatefulWidget {
  final PostData post;
  final bool isPersonalPost;
  int pageIndex = 0;

  PostContainer({
    Key? key,
    required this.post,
    required this.isPersonalPost,
  }) : super(key: key);

  @override
  _PostContainer createState() => _PostContainer(
      post: post, isPersonalPost: isPersonalPost, pageIndex: pageIndex);
}

class _PostContainer extends State<PostContainer> {
  final PostData post;
  final bool isPersonalPost;
  int pageIndex;

  _PostContainer({
    Key? key,
    required this.post,
    required this.isPersonalPost,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<ImageModel> img = post.images;
    final pageController = PageController(viewportFraction: 1);
    // post.images.add(link);

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
                PostHeader(
                  post: post,
                  isPersonalPost: isPersonalPost,
                ),
                const SizedBox(height: 5.0),
                GestureDetector(
                  onTap: () => _openPost(post, context, pageIndex),
                  child: ExpandableText(
                    post.content.runtimeType == String ? post.content : '',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400),
                    expandText: 'Xem thêm',
                    collapseText: 'Rút gọn',
                    maxLines: 3,
                    linkColor: Colors.black54,
                  ),
                  // ShowPostInfo()
                ),
                img.isNotEmpty
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6.0),
              ],
            ),
          ),
          Container(
            height: img.length>0? 300: 0,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: PageView.builder(
              controller: pageController,
              itemCount: img.length,
              itemBuilder: (context, index) {
                final image = img[index];
                return GestureDetector(
                  onTap: () => _openPost(post, context, pageIndex),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: image != ''
                        ? CachedNetworkImage(
                            imageUrl: "$host${image.name}",
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 300,
                          ),
                  ),
                );
              },
              onPageChanged: (index) => setState(() {
                pageIndex = index;
                print(index);
              }),
            ),
          ),
          // GestureDetector(
          //   onTap: () => _openPost(post, context),
          //   child: img.isNotEmpty
          //       ? GridView.count(
          //           physics: NeverScrollableScrollPhysics(),
          //           shrinkWrap: true,
          //           crossAxisCount: 1,
          //           children: img
          //               .map((e) => Image.network(
          //                   "http://localhost:8000/files/${e.name}"))
          //               .toList(),
          //         )
          //       : Container(height: 10,),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: PostStats(post: post, pageIndex: pageIndex),
          ),
        ],
      ),
    );
  }
}

class PostHeader extends StatefulWidget {
  final PostData post;
  final bool isPersonalPost;

  // bool _liked;

  const PostHeader({
    Key? key,
    required this.post,
    required this.isPersonalPost,
  }) : super(key: key);

  @override
  _PostHeader createState() => _PostHeader(post: post);
}

class _PostHeader extends State<PostHeader> {
  final PostData post;

  _PostHeader({
    Key? key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showProfile(post, context),
          child: ProfileAvatar(imageUrl: link),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _showProfile(post, context),
                child: Text(
                  post.username,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    '${post.createAt} • ',
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
          onPressed: () async {
            String? userID = await storage.read(key: "id");
            print(post.userID.toString());
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
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () => print(post.userID.toString()),
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
                        margin: EdgeInsets.fromLTRB(10.0, size.height * 0.255,
                            10.0, size.height * 0.145),
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () async {
                              String? userID = await storage.read(key: "id");
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
      ],
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

class PostStats extends StatefulWidget {
  final PostData post;
  final int pageIndex;

  PostStats({
    Key? key,
    required this.post,
    required this.pageIndex,
  }) : super(key: key);
  @override
  _PostStatsState createState() =>
      _PostStatsState(post: post, pageIndex: pageIndex);
}

class _PostStatsState extends State<PostStats> {
  final PostData post;
  final int pageIndex;

  _PostStatsState({
    Key? key,
    required this.post,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PostData>(
      future: PostsApi.getAPost(post.id),
      builder: (context, snapshot) {
        final onlyPost = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return onlyPost != null
                ? Column(
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
                            SizedBox(width: 4.0),
                            GestureDetector(
                              onTap: () =>
                                  _openPost(onlyPost, context, pageIndex),
                              child: Text(
                                '${onlyPost.like.length} lượt thích',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              child: onlyPost.images.length > 1
                                  ? Center(
                                      child: AnimatedSmoothIndicator(
                                        count: onlyPost.images.length,
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
                                  : Container(),
                            ),
                            SizedBox(width: 20.0),
                            GestureDetector(
                              onTap: () =>
                                  _openPost(onlyPost, context, pageIndex),
                              child: Text(
                                '${onlyPost.countComments} bình luận',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  onlyPost.isLike =
                                      onlyPost.isLike ? false : true;
                                  PostsApi.likePost(post);
                                });
                              },
                              child: Container(
                                height: 25.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    onlyPost.isLike
                                        ? Icon(
                                            Icons.favorite,
                                            color: pinkColor,
                                            size: 20.0,
                                          )
                                        : Icon(
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
                              onTap: () => _openPost(post, context, pageIndex),
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
                              onTap: () {},
                              child: Container(
                                height: 25.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark_border,
                                      color: Colors.grey[600],
                                      size: 25.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text('Lưu trữ'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
              return onlyPost != null
                  ? Column(
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
                              SizedBox(width: 4.0),
                              GestureDetector(
                                onTap: () =>
                                    _openPost(onlyPost, context, pageIndex),
                                child: Text(
                                  '${onlyPost.like.length} lượt thích',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: onlyPost.images.length > 1
                                    ? Center(
                                        child: AnimatedSmoothIndicator(
                                          count: onlyPost.images.length,
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
                                    : Container(),
                              ),
                              SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () =>
                                    _openPost(onlyPost, context, pageIndex),
                                child: Text(
                                  '${onlyPost.countComments} bình luận',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    onlyPost.isLike =
                                        onlyPost.isLike ? false : true;
                                    PostsApi.likePost(post);
                                  });
                                },
                                child: Container(
                                  height: 25.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      onlyPost.isLike
                                          ? Icon(
                                              Icons.favorite,
                                              color: pinkColor,
                                              size: 20.0,
                                            )
                                          : Icon(
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
                                onTap: () =>
                                    _openPost(post, context, pageIndex),
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
                                onTap: () {},
                                child: Container(
                                  height: 25.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.bookmark_border,
                                        color: Colors.grey[600],
                                        size: 25.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text('Lưu trữ'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      height: 10,
                    );
            }
        }
      },
    );
  }
}

_showProfile(PostData post, BuildContext context) async {
  String? userID = await storage.read(key: "id");
  print("profile");
  post.userID.toString() == userID.toString()
      ? Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => FriendsProfile(userId: post.userID, userName: post.username,) //ProfileView()),
        ))
      : Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => FriendsProfile(userId: post.userID, userName: post.username,)
          )
        );
}

_openPost(PostData post, BuildContext context, int pageIndex) {
  print(pageIndex.toString());
  Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) {
      final curvedAnimation =
          CurvedAnimation(parent: animation, curve: Interval(0, 0.5));
      return FadeTransition(
          opacity: curvedAnimation,
          child: PostView(animation: animation, post: post));
    },
  ));
}
