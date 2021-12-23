import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/friends_list_container.dart';
import 'package:hust_chat/Screens/Friends/friends_profile.dart';
import 'package:hust_chat/Screens/NewsFeed/post_container.dart';
import 'package:hust_chat/Screens/change_pass_screen.dart';
import 'package:hust_chat/Screens/main_page.dart';
// import 'package:hust_chat/Screens/home_screen.dart';
import 'package:hust_chat/Screens/Message/message_screen.dart';
import 'package:hust_chat/Screens/NewsFeed/news_feed.dart';
import 'package:hust_chat/Screens/signup_screen.dart';
import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/data/data.dart';
import 'package:hust_chat/get_data/get_list_friend.dart';
import 'package:hust_chat/get_data/get_post.dart';
import 'Screens/blocklist_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/welcome_screen.dart';
import 'Screens/signup_screen.dart';
import 'Screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/mainpage': (context) => MainPage(0),
        '/message': (context) => MessageScreen(),
        '/blocklist': (context) => BlockListScreen(),
        '/changepass': (context) => ChangePassScreen(),
        '/post': (context) => ShowListFriendsRequested(),
        '/friendlist': (context) => MainPage(1),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginScreen(),
    );
  }
}
