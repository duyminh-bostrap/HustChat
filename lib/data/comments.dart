import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/models/comment.dart';

class Comments {
  static List<Comment> allComments = [
    Comment(
      date: '1 phút trước',
      user: onlineUsers[2],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    Comment(
      date: '1 giờ trước',
      user: onlineUsers[6],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    Comment(
      date: '5 giờ trước',
      user: onlineUsers[3],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    Comment(
      date: '1 ngày trước',
      user: onlineUsers[9],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
  ];
}
