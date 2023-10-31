import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app_2/models/productModel.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';

class FavItem extends StatefulWidget {
  final ProductModel productModel;
  FavItem({super.key, required this.productModel});

  @override
  State<FavItem> createState() => _FavItemState();
}

class _FavItemState extends State<FavItem> {
  int quantity = 1;
  @override
  void initState() {
    quantity = widget.productModel.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 100,
      // color: Colors.amber,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.red.shade200, width: 2)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 130,
            decoration: BoxDecoration(color: Colors.red.shade100),
            child: Image.network(
              widget.productModel.img.toString(),
              fit: BoxFit.contain,
            ),
          )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            widget.productModel.name.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '\$${widget.productModel.price.toString()}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                if (quantity >= 1) {
                                  quantity--;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.remove_circle_rounded,
                              color: Colors.red,
                              size: 28,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: const Icon(
                              Icons.add_circle_rounded,
                              color: Colors.red,
                              size: 28,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              AppProvider appProvider =
                                  Provider.of<AppProvider>(context,
                                      listen: false);
                              appProvider.RemoveFromFavList(
                                  widget.productModel);
                              showMessage('Removed from Fav');
                              widget.productModel.isFave = false;
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 0, left: 14.0),
                              child: Text(
                                'remove from wishlist',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
