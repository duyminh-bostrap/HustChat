import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Friends/search_users.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/get_data/get_user_info.dart';
import 'package:hust_chat/models/models.dart';

class ShowUserSearchInfo extends StatelessWidget {
  ShowUserSearchInfo({
    Key? key,
    required this.textcontroller,
  }) : super(key: key);
  TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tìm kiếm',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder<List<UserData>>(
        future: UsersApi.getUsersData(textcontroller),
        builder: (context, snapshot) {
          final users = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                    color: pinkColor,
                  ));
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                return
                  CustomScrollView(
                    slivers: [
                      users!.length != 0?
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final UserData user = users[index];
                            return SearchUsers(userData: user,);
                          },
                          childCount: users.length,
                        ),
                      )
                      : SliverToBoxAdapter(
                        child:
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            'Không có tìm kiếm phù hợp',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                          child:
                          SizedBox(height: 20,)
                      ),
                    ],
                  );
              }
          }
        },
      ),
    );
  }
}