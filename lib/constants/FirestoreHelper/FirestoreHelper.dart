import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecommerce_app_2/constants/constants.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://ecommerceapp-d4ca1.appspot.com');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadImage(String imagePath) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        // User not logged in
        return null;
      }

      final String userID = currentUser.uid;
      final File imageFile =
          File(imagePath); // Convert the string path to a File
      final TaskSnapshot taskSnapshot =
          await storage.ref(userID).putFile(imageFile);
      final String imgUrl = await taskSnapshot.ref.getDownloadURL();
      showMessage('updated');
      return imgUrl;
      
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}
