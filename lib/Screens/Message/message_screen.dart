import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ' ;
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Message/chat_detail.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/background.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
//import 'package:hust_chat/Screens/Message/database_firebase.dart';

// chat use Firbase
class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class ListUserTile extends StatelessWidget  {

  CollectionReference user= FirebaseFirestore.instance.collection('users');
  final String name;
  final String uid;
  ListUserTile(@required this.uid,@required this.name);

  Future<String> getUserNameByUserId(String uid)async {
    await user.where('uid',isEqualTo: uid )
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((element) {
          return element['name'];
        });
      }
    }
    ).catchError((error){});
    return "null";
  }
  void callChatDetailScreen(BuildContext context, String name, String uid){
    Navigator.push(context,
    CupertinoPageRoute(builder: (context) => ChatDetail(
        friendName: name, friendUid: uid)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => callChatDetailScreen(context,name, uid),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: pinkColor,
                blurRadius: 1.0,
                offset: Offset(0.0,1.0),
              )
            ]
          ),
          child: Row(
            children: [
              Container(

                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/default-avater.jpg'),
                ),
              ),
              SizedBox(width: 10,),
              Row(
                children: [
                  Text(name,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _MessageScreenState extends State<MessageScreen> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference chatList = FirebaseFirestore.instance.collection(
      'chat_list');

  var chatListId = null;
  var notHaveMsg = false;

  @override
  void initState() {
    super.initState();
    // tim list chat .
    chatList.where('users', isEqualTo: {currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          chatListId = querySnapshot.docs.single.id;
        });
      }
    }
    ).catchError((error) {});
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return StreamBuilder<QuerySnapshot>(
        stream:chatList.doc(chatListId).collection('friends').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Some thing went wrong"),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Text("Loading"),
            );
          }

          if (snapshot.hasData){
            return  SafeArea(
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                   return ListUserTile(data['userId'].toString(),
                   data['userName'.toString()]);
                }).toList(),
              ),
            );
          }

          return Container();
        });
  }

}

