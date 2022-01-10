import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Block/block_item.dart';
import 'package:hust_chat/Screens/Message/chat_detail.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
//import 'package:hust_chat/Screens/Message/database_firebase.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({Key? key}) : super(key: key);

  @override
  _BlockScreenState createState() => _BlockScreenState();
}


class _BlockScreenState extends State<BlockScreen> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference banList = FirebaseFirestore.instance.collection(
      'ban_list');

  var banListId = null;

  @override
  void initState() {
    super.initState();
    // tim list ban .
    banList.where('users', isEqualTo: {currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          banListId = querySnapshot.docs.single.id;
        });
      }
    }
    ).catchError((error) {});
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream:banList.doc(banListId).collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Some thing went wrong"),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center();
          }

          if (snapshot.hasData){
            return  Scaffold(
              appBar: AppBar(
                backgroundColor: greenColor,
                title: Text('Danh sách chặn'),
              ),
              body: SafeArea(
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Column(
                      children: [
                        SizedBox(height: 10,),
                        BlockItem(uid: data['userId'].toString(),
                            name: data['userName'.toString()],
                            phone: data['userPhoneNumber'].toString(),
                            currentUid: currentUserId,
                            banId: banListId),
                        SizedBox(height: 10,),
                        Center(
                          child: Text("Ấn vào người dùng để bỏ chặn"),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }

          return Container();
        });
  }
}
