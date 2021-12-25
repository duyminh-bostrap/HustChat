import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/hero_tag.dart';
import 'package:hust_chat/Screens/Widget/hero_widget.dart';
import 'package:hust_chat/models/comment_list.dart';
import 'package:hust_chat/models/models.dart';

String link =dotenv.env['link']??"";


class CommentsWidget extends StatefulWidget {
  final CommentData comment;
  CommentsWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  _CommentsWidget createState() => _CommentsWidget(comment: comment);
}

class _CommentsWidget extends State<CommentsWidget> {
  final CommentData comment;
  bool isLiked = false;

  _CommentsWidget({
    Key? key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black12,
                backgroundImage: NetworkImage(link),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  comment.user.username,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLiked = isLiked ? false : true;
                    });
                  },
                  child: isLiked ? Icon(Icons.favorite, color: pinkColor ,size: 16)
                      : Icon(Icons.favorite_border, size: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            child: ExpandableText(
              comment.content,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
              ),
              expandText: 'Xem thêm',
              collapseText: 'Rút gọn',
              maxLines: 2,
              linkColor: Colors.black54,
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              comment.createdAt.toString(),
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
