import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/data/likes_share.dart';
import 'package:hust_chat/models/models.dart';
import 'comments.dart';
import 'current_user.dart';

List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Hi',
    timeAgo: '58m',
    imageUrl:
    'https://scontent.fhan2-1.fna.fbcdn.net/v/t39.30808-6/260082159_1310567392723464_5260172184812387673_n.jpg?_nc_cat=101&cb=c578a115-7e291d1f&ccb=1-5&_nc_sid=e3f864&_nc_ohc=vzJz3RTyoVsAX9UgerB&_nc_ht=scontent.fhan2-1.fna&oh=00_AT8zlXVx01P3siltRaZXIeFkfwu5PZrGTyAq4281OoHVjw&oe=61BC33A0',
    commentList: Comments.allComments,
    likeList: Likes.allLikes,
    shareList: Shares.allShares,
    isLiked: false,
  ),
  Post(
    user: onlineUsers[5],
    caption:
    'People make it complicated',
    timeAgo: '3hr',
    imageUrl: 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8',

    commentList: Comments.allComments,
    likeList: Likes.allLikes,
    shareList: Shares.allShares,
    isLiked: false,
  ),
  Post(
    user: onlineUsers[4],
    caption: 'This is a very good boi.',
    timeAgo: '8hr',
    imageUrl:
    'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',

    commentList: Comments.allComments,
    likeList: Likes.allLikes,
    shareList: Shares.allShares,
    isLiked: false,
  ),
  Post(
    user: onlineUsers[3],
    caption: 'Enjoy cái moment này đi 🏔',
    timeAgo: '15hr',
    imageUrl:
    'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',

    commentList: Comments.allComments,
    likeList: Likes.allLikes,
    shareList: Shares.allShares,
    isLiked: false,
  ),
  Post(
    user: onlineUsers[0],
    caption:
    'More placeholder text for the soul: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '1d',
    imageUrl:
    'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',

    commentList: Comments.allComments,
    likeList: Likes.allLikes,
    shareList: Shares.allShares,
    isLiked: false,
  ),
  Post(
    user: onlineUsers[9],
    caption: 'A classic.',
    timeAgo: '1d',
    imageUrl:
    'https://images.unsplash.com/reserve/OlxPGKgRUaX0E1hg3b3X_Dumbo.JPG?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',

    commentList: Comments.allComments,
    likeList: Likes.allLikes,
    shareList: Shares.allShares,
    isLiked: false,
  )
];
