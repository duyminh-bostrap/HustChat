// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/message_screen.dart';
import 'package:hust_chat/Screens/Profile/profile_screen.dart';
import 'package:hust_chat/Screens/NewsFeed/news_feed.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends StatefulWidget {
  int current_index;
  MainPage(
      this.current_index,
      {Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(current_index: current_index);
}

class _MainPageState extends State<MainPage> {
  int current_index;
  final List<Widget> screens = [
    MessageScreen(),// Trang tin nhắn
    Scaffold(),// Trang bạn bè
    NewsFeed(),// Trang chủ
    ProfileScreen(),// Trang cá nhân
  ];
  _MainPageState({
    Key? key,
    required this.current_index,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 10 , 0, 10),
          child: Container(
            padding: EdgeInsets.fromLTRB(50.0, 0.0, 10.0, 0.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.65),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Tìm kiếm bạn bè",
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0
                        ),
                        // focusColor: Colors.red,
                        // icon: Icon(Icons.search, color: Colors.black54),
                      ),
                    )
                ),
                Expanded(
                  flex: 0,
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.black54),
                    iconSize: 30.0,
                    onPressed: () => print('Search'),
                  ),
                )
              ],
            ),
          ),
        )
      ),
      body: IndexedStack(index: this.current_index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        onTap: (index) => setState(() => this.current_index = index),
        // selectedItemColor: Color(0xffaedd94),
        unselectedItemColor: Colors.white,
        selectedFontSize: 16,
        unselectedFontSize: 13,
        items: [
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.facebookMessenger,size: 32),
              label: 'Tin nhắn',
              backgroundColor: greenColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountGroupOutline, size: 32),
              label: 'Bạn bè',
              backgroundColor: pinkColor
          ),
          BottomNavigationBarItem(
              icon: RotationTransition(
                turns: AlwaysStoppedAnimation(330 / 360),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset(
                    'assets/watermelon1.png',
                    width: size.width * 0.08,
                  ),
                ),
              ),
              label: 'Bảng tin',
              backgroundColor: greenColor
          ),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountCircleOutline, size: 32),
              label: 'Cá nhân',
              backgroundColor: pinkColor
          )
        ],
      ),
    );
  }
}
