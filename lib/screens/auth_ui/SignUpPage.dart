import '../../constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_app_2/widgets/topTitles.dart';
import 'package:ecommerce_app_2/constants/constants.dart';
import '../../firebaseAuth_helper/firebaseAuthHelper.dart';
import 'package:ecommerce_app_2/widgets/primaryButton.dart';
import 'package:ecommerce_app_2/widgets/custom_nav_bar.dart';
import 'package:ecommerce_app_2/screens/auth_ui/LoginPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool showPassword = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: kToolbarHeight - 10,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TopTitles(
                title: 'create account', subtitle: 'welcome to storlist '),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person), hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline), hintText: 'email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_outlined), hintText: 'phone'),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
              title: 'create account',
              onPressed: () async {
                bool isValidated = signUpValidation(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                    phoneController.text);
                if (isValidated) {
                  bool islogedIN = await FirebaseAuthHelper.instance.signUp(
                    emailController.text,
                    phoneController.text,
                    passwordController.text,
                    nameController.text,
                    context,
                  );
                  if (islogedIN) {
                    Routes.instance
                        .PushAndReplace(CustomBottomNavBar(), context);
                  }
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Center(child: Text("Already have an account?")),
          Center(
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'Login account',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Routes.instance.Push(const LoginPage(), context);
                }),
          )
        ],
      ),
    );
  }
}
