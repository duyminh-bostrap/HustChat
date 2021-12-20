import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/network_handler.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();

// class ProfileApi {
//   static Future<Profile> getProfile() async {
//     String? token = await storage.read(key: "token");
//     final Profile profile;
//     if (token != null) {
//       var response = await networkHandler.getWithAuth("/posts/list", token);
//       final posts = postsFromJson(response.body);
//       final List<PostData> post = posts.data;
//       profile.posts = post;
//       return profile;
//     }
//     return [];
//   }
// }