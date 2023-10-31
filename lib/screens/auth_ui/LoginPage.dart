import '../../constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/constants/constants.dart';
import 'package:ecommerce_app_2/screens/Home/HomePage.dart';
import 'package:ecommerce_app_2/widgets/primaryButton.dart';
import 'package:ecommerce_app_2/screens/auth_ui/SignUpPage.dart';
import 'package:ecommerce_app_2/firebaseAuth_helper/firebaseAuthHelper.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namewordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight - 10,
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TopTitles(
                title: 'Welcom', subtitle: 'Good to see you here again! '),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              // obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline), hintText: 'email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: showPassword,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  hintText: 'password'),
            ),
          ),
          PrimaryButton(
            title: 'Login',
            onPressed: () async {
              bool isValidated = loginValidation(
                  emailController.text.toString(),
                  passwordController.text.toString());
              if (isValidated) {
                bool islogedIN = await FirebaseAuthHelper.instance.login(
                    emailController.text.toString(),
                    passwordController.text.toString(),
                    
                    context);
                if (islogedIN) {
                  Routes.instance.PushAndReplace(HomePage(), context);
                }
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const Center(child: Text("don't have account?")),
          Center(
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'create account',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Routes.instance.Push(const SignupPage(), context);
                }),
          )
        ],
      ),
    );
  }
}
