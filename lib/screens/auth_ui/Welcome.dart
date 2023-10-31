import '../../constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/widgets/AssetsImages.dart';
import 'package:ecommerce_app_2/widgets/primaryButton.dart';
import 'package:ecommerce_app_2/screens/auth_ui/LoginPage.dart';
import 'package:ecommerce_app_2/screens/auth_ui/SignUpPage.dart';


class WelCome extends StatelessWidget {
  const WelCome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: kTextTabBarHeight,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                title: 'Welcome',
                subtitle: 'Buy here anything you want',
              )
            ],
          ),
          Image.asset(AssetImages.instance.welcomeimage),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => {},
                  child: Image.asset(AssetImages.instance.google, scale: 10)),
              const SizedBox(width: 10),
              CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => {},
                  child: Image.asset(AssetImages.instance.facebook, scale: 15)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            title: 'Login',
            onPressed: () {
              Routes.instance.Push(LoginPage(), context);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            title: 'Sign up',
            onPressed: () {
              Routes.instance.Push(SignupPage(), context);
            },
          )
        ],
      ),
    );
  }
}
