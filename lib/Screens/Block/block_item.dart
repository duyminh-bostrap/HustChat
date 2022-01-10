import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hust_chat/Screens/Widget/color.dart';
import 'package:hust_chat/Screens/Widget/profile_avatar.dart';

String link = dotenv.env['link'] ?? "";

class BlockItem extends StatefulWidget {
  final String name;
  final String uid;
  final String phone;
  final String currentUid;
  final String banId;
  const BlockItem({Key? key,required this.name, required this.uid,
    required this.phone, required this.currentUid, required this.banId}) : super(key: key);

  @override
  _BlockItemState createState() => _BlockItemState(name,uid,phone,currentUid,banId);
}

class _BlockItemState extends State<BlockItem> {
  final String name;
  final String uid;
  final String phone;
  final String currentUid;
  final String banId;
  _BlockItemState(this.name, this.uid, this.phone, this.currentUid, this.banId);
  CollectionReference banList = FirebaseFirestore.instance.collection('ban_list');

  var docId;
  @override
  void initState() {
    super.initState();
    banList.doc(banId).collection('users')
        .where('userId',isEqualTo: uid)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot){
      if (querySnapshot.docs.isNotEmpty){
        setState(() {
          docId = querySnapshot.docs.single.id;
        });
      }
    }
    ).catchError((error){});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => UnBlockFriend(context,uid,currentUid,banId,docId),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.0,
                offset: Offset(0.0,1.0),
              )
            ]
        ),
        child:  Row(
          children: [
            Container(
              child: ProfileAvatar(
                imageUrl: link,
                hasBorder: true,
              ),
            ),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}

Future UnBlockFriend(BuildContext context,String friendId, String currentId, String banId, String docId) async {
  Size size = MediaQuery.of(context).size;
  CollectionReference banList = FirebaseFirestore.instance.collection('ban_list');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: 130,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black87,),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Container(
              width: size.width*0.6,
              height: 50,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                'Bạn có chắc chắn muốn bỏ chặn người dùng này?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,

                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await banList.doc(banId).collection('users').doc(docId).delete();

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: size.width*0.3,
                    margin: EdgeInsets.fromLTRB(9, 5, 4, 5),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: pinkColor,
                      // border: Border.all(color: Colors.black87,),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      'Bỏ chặn',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,

                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: size.width*0.3,
                    margin: EdgeInsets.fromLTRB(4, 5, 9, 5),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87,),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      'Trở lại',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,

                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

