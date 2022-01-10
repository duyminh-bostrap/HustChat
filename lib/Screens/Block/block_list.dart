import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


class ListUserTile extends StatelessWidget  {

  CollectionReference user= FirebaseFirestore.instance.collection('users');
  final String name;
  final String uid;
  final String phone;
  ListUserTile(@required this.uid,@required this.name,@required this.phone);

  // Future<String> getUserNameByUserId(String uid)async {
  //   await user.where('uid',isEqualTo: uid )
  //       .limit(1)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     if (querySnapshot.docs.isNotEmpty) {
  //       querySnapshot.docs.forEach((element) {
  //         return element['name'];
  //       });
  //     }
  //   }
  //   ).catchError((error){});
  //   return "null";
  // }
  // void callChatDetailScreen(BuildContext context, String name, String uid,String phone){
  //   Navigator.push(context,
  //       CupertinoPageRoute(builder: (context) => ChatDetail(
  //           friendName: name, friendUid: uid)));
  // }


  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () =>UnBlockFriend(name),
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
              SizedBox(width: 15,),
              Column(
                children: [
                  Text(name,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text(phone,style: TextStyle(
                    fontSize: 15,
                    //fontWeight: FontWeight.bold,
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

// Future UnBlockFriend(String name) async {
//   Size size = MediaQuery.of(context).size;
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       backgroundColor: Colors.transparent,
//       content: Container(
//         height: 130,
//         width: size.width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black87,),
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: size.width*0.6,
//               height: 50,
//               alignment: Alignment.center,
//               margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Text(
//                 'Bạn có chắc chắn muốn chặn người dùng này?',
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 16,
//
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     height: 40,
//                     width: size.width*0.3,
//                     margin: EdgeInsets.fromLTRB(9, 5, 4, 5),
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: pinkColor,
//                       // border: Border.all(color: Colors.black87,),
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                     child: Text(
//                       'Chặn',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 16,
//
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: (){
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     height: 40,
//                     width: size.width*0.3,
//                     margin: EdgeInsets.fromLTRB(4, 5, 9, 5),
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black87,),
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                     child: Text(
//                       'Trở lại',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 16,
//
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }




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
                        ListUserTile(data['userId'].toString(),
                            data['userName'.toString()],
                            data['userPhoneNumber'].toString()),
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
