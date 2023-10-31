import 'constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebaseAuth_helper/firebaseAuthHelper.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import 'package:ecommerce_app_2/constants/webOptions.dart';
import 'package:ecommerce_app_2/widgets/custom_nav_bar.dart';
import 'package:ecommerce_app_2/screens/auth_ui/Welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: webkey.apiKey,
          appId: webkey.appId,
          messagingSenderId: webkey.messagingSenderId,
          projectId: webkey.projectId));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Flutter e-commerce App',
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomBottomNavBar();
              } else {
                return WelCome();
              }
            }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
