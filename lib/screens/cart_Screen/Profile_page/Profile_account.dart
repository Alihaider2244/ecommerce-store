import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../update_Password/update_password.dart';
import 'package:ecommerce_app_2/constants/routes.dart';
import 'package:ecommerce_app_2/models/user_model.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import 'package:ecommerce_app_2/screens/cart_Screen/cart_screen.dart';
import 'package:ecommerce_app_2/screens/EditProfile/Edit_profile.dart';
import 'package:ecommerce_app_2/firebaseAuth_helper/firebaseAuthHelper.dart';
import 'package:ecommerce_app_2/screens/Favoyrite_Screen/favouritre_screen.dart';


class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({super.key});

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: kTextTabBarHeight,
          ),
          const Center(
            child: Text(
              'Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          CupertinoButton(
              onPressed: () {},
              child:
              //  const Icon(
              //   Icons.person,
              //   size: 100,
              // )),
              CircleAvatar(
    radius: 80, // Adjust the radius as needed
    backgroundColor: Colors.grey, // Background color for the avatar
    child: provider.getUserInformation.img == null
        ? const Icon(
            Icons.person,
            size: 100,
            color: Colors.white,
          )
        : ClipOval(
            child: Image.network(
              provider.getUserInformation.img.toString(),
              width: 160, // Adjust the width as needed
              height: 160, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
          ),
  ),),
          Center(
            child: Text(
              provider.getUserInformation.name.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              provider.getUserInformation.email.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              onPressed: () {
                Routes.instance.Push(const EditProfile(), context);
              },
              child: const Text('Edit Profile')),
          const SizedBox(
            height: 5,
          ),
          Column(
            children: [
              ListTile(
                onTap: () {
                  Routes.instance.Push(const CartScreen(), context);
                },
                leading: CupertinoButton(
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    onPressed: () {}),
                title: const Text(
                  'Your Order',
                ),
              ),
              ListTile( onTap: () {
                  Routes.instance.Push(const FavouriteScreen(), context);
                },
                leading: CupertinoButton(
                    child: const Icon(Icons.favorite), onPressed: () {}),
                title: const Text('Favourite'),
              ),
              ListTile( onTap: () {
                  Routes.instance.Push(const ProfileAccountScreen(), context);
                },
                leading:
                    CupertinoButton(child: const Icon(Icons.info_outline), onPressed: () {}),
                title: const Text('About Us'),
              ),
              ListTile( onTap: () {
                  Routes.instance.Push(const CartScreen(), context);
                },
                leading: CupertinoButton(
                    child: const Icon(Icons.support_outlined), onPressed: () {}),
                title: const Text('Support'),
              ),
                ListTile( onTap: () {
                  Routes.instance.Push( UpdatePasswordScreen(), context);
                },
                leading: CupertinoButton(
                    child: const Icon(Icons.lock_outline_rounded), onPressed: () {}),
                title: const Text('Change password'),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuthHelper.instance.signOut();
                  setState(() {});
                },
                leading: CupertinoButton(
                    child: const Icon(Icons.logout),
                    onPressed: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    }),
                title: const Text('Log out'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
