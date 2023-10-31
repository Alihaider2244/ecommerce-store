import 'package:flutter/widgets.dart';

class AssetImages {
  static AssetImages instance = AssetImages();

  static const String imagepath = 'assets/images';

  final String welcomeimage = '$imagepath/login.jpg';
  final String google = '$imagepath/google.png';
  final String facebook = '$imagepath/facebook.png';
}
