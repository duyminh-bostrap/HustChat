import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hust_chat/Screens/Widget/hero_tag.dart';
import 'package:hust_chat/Screens/Widget/hero_widget.dart';
import 'package:hust_chat/models/models.dart';

class CommentsWidget extends StatefulWidget {
  final Comment comment;
  CommentsWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  _CommentsWidget createState() => _CommentsWidget(comment: comment);
}

class _CommentsWidget extends State<CommentsWidget> {
  final Comment comment;

  _CommentsWidget({
    Key? key,
    required this.comment,
  });

@override
Widget build(BuildContext context) =>
  Container(
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
              backgroundImage: NetworkImage(comment.urlImage),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                comment.username,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(Icons.favorite_border, size: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        ExpandableText(
          comment.description,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.0,
          ),
          expandText: 'Xem thêm',
          collapseText: 'Rút gọn',
          maxLines: 2,
          linkColor: Colors.black54,
        ),
        SizedBox(height: 3),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                comment.date,
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ),
            GestureDetector(
              onTap: () => print("reply"),
              child: Text(
                " Trả lời ",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
