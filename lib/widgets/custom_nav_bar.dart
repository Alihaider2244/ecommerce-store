import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ecommerce_app_2/screens/Home/HomePage.dart';
import 'package:ecommerce_app_2/screens/cart_Screen/cart_screen.dart';
import 'package:ecommerce_app_2/screens/OrderScreen/Order_screen.dart';
import 'package:ecommerce_app_2/screens/Favoyrite_Screen/favouritre_screen.dart';
import 'package:ecommerce_app_2/screens/cart_Screen/Profile_page/Profile_account.dart';

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  var index = 0;

  List<Widget> Screens = [
    const HomePage(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      //  Container(
      //   color: Colors.red,
        // child:
         Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(borderRadius: BorderRadius.circular(10),
            child: GNav(
                onTabChange: (value) {
                  // index++;
                  // print(value.toString());
                  setState(() {
                    index = value;
                  });
                },
                backgroundColor: Colors.black,
                activeColor: Colors.white,
                // tabBackgroundColor: Colors.white38,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabs: const [
                  GButton(
                    gap: 8,
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    gap: 8,
                    icon: Icons.shopping_cart,
                    text: 'cart',
                  ),
                  GButton(
                    gap: 8,
                    icon: Icons.favorite,
                    text: 'Fav',
                  ),
                  GButton(
                    gap: 8,
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ]),
          ),
        // ),
      ),
      body: Screens[index],
    );
  }
}

























// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:ecommerce_app_2/screens/Home/HomePage.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:ecommerce_app_2/screens/cart_Screen/cart_screen.dart';
// import 'package:material_color_utilities/material_color_utilities.dart';
// import 'package:material_color_utilities/material_color_utilities.dart';
// import 'package:ecommerce_app_2/screens/Favoyrite_Screen/favouritre_screen.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({
//     final Key? key,
//   }) : super(key: key);

//   @override
//   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   PersistentTabController _controller = PersistentTabController();
//   bool _hideNavBar = false;

//   List<Widget> _buildScreens() =>
//       [HomePage(), CartScreen(), FavouriteScreen(), FavouriteScreen()];

//   List<PersistentBottomNavBarItem> _navBarsItems() => [
//         PersistentBottomNavBarItem(
//             icon: const Icon(Icons.home),
//             title: "Home",
//             activeColorPrimary: Colors.blue,
//             inactiveColorPrimary: Colors.grey,
//             inactiveColorSecondary: Colors.purple),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.search),
//           title: "cart",
//           activeColorPrimary: Colors.teal,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.add),
//           title: "favorite",
//           activeColorPrimary: Colors.blueAccent,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.message),
//           title: "profile",
//           activeColorPrimary: Colors.deepOrange,
//           inactiveColorPrimary: Colors.grey,
//         ),
//       ];

//   @override
//   Widget build(final BuildContext context) => PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         resizeToAvoidBottomInset: true,
//         navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
//             ? 0.0
//             : kBottomNavigationBarHeight,
//         bottomScreenMargin: 0,
//         onWillPop: (final context) async {
//           await showDialog(
//             context: context!,
//             useSafeArea: true,
//             builder: (final context) => Container(
//               height: 50,
//               width: 50,
//               color: Colors.white,
//               child: ElevatedButton(
//                 child: const Text("Close"),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           );
//           return false;
//         },

//         backgroundColor: Colors.black,
//         hideNavigationBar: _hideNavBar,
//         decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
//         itemAnimationProperties: const ItemAnimationProperties(
//           duration: Duration(milliseconds: 400),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: const ScreenTransitionAnimation(
//           animateTabTransition: true,
//         ),
//         navBarStyle:
//             NavBarStyle.style1, // Choose the nav bar style with this property
//       );
// }
