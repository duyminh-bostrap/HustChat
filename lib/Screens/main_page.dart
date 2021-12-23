// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/friends_list_container.dart';
import 'package:hust_chat/Screens/Search/user_search_info.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Profile/profile_screen.dart';
import 'package:hust_chat/Screens/NewsFeed/news_feed.dart';
import 'package:hust_chat/network_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'bad_connection.dart';


class MainPage extends StatefulWidget {
  int current_index;
  bool isProfile = false;
  MainPage(
      this.current_index,
      this.isProfile,
      {Key? key}
      );

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final List<Widget> screens = [
    // MessageScreen(), //Trang tin nhắn
    BadConnection(),
    FriendListContainer(), // Trang bạn bè
    NewsFeed(), // Trang chủ
    ProfileScreen(isProfile: false,), // Trang cá nhân
  ];
  _MainPageState({
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: greenColor,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                          controller: searchController,
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Tìm kiếm bạn bè",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 16.0),
                            // focusColor: Colors.red,
                            // icon: Icon(Icons.search, color: Colors.black54),
                          ),
                        )),
                    Expanded(
                      flex: 0,
                      child: IconButton(
                          icon: Icon(Icons.search, color: Colors.black54),
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowUserSearchInfo(
                                        textcontroller: searchController)));
                          }),
                    )
                  ],
                ),
              ),
            )),
        body: IndexedStack(index: widget.current_index, children: screens),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.current_index,
          onTap: (index) async => setState(() {
            widget.current_index = index;
          }),
          // selectedItemColor: Color(0xffaedd94),
          unselectedItemColor: Colors.white,
          selectedFontSize: 16,
          unselectedFontSize: 13,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.facebookMessenger, size: 30),
              label: 'Tin nhắn',
              backgroundColor: greenColor,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups, size: 34),
                label: 'Bạn bè',
                backgroundColor: pinkColor),
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
                backgroundColor: greenColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 32),
                label: 'Cá nhân',
                backgroundColor: pinkColor)
          ],
        ),
      ),
    );
  }
}

SearchFriend(TextEditingController searchController) async {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  if (token != null) {
    Map<String, String> data = {
      "keyword": searchController.text,
    };
    print(data);
    var response = await networkHandler.postAuth("/users/search", data, token);
    Map output = json.decode(response.body);
    print(response.statusCode);
    print(output["data"]);
  }
}

