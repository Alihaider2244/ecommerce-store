import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app_2/firebaseAuth_helper/firebaseAuthHelper.dart';
// ignore: duplicate_import

final stream = FirebaseAuthHelper.instance.getAuthChange;
final FirebaseAuth auth = FirebaseAuth.instance;

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.lightBlue.shade200,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialogue(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 7,
              ),
              child: const Text('loading...'),
            )
          ],
        ),
      );
    }),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage('email and password can not be empty!');
    return false;
  } else if (email.isEmpty) {
    showMessage('email can not be empty!');
    return false;
  } else if (password.isEmpty) {
    showMessage('password can not be empty!');
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty) {
    showMessage('email and password can not be empty!');
    return false;
  } else if (email.isEmpty) {
    showMessage('email can not be empty!');
    return false;
  } else if (password.isEmpty) {
    showMessage('password can not be empty!');
    return false;
  } else if (phone.isEmpty) {
    showMessage('phone can not be empty!');
    return false;
  } else if (name.isEmpty) {
    showMessage('name can not be empty!');
    return false;
  } else {
    return true;
  }
}
