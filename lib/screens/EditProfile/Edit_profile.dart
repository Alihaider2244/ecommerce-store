import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_2/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecommerce_app_2/constants/constants.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import '../../constants/FirestoreHelper/FirestoreHelper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  String? _imagePath;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    String? userimg = provider.getUserInformation.img.toString();
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          CupertinoButton(
            onPressed: () {
              _pickImage();
            },
            child: CircleAvatar(
              radius: 80, // Adjust the radius as needed
              backgroundColor: Colors.pink, // Background color for the avatar
              child: _imagePath == null
                  ? const Icon(
                      Icons.camera_alt,
                      size: 100,
                      color: Colors.white,
                    )
                  : ClipOval(
                      child: Image.file(
                        File(_imagePath.toString()),
                        width: 160, // Adjust the width as needed
                        height: 160, // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextFormField(
              controller: nameController,
              decoration:
                  InputDecoration(hintText: provider.getUserInformation.name),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(
                onPressed: () async {
                  UserModel userModel = provider.getUserInformation
                      .copywith(name: nameController.text);
                  provider.updateUserInformation(
                      context, userModel, _imagePath!);
                  // showMessage('Successfully updated');
                },
                child: const Text('update')),
          )
        ],
      ),
    );
  }
}
