import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/AppProvider.dart';
import 'package:ecommerce_app_2/models/Order_Model.dart';
import 'package:ecommerce_app_2/models/productModel.dart';
import 'package:ecommerce_app_2/firebaseFirestoreHelper/firebaseFirestoreHelper.dart';

class OrderScreen extends StatelessWidget {
  // final ProductModel singleProduct;
  const OrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Orders',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
      body: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.GetUserOrderList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  print(orderModel.toString());
                  return ExpansionTile(
                    title: Container(
                      height: 130,
                      width: 100,
                      // color: Colors.amber,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.red.shade200, width: 2)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 130,
                            decoration:
                                BoxDecoration(color: Colors.red.shade100),
                            child: Image.network(
                              orderModel.products[0].img.toString(),
                              fit: BoxFit.contain,
                            ),
                          )),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        " ${orderModel.products[0].name}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      orderModel.products.length>1?SizedBox.fromSize() :Column(children: [
Text(
                                        "quantity: ${orderModel.products[0].qty}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      ],),
                                      // SizedBox(height: 5),
                                      Text(
                                        "price: ${orderModel.products[0].price}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        "total price: ${orderModel.totalPrice}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        "status: ${orderModel.status}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          orderModel.status,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
