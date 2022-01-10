import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/models/user_for_firebase.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference chatList = FirebaseFirestore.instance.collection('chat_list');
  CollectionReference banList = FirebaseFirestore.instance.collection('ban_list');

  AppUser? _userFromFireBaseUser(User user){
    return user != null ? AppUser(userId: user.uid):null;
  }

  Future signInWithPhoneNumberAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      User? fireBaseUser = result.user;
      return _userFromFireBaseUser(fireBaseUser!);

    }
    catch (e){
      print(e.toString());
    }
  }


  Future signUpWithPhoneNumberAndPassword(String email, String password) async {
    try{
      await Firebase.initializeApp();
      UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User? fireBaseUser = result.user;

      //them list_chat nguoi dung
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      chatList.where('users',isEqualTo: {currentUserId:null})
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot){
        if (querySnapshot.docs.isEmpty){
          chatList.add({
            'users':{
              currentUserId: null,
            }
          });
        }
      }
      ).catchError((error){});

      //tao Ban_list
      banList.where('users',isEqualTo: {currentUserId:null})
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot){
        if (querySnapshot.docs.isEmpty){
          banList.add({
            'users':{
              currentUserId: null,
            }
          });
        }
      }
      ).catchError((error){});

      return _userFromFireBaseUser(fireBaseUser!);

    }
    catch (e){
      print(e.toString());
    }
  }

  Future signOut() async {
    try{
      return _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

  Future<String?> getCurrentUid() async{
    try{
      String uid = await FirebaseAuth.instance.currentUser!.uid;
      return uid;
    }
    catch(e){
      print(e.toString());
    }
  }
}
