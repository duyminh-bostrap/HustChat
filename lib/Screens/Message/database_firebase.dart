import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  // Tim ten qua Seatch Bar
  Future<Stream<QuerySnapshot>> getUserByUserName(String username)async {
    return await FirebaseFirestore.instance.collection("users")
        .where("name", isEqualTo:  username)
        .snapshots();
  }

  // Dang ky thong tin nguoi dungtren Database
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap);
  }


}