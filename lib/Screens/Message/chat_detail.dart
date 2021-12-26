import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';

class ChatDetail extends StatefulWidget {
  final String friendUid;
  final String friendName;
  const ChatDetail({Key? key,required this.friendUid,required this.friendName}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState(friendUid,friendName);
}

class _ChatDetailState extends State<ChatDetail> {

  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final String friendUid;
  final String friendName;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var chatDocId;
  var _textController = new TextEditingController();
  _ChatDetailState(this.friendUid, this.friendName);
  //Kiem tra xem co chat truoc do khong

  @override
  void initState() {
    super.initState();
    chats.where('users',isEqualTo: {friendUid:null, currentUserId: null})
    .limit(1)
    .get()
    .then((QuerySnapshot querySnapshot){
      if (querySnapshot.docs.isNotEmpty){
        chatDocId = querySnapshot.docs.single.id;
      } else{
        chats.add({
          'users':{
            currentUserId: null,
            friendUid: null,
          }
        }).then((value) => {
          chatDocId = value
        });
      }
    }
    ).catchError((error){});
  }

  void sendMassage (String msg){
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid':currentUserId,
      'msg':msg
    }).then((value){
      _textController.text = '';
    });
  }

  bool isSender ( String friend){
    return friend == currentUserId;
  }

  Alignment getAlignment(friend){
    if (friend == currentUserId){
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .doc(chatDocId)
            .collection("messages")
            .orderBy('createdOn',descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Some thing went wrong"),
            );
          }

          // if(snapshot.connectionState == ConnectionState.waiting){
          //   return Center(
          //     child: Text("Loading"),
          //   );
          // }

          if (snapshot.hasData){

            return  CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(previousPageTitle: "Back",
              middle: Text(friendName),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                child: Icon(CupertinoIcons.phone),
              ),
              ),

              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        reverse: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document){
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                           return Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                             child: ChatBubble(
                               clipper: ChatBubbleClipper6(
                                 nipSize: 0,
                                 radius: 0,
                                 type: BubbleType.receiverBubble,
                               ),
                               alignment: getAlignment(data['uid'].toString()),
                               margin: EdgeInsets.only(top: 20),
                               backGroundColor: isSender(data['uid'].toString())
                               ? Color(0xFF08C187)
                               :Color (0xffE7E7ED),
                               child: Container(
                                 constraints: BoxConstraints(
                                   maxWidth: MediaQuery.of(context).size.width * 0.7,
                                 ),
                                 child: Column(
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Text(data['msg'].toString(),style: TextStyle(
                                           color: isSender(data['uid'].toString())
                                           ? Colors.white
                                           :Colors.black,
                                         fontSize: 14),

                                         maxLines: 100,
                                           overflow: TextOverflow.clip,)
                                       ],
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       children: [
                                         Text(
                                           data['createdOn'] == null ?
                                               DateTime.now().toString() :
                                               data['createdOn'] .toDate()
                                               .toString(),
                                           style: TextStyle(
                                             fontSize: 10,
                                             color: isSender(data['uid'].toString())
                                               ?Colors.white : Colors.black
                                           ),
                                         )
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           );
                        }).toList(),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: CupertinoTextField(controller: _textController,)),
                      CupertinoButton(
                        child: Icon(Icons.send_sharp),
                        onPressed: () => sendMassage(_textController.text),
                      )
                    ],)
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}

