// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/mytimeline');
                  },
                  child: Container(
                    // color: Colors.red,
                    height: 60,
                    width: 60,
                    // color: Colors.red,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/IMG_9119.JPG'),
                      // radius: 40,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/mytimeline');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          'Hoài Thu',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Xem trang cá nhân',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,),
                            // fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ]
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            padding: EdgeInsets.fromLTRB(1.0, 10.0, 10.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Column(
              children: [
              GestureDetector(
                onTap: () => print("Đổi mật khấu"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: size.width * 0.12,
                      height: size.height * 0.05,
                      child: Icon(MdiIcons.keyVariant, size: 30,color: Colors.black87),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(height: 10, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20,),
              GestureDetector(
                onTap: () => print("Người bị chặn"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: size.width * 0.12,
                      height: size.height * 0.05,
                      // color: Colors.green,
                      child: Icon(Icons.block, size: 30,color: Colors.black87),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Người bị chặn',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(height: 10, color: Colors.black54, thickness: 1.2, indent: 20, endIndent: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: size.width * 0.12,
                      height: size.height * 0.05,
                      // color: Colors.green,
                      child: Icon(Icons.logout, size: 30,color: Colors.black87),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Đăng xuất',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              ]
            )
          ),
          SizedBox(
            height: size.width * 0.60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Image.asset(
                  'assets/watermelon2.png',
                  width: size.width * 0.25,
                ),
              )
            ],
          ),
          SizedBox(
            height: size.width * 0.1,
          ),
        ],
      ),
      )
    );
  }
}
