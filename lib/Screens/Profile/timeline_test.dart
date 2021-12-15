import 'package:flutter/material.dart';

TextEditingController _controller =
    TextEditingController(text: "Nhấn để đổi trạng thái");
bool _isEnable = false;

class MyTimeLineScreen extends StatelessWidget {
  const MyTimeLineScreen({Key? key}) : super(key: key);
  final double coverHeight = 200;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        buildTop(),
        buildIntro(),
      ])),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverImage()),
          Positioned(top: top, child: buildProfileImage()),
        ]);
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/IMG_8114.JPG',
          fit: BoxFit.cover,
        ),
        width: double.infinity,
        height: coverHeight,
      );

  Widget buildProfileImage() => CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: AssetImage('assets/IMG_9119.JPG'),
      child: GestureDetector(
        onTap: () {
          Navigator();
        },
      ));

  Widget buildIntro() => Column(
        children: [
          Text("Hoài Thu",
              style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              controller: _controller,
              enabled: _isEnable,
              maxLines: null,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Love(),
                Padding(padding: EdgeInsets.all(10)),
                Comment(),
              ],
            ),
          )
        ],
      );
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: Container(
          height: 80,
          color: Colors.pink[50],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.yellow[900],
                    ),
                    Text("  Bình luận nhiều (1)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text("Bài viết nhiều bình luận nhất")
            ],
          ),
        ));
  }
}

class Love extends StatelessWidget {
  const Love({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Container(
          height: 80,
          color: Colors.pink[50],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                    Text("  Yêu thích nhất (1)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text("Ảnh được thả tim nhiều nhất")
            ],
          ),
        ));
  }
}
