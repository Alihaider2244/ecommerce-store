import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app_2/constants/routes.dart';
import 'package:ecommerce_app_2/constants/constants.dart';
import 'package:ecommerce_app_2/models/productModel.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import 'package:ecommerce_app_2/screens/cart_Screen/cart_screen.dart';
import 'package:ecommerce_app_2/screens/chek_Out_screen/check_out_screen.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var quantity = 1;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    AppProvider provider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () {
                    Routes.instance.Push(CartScreen(), context);
                  },
                  icon: const Icon(Icons.shopping_cart)),
            ],
          ),
          Image.network(widget.singleProduct.img.toString()),
          SizedBox(
            height: height * .02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.singleProduct.name.toString(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFave =
                            !widget.singleProduct.isFave;
                      });
                      if (widget.singleProduct.isFave) {
                        provider.AddToFavList(widget.singleProduct);
                      } else {
                        provider.RemoveFromFavList(widget.singleProduct);
                      }
                    },
                    icon: widget.singleProduct.isFave
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border_outlined)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.singleProduct.description.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (quantity >= 1) {
                        quantity--;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_rounded,
                    color: Colors.red,
                    size: 40,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.red,
                    size: 40,
                  )),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Width * .4,
                    child: OutlinedButton(
                      onPressed: () {
                        AppProvider appProvider =
                            Provider.of<AppProvider>(context, listen: false);
                        ProductModel productModel =
                            widget.singleProduct.copywith(qty: quantity);
                        appProvider.AddProductToList(productModel);
                        showMessage('Added to Cart');
                      },
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(color: Colors.red),
                      ),
                    )),
                SizedBox(
                    width: Width * .4,
                    child: ElevatedButton(
                        onPressed: () {
                          ProductModel productModel =
                              widget.singleProduct.copywith(qty: quantity);

                          showMessage('Added to cart');
                          Routes.instance.Push(
                              CheckOutScreen(singleProduct: productModel),
                              context);
                        },
                        child: const Text('BUY')))
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          )
        ],
      ),
    );
  }
}
