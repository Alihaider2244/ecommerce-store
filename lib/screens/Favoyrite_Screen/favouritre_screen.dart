import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import 'package:ecommerce_app_2/widgets/favourite_item.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Favourite Items',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
      body: provider.FavouriteList.isEmpty
          ? const Center(
              child: Text(
                'Fav is Empty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: provider.getFavouriteList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FavItem(
                    productModel: provider.getFavouriteList[index],
                  ),
                );
              }),
    );
  }
}
