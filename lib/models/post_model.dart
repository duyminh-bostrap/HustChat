import 'package:meta/meta.dart';
import 'package:hust_chat/models/models.dart';

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final List<Comment> commentList;
  final List<User> likeList;
  final List<User> shareList;
  final bool isLiked;

  Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.commentList,
    required this.likeList,
    required this.shareList,
    required this.isLiked,

  });
}
