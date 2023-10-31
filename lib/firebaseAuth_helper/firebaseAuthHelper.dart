import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_2/constants/constants.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialogue(context);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
    }
    return false;
  }

  Future<bool> signUp(
      String email, String phone, String password, String name, context) async {
    try {
      showLoaderDialogue(context);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          img: null,
          name: name,
          email: email,
          phone: phone);
      firebaseFirestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
    }
    return false;
  }

  void signOut() async {
    await auth.signOut();
  }

  Future<bool> UpdatePassword(String password, context) async {
    try {
      showLoaderDialogue(context);
      auth.currentUser!.updatePassword(password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
    }
    return false;
  }
}
