import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hust_chat/models/user_for_firebase.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
