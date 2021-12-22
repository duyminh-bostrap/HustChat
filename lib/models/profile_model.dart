
import 'package:hust_chat/models/post_model.dart';
import 'package:hust_chat/models/searchUsers_model.dart';

class Profile {
  final  Posts posts;
  final  UserData userData;

  Profile({
    required this.posts,
    required this.userData,
  });
}