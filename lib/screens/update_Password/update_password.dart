import 'package:flutter/material.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/constants/constants.dart';
import 'package:ecommerce_app_2/firebaseAuth_helper/firebaseAuthHelper.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController NewPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TopTitles(title: 'Update Password', subtitle: ''),
            ),
          ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: TextFormField(
          controller: oldPassController,
          decoration: InputDecoration(hintText: 'password'),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: TextFormField(
          controller: NewPassController,
          decoration: InputDecoration(hintText: 'Confirm password'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ElevatedButton(
            onPressed: () async {
              if (oldPassController.text == NewPassController.text) {
                showLoaderDialogue(context);
                FirebaseAuthHelper.instance
                    .UpdatePassword(NewPassController.text, context);
                Navigator.of(context).pop();
                showMessage('success!');
              } else {
                showLoaderDialogue(context);
               
                showMessage('password not match!');
                 Navigator.of(context).pop();
              }
            },
            child: const Text('update')),
      )
    ]));
  }
}
