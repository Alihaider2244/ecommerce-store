import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../widgets/primaryButton.dart';
import 'package:ecommerce_app_2/constants/routes.dart';
import 'package:ecommerce_app_2/widgets/cart_item.dart';
import 'package:ecommerce_app_2/Provider/AppProvider.dart';
import 'package:ecommerce_app_2/screens/chek_Out_screen/check_out_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 110,
        child: ListView(
          children: [
             Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${provider.totalPrice()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PrimaryButton(
                title: 'checkOut',
                onPressed: () {
                  // Routes.instance.Push(CheckOutScreen(singleProduct: ,), context);
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {   Navigator.of(context).pop();},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Cart Screen',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
      body: provider.getProductList.isEmpty
          ? const Center(
              child: Text(
                'Cart is Empty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: provider.productModelList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartItem(
                    productModel: provider.getProductList[index],
                  ),
                );
              }),
    );
  }
}
