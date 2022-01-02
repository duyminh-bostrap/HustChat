import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/Screens/Message/chat_detail.dart';

// chat use Firbase
class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class ListUserTile extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String uid;
  ListUserTile(@required this.name, @required this.phoneNumber, @required this.uid);

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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Image.asset("assets/default-avater.jpg"),
              Text(name),
              Text(phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}


class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where('uid',isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot == null){
          return Center(
            child: Text("Loading"),
          );
        }

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
                return ListUserTile(data['name'].toString(),
                    data['phone_nummber'].toString(),
                    data['uid'].toString());

              }).toList(),
            ),
          );
        }
        return Container();
    });
  }
}
