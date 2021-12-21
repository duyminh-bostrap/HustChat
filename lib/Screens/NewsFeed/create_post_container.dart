import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/NewsFeed/new_post_screen.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/models/models.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 5.0),
              ProfileAvatar(imageUrl: currentUser.imageUrl),
              const SizedBox(width: 10.0),
              Expanded(
                child: GestureDetector(
                  onTap: () => createPost(currentUser, context),
                  child: Text(
                    'Hôm nay bạn thế nào?',
                    style: TextStyle(fontSize: 16, color: Colors.black54 ),
                  ),
                ),
              )
            ],
          ),
          // const Divider(height: 10.0, thickness: 0.5, color: Colors.white),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width*0.45,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 8, 10),
                    child: Container(
                      child: FloatingActionButton.extended(
                        icon: Icon(Icons.photo_library, color: Colors.black87, size: 25.0),
                        label: Text('Photo',style: TextStyle(color: Colors.black87, fontSize: 17.0)),
                        backgroundColor: Color.fromRGBO(211, 255, 176, 1.0),
                        extendedIconLabelSpacing: 20.0,
                        extendedPadding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
                        onPressed: () => createPost(currentUser, context),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width*0.45,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 0, 10),
                    child: Container(
                      child: FloatingActionButton.extended(
                        icon: Icon(Icons.videocam, color: Colors.redAccent, size: 30.0),
                        label: Text('Video', style: TextStyle(color: Colors.black87, fontSize: 17.0)),
                        backgroundColor: Color.fromRGBO(211, 255, 176, 1.0),
                        extendedIconLabelSpacing: 20.0,
                        extendedPadding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
                        onPressed: () => createPost(currentUser, context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Divider(height: 10.0,color: Color.fromRGBO(255, 255, 250, 0.0),),
        ],
      ),
    );
  }
}

createPost(User currentUser, context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bcx) => CreatePost()
  );
}